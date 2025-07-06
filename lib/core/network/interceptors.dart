import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/features_exports.dart';

/// This interceptor is used to show request and response logs
class LoggerInterceptor extends Interceptor {
  Logger logger = Logger(
    printer: PrettyPrinter(methodCount: 0, colors: true, printEmojis: true),
  );

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final requestPath = '${options.baseUrl}${options.path}';
    logger.e('${options.method} request ==> $requestPath'); //Error log
    logger.d(
      'Error type: ${err.error} \n '
      'Error message: ${err.message}',
    ); //Debug log
    handler.next(err); //Continue with the Error
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath = '${options.baseUrl}${options.path}';
    logger.i('${options.method} request ==> $requestPath'); //Info log
    handler.next(options); // continue with the Request
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d(
      'STATUSCODE: ${response.statusCode} \n '
      'STATUSMESSAGE: ${response.statusMessage} \n'
      'HEADERS: ${response.headers} \n'
      'Data: ${response.data}',
    ); // Debug log
    handler.next(response); // continue with the Response
  }
}

class TokenRefreshInterceptor extends Interceptor {
  final Dio _dio;
  bool _isRefreshing = false;
  final List<RequestOptions> _requestsQueue = [];

  TokenRefreshInterceptor(this._dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final options = err.requestOptions;

      // If we're already refreshing the token, queue this request
      if (_isRefreshing) {
        _requestsQueue.add(options);
        return;
      }

      _isRefreshing = true;
      try {
        // Get the stored token
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token');

        if (token == null) {
          // No token available, clear the queue and reject all requests
          _requestsQueue.clear();
          _isRefreshing = false;
          return handler.next(err);
        }

        // Try to refresh the token
        final response = await _dio.post(
          'https://travel-echo-backend.onrender.com/api/auth/refresh-token',
          data: {'token': token},
        );

        if (response.statusCode == 200) {
          // Update the stored token
          final newToken = response.data['token'];
          await prefs.setString('token', newToken);

          // Update the request's authorization header
          options.headers['Authorization'] = 'Bearer $newToken';

          // Retry the original request
          try {
            final retryResponse = await _dio.fetch(options);
            handler.resolve(retryResponse);
          } catch (e) {
            handler.next(err);
          }

          // Process queued requests
          while (_requestsQueue.isNotEmpty) {
            final queuedOptions = _requestsQueue.removeAt(0);
            queuedOptions.headers['Authorization'] = 'Bearer $newToken';
            try {
              await _dio.fetch(queuedOptions);
            } catch (e) {
              // Handle failed queued requests
              print('Failed to retry queued request: $e');
            }
          }
        } else {
          // Token refresh failed, clear the queue and reject all requests
          _requestsQueue.clear();
          handler.next(err);
        }
      } catch (e) {
        // Token refresh failed, clear the queue and reject all requests
        _requestsQueue.clear();
        handler.next(err);
      } finally {
        _isRefreshing = false;
      }
    } else {
      handler.next(err);
    }
  }
}

class UnauthorizedInterceptor extends Interceptor {
  final Dio _dio;

  UnauthorizedInterceptor(this._dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Clear stored tokens
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('user_id');

      // Cancel all pending requests
      _dio.close();

      // Check auth status
      sl<AuthBloc>().add(CheckAuthStatus());

      return handler.reject(err);
    }
    return handler.next(err);
  }
}

// class AuthorizationInterceptor extends Interceptor {

  // @override
  // void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
  //   final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   final token  = sharedPreferences.getString('token');
  //   options.headers['Authorization'] = "Bearer $token";
  //   handler.next(options); // continue with the Request
  // }
// }