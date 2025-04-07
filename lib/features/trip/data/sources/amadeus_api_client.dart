import 'package:dio/dio.dart';
import 'dart:math';

class AmadeusApiService {
  final Dio _dio = Dio();
  String? _accessToken;
  DateTime? _tokenExpiry;
  int _retryCount = 0;
  static const int maxRetries = 3;

  // Cache for airline information

  AmadeusApiService() {
    _dio.options.baseUrl = "https://test.api.amadeus.com/";
    _dio.options.headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    // Add interceptor for better error handling
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (DioException e, ErrorInterceptorHandler handler) async {
        if (e.response?.statusCode == 429) {
          // Rate limit exceeded
          if (_retryCount < maxRetries) {
            _retryCount++;
            final backoffTime = Duration(seconds: pow(2, _retryCount).toInt());
            print(
                "Rate limit exceeded. Retrying in ${backoffTime.inSeconds} seconds (attempt $_retryCount of $maxRetries)");
            await Future.delayed(backoffTime);
            try {
              final response = await _dio.fetch(e.requestOptions);
              return handler.resolve(response);
            } catch (error) {
              if (error is DioException) {
                return handler.next(error);
              }
              return handler.next(DioException(
                requestOptions: e.requestOptions,
                error: error,
              ));
            }
          }
        } else if (e.response?.statusCode == 503 && _retryCount < maxRetries) {
          _retryCount++;
          final backoffTime = Duration(seconds: pow(2, _retryCount).toInt());
          print(
              "Service unavailable. Retrying in ${backoffTime.inSeconds} seconds (attempt $_retryCount of $maxRetries)");
          await Future.delayed(backoffTime);
          try {
            final response = await _dio.fetch(e.requestOptions);
            return handler.resolve(response);
          } catch (error) {
            if (error is DioException) {
              return handler.next(error);
            }
            return handler.next(DioException(
              requestOptions: e.requestOptions,
              error: error,
            ));
          }
        }
        print("API Error: ${e.message}");
        if (e.response != null) {
          print("Error Response: ${e.response?.data}");
        }
        return handler.next(e);
      },
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        print("Request: ${options.method} ${options.uri}");
        return handler.next(options);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        print(
            "Response: ${response.statusCode} ${response.requestOptions.uri}");
        _retryCount = 0;
        return handler.next(response);
      },
    ));
  }

  Future<void> _getToken() async {
    if (_accessToken != null &&
        _tokenExpiry != null &&
        DateTime.now().isBefore(_tokenExpiry!)) {
      return;
    }

    try {
      const String clientId = "I3w76NykBMzRKV55AHRBWVhDS8KB8fKZ";
      const String clientSecret = "PkTAtKAb1UZGbk6m";

      final tokenDio = Dio();
      tokenDio.options.headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "Accept": "application/json",
      };

      final formData = {
        "grant_type": "client_credentials",
        "client_id": clientId,
        "client_secret": clientSecret,
      };

      final response = await tokenDio.post(
        "https://test.api.amadeus.com/v1/security/oauth2/token",
        data: formData,
        options: Options(
          validateStatus: (status) => true, // Accept all status codes
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode != 200) {
        print("Token Response Error: ${response.statusCode}");
        print("Token Response Data: ${response.data}");
        throw Exception("Failed to get API token: ${response.statusCode}");
      }

      _accessToken = response.data["access_token"];
      _tokenExpiry =
          DateTime.now().add(Duration(seconds: response.data["expires_in"]));

      _dio.options.headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $_accessToken"
      };
    } catch (e) {
      print("Token Error: $e");
      if (e is DioException) {
        print("Dio Error Response: ${e.response?.data}");
      }
      throw Exception("Failed to get API token: $e");
    }
  }

  Future<Response> get(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      await _getToken();
      return await _dio.get(
        endpoint,
        queryParameters: params,
        options: Options(
          validateStatus: (status) => true, // Accept all status codes
          headers: {
            "Accept": "application/json",
          },
        ),
      );
    } catch (e) {
      print("API Error: $e");
      if (e is DioException) {
        print("Dio Error Response: ${e.response?.data}");
        if (e.response?.statusCode == 503) {
          throw Exception(
              "Service temporarily unavailable. Please try again later.");
        }
      }
      rethrow;
    }
  }

  /// Makes a POST request to the Amadeus API
  ///
  /// [endpoint] - The API endpoint to call
  /// [data] - The data to send in the request body
  /// [params] - Optional query parameters
  ///
  /// Returns a [Response] object from Dio
  Future<Response> post(String endpoint,
      {dynamic data, Map<String, dynamic>? params}) async {
    try {
      await _getToken();
      return await _dio.post(
        endpoint,
        data: data,
        queryParameters: params,
        options: Options(
          validateStatus: (status) => true, // Accept all status codes
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
      );
    } catch (e) {
      print("API Error: $e");
      if (e is DioException) {
        print("Dio Error Response: ${e.response?.data}");
        if (e.response?.statusCode == 503) {
          throw Exception(
              "Service temporarily unavailable. Please try again later.");
        }
      }
      rethrow;
    }
  }

  // Helper method to get airline information with caching
}
