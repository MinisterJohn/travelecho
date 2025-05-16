import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../auth_exports.dart';

abstract class AuthApiService {
  Future<Either<String, Map<String, dynamic>>> signin(SigninReqParams params);
  Future<Either<String, Map<String, dynamic>>> signup(SignupReqParams params);
  Future<Either<String, bool>> sendOtp(String email);
  Future<Either<String, bool>> verifyOtp(String email, String otp);
  Future<Either<String, Map<String, dynamic>>> resetPassword(
      String email, String password, String confirmPassword);
  Future<Either<String, Map<String, dynamic>>> getUserProfile();
}

class AuthApiServiceImpl implements AuthApiService {
  final DioClient _dioClient = sl<DioClient>();
  final SharedPreferences _prefs = sl<SharedPreferences>();
  final Logger _logger = sl<Logger>();

  AuthApiServiceImpl();

  String _handleError(DioException e) {
    _logger.e('Dio Error: ${e.type} - ${e.message}');
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return "The server is taking too long to respond. Please check your internet connection and try again.";
      case DioExceptionType.connectionError:
        return "No internet connection. Please check your network and try again.";
      case DioExceptionType.badResponse:
        if (e.response?.statusCode == 500) {
          return "Server error. Our team has been notified. Please try again later.";
        }
        final message = e.response?.data?["message"];
        if (message != null) return message.toString();
        return "Server error (${e.response?.statusCode}). Please try again later.";
      default:
        return "An unexpected error occurred. Please try again.";
    }
  }

  void _validateSigninParams(SigninReqParams params) {
    final data = params.toMap();
    if (data['email'] == null || data['email'].toString().isEmpty) {
      _logger.e('Email is required');
      throw Exception('Email is required');
    }
    if (data['password'] == null || data['password'].toString().isEmpty) {
      _logger.e('Password is required');
      throw Exception('Password is required');
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> signin(
      SigninReqParams params) async {
    try {
      _validateSigninParams(params);
      _logger.i('Attempting to sign in with email: ${params.email}');

      final response = await _dioClient.post(
        ApiUrl.fullUrl(ApiUrl.signinURL),
        data: params.toMap(),
      );

      if (response.statusCode == 401) {
        _logger.w('Invalid credentials for email: ${params.email}');
        return const Left("Invalid email or password");
      } else if (response.statusCode == 404) {
        _logger.w('User not found for email: ${params.email}');
        return const Left("User not found");
      } else if (response.statusCode == 400) {
        _logger.w('Bad request: ${response.data["message"]}');
        return const Left("Invalid request format");
      } else if (response.statusCode != 200) {
        _logger.w('Login failed with status: ${response.statusCode}');
        return const Left("Login failed. Please try again.");
      }

      final data = response.data;
      if (data == null ||
          !data.containsKey('success') ||
          !data.containsKey('user')) {
        _logger.e('Invalid response format: $data');
        return const Left("Server returned invalid data format");
      }

      final Map userData = data['user'];
      if (!userData.containsKey('token')) {
        _logger.e('Missing token in response');
        return const Left("Authentication data not found in response");
      }
      _logger.i(userData);

      // Store user data in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', userData['_id']);
      await prefs.setBool('verified', userData['verified']);
      await prefs.setString('token', userData['token']);
      await prefs.setString('name', userData['name']);
      await prefs.setString('email', userData['email']);
      await prefs.setString('plan', userData['plan'] ?? 'FREE');
      await prefs.setString('role', userData['role']);
      await prefs.setBool('is_not_new_user', true);

      // Save profile object as JSON string

      await prefs.setString('profile', jsonEncode(userData['profile']));

      _logger.i('Successfully signed in user');
      return Right(data);
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      _logger.e('Unexpected error during signin: ${e.toString()}');
      return const Left("An unexpected error occurred during signin");
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> signup(
      SignupReqParams params) async {
    try {
      _logger.i('Attempting to sign up with email: ${params.email}');
      final response = await _dioClient.post(
        ApiUrl.fullUrl(ApiUrl.signupURL),
        data: params.toMap(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _logger.i('Successfully signed up user: ${params.email}');
        return Right(response.data);
      } else {
        _logger.w(
            'Signup failed with status: ${response.statusCode}, ${response.data["message"]?.toString()}');
        return const Left("Signup failed. Please try again.");
      }
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      _logger.e('Unexpected error during signup: ${e.toString()}');
      return const Left("Unexpected error during signup");
    }
  }

  @override
  Future<Either<String, bool>> sendOtp(String email) async {
    try {
      _logger.i('Sending OTP to email: $email');
      final response = await _dioClient.post(
        ApiUrl.fullUrl(ApiUrl.sendOtpURL),
        data: {'email': email},
      );

      if (response.statusCode == 200) {
        _logger.i('OTP sent successfully to: $email');
        return const Right(true);
      } else {
        _logger.w('Failed to send OTP: ${response.data["message"]}');
        return const Left("Failed to send OTP");
      }
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      _logger.e('Unexpected error sending OTP: ${e.toString()}');
      return const Left("Failed to send OTP");
    }
  }

  @override
  Future<Either<String, bool>> verifyOtp(String email, String otp) async {
    try {
      _logger.i('Verifying OTP for email: $email');
      final response = await _dioClient.post(
        ApiUrl.fullUrl(ApiUrl.verifyOtpURL),
        data: {'email': email, 'otp': otp},
      );

      if (response.statusCode == 200) {
        _logger.i('OTP verified successfully for: $email');
        return const Right(true);
      } else {
        _logger.w('OTP verification failed: ${response.data["message"]}');
        return const Left("Failed to verify OTP");
      }
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      _logger.e('Unexpected error verifying OTP: ${e.toString()}');
      return const Left("Failed to verify OTP");
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> resetPassword(
      String email, String password, String confirmPassword) async {
    try {
      _logger.i('Attempting to reset password for: $email');
      final response = await _dioClient.post(
        ApiUrl.fullUrl(ApiUrl.resetPasswordURL),
        data: {
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
        },
      );

      if (response.statusCode == 200) {
        _logger.i('Password reset successful for: $email');
        return Right(response.data);
      } else if (response.statusCode == 400) {
        _logger.w('Password reset failed: ${response.data["message"]}');
        return const Left('Failed to reset password');
      } else {
        _logger.w('Password reset failed with status: ${response.statusCode}');
        return const Left('Failed to reset password');
      }
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      _logger.e('Unexpected error resetting password: ${e.toString()}');
      return const Left('Failed to reset password');
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> getUserProfile() async {
    try {
      _logger.i('Fetching user profile');
      final token = _prefs.getString('token');

      if (token == null || token.isEmpty) {
        _logger.e('No token found for profile request');
        return const Left('Authentication token not found');
      }

      _logger.i('Using token: ${token.substring(0, 10)}...');
      final response = await _dioClient.get(
        ApiUrl.fullUrl(ApiUrl.userProfileURL),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 403) {
        _logger.w('Access forbidden - token might be invalid or expired');
        // Clear the invalid token
        await _prefs.remove('token');
        return const Left('Your session has expired. Please login again.');
      }

      if (response.statusCode == 200) {
        final profileData = response.data;
        if (profileData == null || !profileData.containsKey('profile')) {
          _logger.e('Invalid profile data format: $profileData');
          return const Left('Invalid profile data format');
        }

        _logger.i('Successfully fetched user profile');
        return Right(profileData);
      } else {
        _logger.w('Failed to fetch profile: ${response.data["message"]}');
        return const Left("Failed to fetch profile");
      }
    } on DioException catch (e) {
      _logger.e('DioException in getUserProfile: ${e.type} - ${e.message}');
      if (e.response?.statusCode == 403) {
        _logger.w('Access forbidden - token might be invalid or expired');
        // Clear the invalid token
        await _prefs.remove('token');
        return const Left('Your session has expired. Please login again.');
      }
      return Left(_handleError(e));
    } catch (e) {
      _logger.e('Unexpected error fetching profile: ${e.toString()}');
      return const Left("Failed to fetch profile");
    }
  }
}
