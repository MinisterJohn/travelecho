import 'package:dio/dio.dart';

abstract class AppException implements Exception {
  final String message;
  final int? code;

  AppException(this.message, {this.code});

  @override
  String toString() => '$runtimeType: $message (code: $code)';
}

class ServerException extends AppException {
  ServerException(super.message, {super.code});
}

class CacheException extends AppException {
  CacheException(super.message);
}

class NetworkException extends AppException {
  NetworkException(super.message);
}

class UnauthorizedException extends AppException {
  UnauthorizedException([super.message = 'Unauthorized'])
      : super(code: 401);
}

class NotFoundException extends AppException {
  NotFoundException([super.message = 'Resource not found'])
      : super(code: 404);
}

class TimeoutException extends AppException {
  TimeoutException([super.message = 'Request timeout']);
}

class UnknownException extends AppException {
  UnknownException([super.message = 'Unknown error occurred']);
}

/// Parses DioException into appropriate AppExceptions
AppException handleDioException(DioException e) {
  if (e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.receiveTimeout ||
      e.type == DioExceptionType.sendTimeout) {
    return TimeoutException();
  }

  if (e.type == DioExceptionType.badResponse) {
    final statusCode = e.response?.statusCode ?? 0;
    final message = e.response?.data['message']?.toString() ??
        e.message ??
        'Something went wrong';

    switch (statusCode) {
      case 400:
        return ServerException(message, code: 400);
      case 401:
        return UnauthorizedException(message);
      case 404:
        return NotFoundException(message);
      default:
        return ServerException(message, code: statusCode);
    }
  }

  if (e.type == DioExceptionType.cancel) {
    return NetworkException('Request cancelled');
  }

  if (e.type == DioExceptionType.unknown) {
    return NetworkException('No internet or unknown network issue');
  }

  return UnknownException('Unhandled Dio error');
}
