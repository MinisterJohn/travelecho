import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../../auth_exports.dart';

class AuthApiServiceUtils {
  final Logger logger;
  AuthApiServiceUtils(this.logger);

  String handleError(DioException e) {
    logger.e('Dio Error: ${e.type} - ${e.message}');
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return "The server is taking too long to respond. Please check your internet connection and try again.";
      case DioExceptionType.connectionError:
        return "No internet connection. Please check your network and try again.";
      case DioExceptionType.badResponse:
        if (e.response?.statusCode == 500) {
          logger.e('Server error details: ${e.response?.data}');
          return "Server error. Our team has been notified. Please try again later.";
        }
        if (e.response?.statusCode == 503) {
          return "The server is currently unavailable (503). Please try again later.";
        }
        final message = e.response?.data?["message"];
        if (message != null) return message.toString();
        return "Server error (${e.response?.statusCode}). Please try again later.";
      default:
        return "An unexpected error occurred. Please try again.";
    }
  }

  void validateSigninParams(SigninReqParams params) {
    final data = params.toMap();
    if (data['email'] == null || data['email'].toString().isEmpty) {
      logger.e('Email is required');
      throw Exception('Email is required');
    }
    if (data['password'] == null || data['password'].toString().isEmpty) {
      logger.e('Password is required');
      throw Exception('Password is required');
    }
  }
}