import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../auth_exports.dart';

abstract class AuthApiService {
  Future<Either> signin(SigninReqParams params);
  // Future<Either> login(String email, String password);
  Future<Either> signup(SignupReqParams params);
  // Future<Either> resetPassword(String email);
}

class AuthApiServiceImpl implements AuthApiService {
  final Dio dio;

  AuthApiServiceImpl() : dio = Dio() {
    // Configure Dio with increased timeouts
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.sendTimeout = const Duration(seconds: 30);

    // Configure response validation
    dio.options.validateStatus = (status) {
      return status! >= 200 && status < 300;
    };
  }

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

  Map<String, dynamic> _validateSigninParams(dynamic params) {
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
    return data;
  }

  @override
  Future<Either> signin(SigninReqParams params) async {
    try {
      // Validate parameters before making the request
      _validateSigninParams(params);

      final response = await dio.post(
        "https://travel-echo-backend.onrender.com/api/auth/login",
        data: params.toMap(),
        options: Options(
          validateStatus: (status) {
            return status != null && status < 500;
          },
          sendTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      );

      print("Signin Response Status: ${response.statusCode}"); // Debug log
      print("Signin Response Data: ${response.data}"); // Debug log

      // Check for specific error status codes
      if (response.statusCode == 401) {
        return const Left("Invalid email or password");
      } else if (response.statusCode == 404) {
        return const Left("User not found");
      } else if (response.statusCode == 400) {
        return Left(response.data["message"] ?? "Invalid request format");
      } else if (response.statusCode != 200) {
        return Left(
          response.data["message"] ?? "Login failed. Please try again.",
        );
      }

      // Validate response data structure
      final data = response.data;
      if (data == null ||
          !data.containsKey('success') ||
          !data.containsKey('user')) {
        print("Invalid response format: $data"); // Debug log
        return const Left("Server returned invalid data format");
      }

      if (data['user'] == null || !data['user'].containsKey('token')) {
        print("Missing user data or token: $data"); // Debug log
        return const Left("Authentication data not found in response");
      }

      return Right(data);
    } on DioException catch (e) {
      print("Signin API Error: ${e.message}");
      print("Response Data: ${e.response?.data}");
      print("Status Code: ${e.response?.statusCode}");

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return const Left(
          "The server is taking too long to respond. Please try again in a few moments.",
        );
      }

      return Left(_handleError(e));
    } catch (e) {
      print("Unexpected Error during signin: $e"); // Debug log
      return Left(e.toString());
    }
  }

  @override
  Future<Either> signup(SignupReqParams params) async {
    try {
      print("Signup Request Data: ${params.toMap()}"); // Debug log

      final response = await dio.post(
        "https://travel-echo-backend.onrender.com/api/auth/register",
        data: params.toMap(),
        options: Options(
          validateStatus: (status) {
            return status != null && status < 500;
          },
          sendTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      );

      if (response.statusCode == 200) {
        print("Signup Success Response: ${response.data}");
        return Right(response.data);
      } else {
        print("Signup Error Response: ${response.data}");
        return Left(
          response.data["message"] ?? "Signup failed. Please try again.",
        );
      }
    } on DioException catch (e) {
      print("Signup API Error: ${e.message}");
      print("Response Data: ${e.response?.data}");
      print("Status Code: ${e.response?.statusCode}");

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return const Left(
          "The server is taking too long to respond. Please try again in a few moments.",
        );
      }

      return Left(_handleError(e));
    } catch (e) {
      print("Unexpected Error: $e");
      return Left(e.toString());
    }
  }

  // @override
  // Future<Either> resetPassword(String email) async {
  //   await sl<DioClient>().post('/auth/reset-password', data: {'email': email});
  // }
}
