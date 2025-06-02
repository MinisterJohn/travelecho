import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../auth_exports.dart';
import 'dart:convert';
import 'package:logger/logger.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _authApiService = sl<AuthApiService>();
  final Logger _logger = sl<Logger>();

  @override
  Future<Either<String, Map<String, dynamic>>> signin(
      SigninReqParams params) async {
    try {
      final result = await _authApiService.signin(params);
      _logger.i(result);
      return result.fold(
        (error) {
          _logger.e('Signin Error: $error');
          return Left('Signin Error: $error');
        },
        (data) async {
          // if (data == null || !(data is Map) || data['user'] == null) {
          //   _logger.e('Signin Error: Invalid or missing user data in response.');
          //   return Left('Signin Error: Invalid or missing user data in response.');
          // }

          // if (data['user'] == null) {
          //   _logger.e('Signin Error: Missing user data in response.');
          //   return Left('Signin Error: Missing user data in response.');
          // }

          if (data['navigateToVerification'] == true) {
            // Send OTP if email is not verified
            final otpResult = await sendOtp(params.email);
            return otpResult.fold(
              (otpError) {
                _logger.e('OTP Error: $otpError');
                return Left(
                    'Signin successful but failed to send OTP: $otpError');
              },
              (_) {
                _logger.i('OTP sent successfully to: ${params.email}');
                return Right({
                  'email': params.email,
                  'navigateToVerification': true,
                });
              },
            );
          }

          // if (data == null || !(data is Map) || data['user'] == null) {
          //   _logger.e('Signin Error: Invalid or missing user data in response.');
          //   return Left('Signin Error: Invalid or missing user data in response.');
          // }
          // Fetch and save user profile
          return Right(data);
        },
      );
    } catch (e) {
      _logger.e('Signin Error: ${e.toString()}');
      return Left('Signin Error: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> signup(
      SignupReqParams params) async {
    var data = await _authApiService.signup(params);

    return data.fold((error) {
      _logger.e('Signup Error: $error');
      return Left(error);
    }, (data) async {
      try {
        _logger.i('Signup Response Data: $data');

        // Send OTP after successful signup using the email from params
        final otpResult = await sendOtp(params.email);
        return otpResult.fold(
          (error) {
            _logger.e('OTP Error: $error');
            return Left('Signup successful but failed to send OTP: $error');
          },
          (_) {
            _logger.i('OTP sent successfully to: ${params.email}');
            return Right({'email': params.email, 'isSignup': true});
          },
        );
      } catch (e) {
        _logger.e('Signup Process Error: ${e.toString()}');
        return Left('Signup Process Error: ${e.toString()}');
      }
    });
  }

  @override
  Future<Either<String, bool>> sendOtp(String email) async {
    try {
      _logger.i('Sending OTP to email: $email');
      final response = await _authApiService.sendOtp(email);
      return response;
    } catch (e) {
      _logger.e('Error sending OTP: $e');
      _logger.e('Error type: ${e.runtimeType}');
      return Left('Error sending OTP: $e.toString()');
    }
  }

  @override
  Future<Either<String, bool>> verifyOtp(String email, String otp) async {
    try {
      final response = await _authApiService.verifyOtp(email, otp);
      return response;
    } catch (e) {
      _logger.e('Verify OTP Error: ${e.toString()}');
      return Left('Verify OTP Error: ${e.toString()}');
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    if (token == null) return false;
    return true;
  }

  // ignore: non_constant_identifier_names
  @override
  Future<bool> isNotNewUser() async {
    late SharedPreferences sharedPreferences;

    sharedPreferences = await SharedPreferences.getInstance();
    bool? isNotNewUser = sharedPreferences.getBool('is_not_new_user');
    if (isNotNewUser == null) return false;
    return isNotNewUser;
  }

  @override
  Future<Either<String, Map<String, dynamic>>> resetPassword(
      String email, String password, String confirmPassword) async {
    try {
      return await _authApiService.resetPassword(
          email, password, confirmPassword);
    } catch (e) {
      _logger.e('Reset Password Error: ${e.toString()}');
      return Left('Reset Password Error: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> getUserProfile() async {
    try {
      final result = await _authApiService.getUserProfile();
      return result.fold(
        (error) {
          _logger.e('Get User Profile Error: $error');
          return Left(error);
        },
        (data) async {
          // Save profile data to SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('user_profile', jsonEncode(data));
          return Right(data);
        },
      );
    } catch (e) {
      _logger.e('Get User Profile Error: ${e.toString()}');
      return Left('Get User Profile Error: ${e.toString()}');
    }
  }
}
