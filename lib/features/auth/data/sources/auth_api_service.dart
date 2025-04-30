import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:travelecho/core/network/dio_client.dart';
import '../../auth_exports.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthApiService {
  Future<Either> signin(SigninReqParams params);
  // Future<Either> login(String email, String password);
  Future<Either> signup(SignupReqParams params);
  // Future<Either> resetPassword(String email);
  Future<Either<String, bool>> sendOtp(String email);
  Future<Either<String, bool>> verifyOtp(String email, String otp);
  Future<Either> resetPassword(
      String email, String password, String confirmPassword);
}

class AuthApiServiceImpl implements AuthApiService {
  final DioClient _dioClient;
  final SharedPreferences _prefs;

  AuthApiServiceImpl()
      : _dioClient = GetIt.I<DioClient>(),
        _prefs = GetIt.I<SharedPreferences>();

  String _handleError(DioException e) {
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
        // Try to get the error message from the response
        final message = e.response?.data?["message"];
        if (message != null) return message.toString();
        return "Server error (${e.response?.statusCode}). Please try again later.";
      default:
        return "An unexpected error occurred. Please try again.";
    }
  }

  void _validateSigninParams(SigninReqParams params) {
    if (params is! SigninReqParams) {
      throw Exception('Invalid parameter type');
    }
    final data = params.toMap();
    if (data['email'] == null || data['email'].toString().isEmpty) {
      throw Exception('Email is required');
    }
    if (data['password'] == null || data['password'].toString().isEmpty) {
      throw Exception('Password is required');
    }
  }

  @override
  Future<Either> signin(SigninReqParams params) async {
    try {
      _validateSigninParams(params);

      final response = await _dioClient.post(
        "https://travel-echo-backend.onrender.com/api/auth/login",
        data: params.toMap(),
      );

      if (response.statusCode == 401) {
        return const Left("Invalid email or password");
      } else if (response.statusCode == 404) {
        return const Left("User not found");
      } else if (response.statusCode == 400) {
        return Left(response.data["message"] ?? "Invalid request format");
      } else if (response.statusCode != 200) {
        return Left(
            response.data["message"] ?? "Login failed. Please try again.");
      }

      final data = response.data;
      if (data == null ||
          !data.containsKey('success') ||
          !data.containsKey('user')) {
        return const Left("Server returned invalid data format");
      }

      if (data['user'] == null || !data['user'].containsKey('token')) {
        return const Left("Authentication data not found in response");
      }

      return Right(data);
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> signup(SignupReqParams params) async {
    try {
      final response = await _dioClient.post(
        "https://travel-echo-backend.onrender.com/api/auth/register",
        data: params.toMap(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(response.data);
      } else {
        return Left(
            response.data["message"] ?? "Signup failed. Please try again.");
      }
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  // @override
  // Future<Either> resetPassword(String email) async {
  //   await sl<DioClient>().post('/auth/reset-password', data: {'email': email});
  // }

  @override
  Future<Either<String, bool>> sendOtp(String email) async {
    try {
      final response = await _dioClient.post(
        'https://travel-echo-backend.onrender.com/api/auth/verification/send-otp',
        data: {'email': email},
      );

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(response.data["message"] ?? "Failed to send OTP");
      }
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> verifyOtp(String email, String otp) async {
    try {
      final response = await _dioClient.post(
        'https://travel-echo-backend.onrender.com/api/auth/verification/verify',
        data: {'email': email, 'otp': otp},
      );

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(response.data["message"] ?? "Failed to verify OTP");
      }
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> resetPassword(
      String email, String password, String confirmPassword) async {
    try {
      final response = await _dioClient.post(
        'https://travel-echo-backend.onrender.com/api/auth/recovery/reset-password',
        data: {
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
        },
      );

      if (response.statusCode == 200) {
        return Right(response.data);
      } else if (response.statusCode == 400) {
        return Left(response.data['message'] ?? 'Failed to reset password');
      } else {
        return Left(response.data['message']);
      }
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left('Failed to reset password: $e');
    }
  }
}
