import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../auth_exports.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _authApiService = sl<AuthApiService>();
  @override
  Future<Either> signin(SigninReqParams params) async {
    var data = await _authApiService.signin(params);

    return data.fold((error) {
      return Left(error);
    }, (data) {
      return Right(data);
    });
  }

  @override
  Future<Either> signup(SignupReqParams params) async {
    var data = await _authApiService.signup(params);

    return data.fold((error) {
      print('Signup Error: $error');
      return Left(error);
    }, (data) async {
      try {
        print('Signup Response Data: $data');

        // Send OTP after successful signup using the email from params
        final otpResult = await sendOtp(params.email);
        return otpResult.fold(
          (otpResponse) {
            print('OTP Response: $otpResponse');
            // Return the email for navigation to verification page
            return Right({'email': params.email, 'isSignup': true});
          },
          (error) {
            print('OTP Error: $error');
            return Left('Signup successful but failed to send OTP: $error');
          },
        );
      } catch (e) {
        print('Signup Process Error: $e');
        return Left('Error during signup process: ${e.toString()}');
      }
    });
  }

  @override
  Future<Either<String, bool>> sendOtp(String email) async {
    try {
      print('Sending OTP to email: $email');
      final response = await _authApiService.sendOtp(email);
      return response;
    } catch (e) {
      print('Error sending OTP: $e');
      print('Error type: ${e.runtimeType}');
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> verifyOtp(String email, String otp) async {
    try {
      final response = await _authApiService.verifyOtp(email, otp);
      return response;
    } catch (e) {
      return Left(e.toString());
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
  Future<Either> resetPassword(
      String email, String password, String confirmPassword) async {
    try {
      final result =
          await _authApiService.resetPassword(email, password, confirmPassword);
      return result.fold(
        (error) => Left(error),
        (data) => Right(data),
      );
    } catch (e) {
      return Left(e.toString());
    }
  }
}
