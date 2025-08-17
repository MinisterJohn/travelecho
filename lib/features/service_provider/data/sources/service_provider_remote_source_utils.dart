import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../service_provider_exports.dart';

class ServiceProviderApiServiceUtils {
  final Logger logger = Logger();
  final _prefs = sl<SharedPreferences>();
  ServiceProviderApiServiceUtils();

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

  Future<Options> getOptions() async {
    final token = _prefs.getString('token');
    if (token == null || token.isEmpty) {
      throw Exception('Authorization token is missing. Please log in again.');
    }
    return Options(
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
  }

  void validateServiceProviderParams(ServiceProviderParams params) {
    final data = params.toJson();
    final car = data['car'] as Map<String, dynamic>?;
    if (car == null) {
      logger.e('Car details are required');
      throw Exception('Car details are required');
    }
    if (car['make'] == null || car['make'].toString().isEmpty) {
      logger.e('Car make is required');
      throw Exception('Car make is required');
    }
    if (car['model'] == null || car['model'].toString().isEmpty) {
      logger.e('Car model is required');
      throw Exception('Car model is required');
    }
    if (car['year'] == null || car['year'].toString().isEmpty) {
      logger.e('Car year is required');
      throw Exception('Car year is required');
    }
    if (car['color'] == null || car['color'].toString().isEmpty) {
      logger.e('Car color is required');
      throw Exception('Car color is required');
    }
    if (car['licensePlate'] == null || car['licensePlate'].toString().isEmpty) {
      logger.e('License plate is required');
      throw Exception('License plate is required');
    }
  }
}
