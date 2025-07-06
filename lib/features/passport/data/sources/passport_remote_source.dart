import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dartz/dartz.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../passport_exports.dart';

class TravelDocumentRemoteDataSourceImpl
    implements TravelDocumentRemoteDataSource {
  final DioClient dio = sl<DioClient>();
  final Logger logger = Logger();
  final SharedPreferences _prefs = sl<SharedPreferences>();

  TravelDocumentRemoteDataSourceImpl();

  Future<Options> _getOptions() async {
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

  String _handleError(DioException e) {
    try {
      final data = e.response?.data;
      if (data is Map) {
        // Prefer top-level message
        if (data.containsKey('message') && data['message'] != null) {
          return data['message'].toString();
        }
        // Check for nested errors array
        if (data.containsKey('data') &&
            data['data'] is Map &&
            (data['data'] as Map).containsKey('errors')) {
          final errors = (data['data']['errors']);
          if (errors is List &&
              errors.isNotEmpty &&
              errors[0]['message'] != null) {
            return errors[0]['message'].toString();
          }
        }
      }
    } catch (_) {}
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.sendTimeout:
        return 'Send timeout. Please try again.';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout. Please try again.';
      case DioExceptionType.badResponse:
        return e.response?.data['message'] ?? 'An error occurred.';
      case DioExceptionType.cancel:
        return 'Request cancelled.';
      default:
        return 'An unexpected error occurred.';
    }
  }

  /// Create a new passport
  @override
  Future<Either<String, TravelDocumentModel>> createTravelDocument(
    TravelDocumentParams passport,
  ) async {
    try {
      final storedUserId = _prefs.getString('user_id');
      if (storedUserId == null || storedUserId.isEmpty) {
        logger.e("User ID is null or empty. Cannot create passport.");
        return const Left(
          'User ID is required to create a passport. Please log in again.',
        );
      }
      final options = await _getOptions();
      final response = await dio.post(
        ApiUrl.passportURL,
        data: {"user": storedUserId, ...passport.toJson()},
        options: options,
      );
      logger.i(
        "TravelDocument created successfully: ${response.data["passport"]}",
      );
      return Right(TravelDocumentModel.fromJson(response.data["passport"]));
    } on DioException catch (e) {
      logger.e("Error creating passport: ${_handleError(e)}");
      return Left(_handleError(e));
    } catch (e) {
      logger.e("Unexpected error: $e");
      return Left("An unexpected error occurred: $e");
    }
  }

  /// Update a passport
  @override
  Future<Either<String, TravelDocumentModel>> updateTravelDocument(
    String id,
    TravelDocumentParams passport,
  ) async {
    try {
      final storedUserId = _prefs.getString('user_id');
      final options = await _getOptions();
      final response = await dio.put(
        ApiUrl.dynamicTravelDocumentURL(id),
        data: {"user": storedUserId, ...passport.toJson()},
        options: options,
      );
      return Right(TravelDocumentModel.fromJson(response.data["passport"]));
    } on DioException catch (e) {
      logger.e("Error updating passport ($id): ${_handleError(e)}");
      return Left(_handleError(e));
    } catch (e) {
      logger.e("Unexpected error: $e");
      return Left("An unexpected error occurred: $e");
    }
  }

  /// Delete a passport
  @override
  Future<Either<String, void>> deleteTravelDocument(String id) async {
    try {
      final options = await _getOptions();
      final response = await dio.delete(
        ApiUrl.dynamicTravelDocumentURL(id),
        options: options,
      );
      logger.i("TravelDocument deleted: $response");
      return const Right(null);
    } on DioException catch (e) {
      logger.e("Error deleting passport ($id): ${_handleError(e)}");
      return Left(_handleError(e));
    } catch (e) {
      logger.e("Unexpected error: $e");
      return Left("An unexpected error occurred: $e");
    }
  }

  /// Get all passports
  @override
  Future<Either<String, List<TravelDocumentModel>>> getAllTravelDocuments({
    String? sort,
    required int limit,
    required int skip,
  }) async {
    try {
      final options = await _getOptions();
      final response = await dio.get(
        ApiUrl.passportURL,
        queryParameters: {
          'sort': sort ?? 'desc',
          'limit': limit > 0 ? limit : 10,
          'skip': skip > 0 ? skip : 0,
        },
        options: options,
      );
      logger.i("All passports: ${response.data}");
      final passportsData = response.data["passports"];
      print("Printed passports $passportsData");
      if (passportsData is List) {
        final passports =
            passportsData
                .map((passport) => TravelDocumentModel.fromJson(passport))
                .toList();
        return Right(passports);
      } else {
        logger.e("No passports found in response: ${response.data}");
        return const Right(<TravelDocumentModel>[]);
      }
    } on DioException catch (e) {
      logger.e("Error fetching all passports: ${_handleError(e)}");
      return Left(_handleError(e));
    } catch (e) {
      logger.e("Unexpected error: $e");
      return Left("An unexpected error occurred: $e");
    }
  }

  /// Get a passport by ID
  @override
  Future<Either<String, TravelDocumentModel>> getTravelDocumentById(
    String id,
  ) async {
    try {
      final options = await _getOptions();
      final response = await dio.get(
        ApiUrl.dynamicTravelDocumentURL(id),
        options: options,
      );
      return Right(TravelDocumentModel.fromJson(response.data));
    } on DioException catch (e) {
      logger.e("Error fetching passport by ID ($id): ${_handleError(e)}");
      return Left(_handleError(e));
    } catch (e) {
      logger.e("Unexpected error: $e");
      return Left("An unexpected error occurred: $e");
    }
  }

  /// Upload passport image(s)
  @override
  Future<Either<String, String>> uploadTravelDocumentImages({
    required String passportId,
    required dynamic filePath,
  }) async {
    try {
      final options = await _getOptions();
      final headers = options.headers ?? {};

      final uri = Uri.parse(
        ApiUrl.fullUrl(ApiUrl.dynamicTravelDocumentImageUploadURL(passportId)),
      );
      final request = http.MultipartRequest('PUT', uri);

      // Add headers from Dio Options
      request.headers.addAll(headers.map((k, v) => MapEntry(k, v.toString())));
      logger.i('Uploading passport image for passport ID: $passportId');

      for (var path in filePath) {
        final file = await http.MultipartFile.fromPath(
          'passportImages', // plural name
          path,
        );
        request.files.add(file);
      }
      // request.fields['passportId'] = passportId;
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      print('image response $response');
      if (response.statusCode == 200) {
        final data = jsonDecode(responseBody);
        print(data);
        return Right('Success');
      } else {
        try {
          final errorData = jsonDecode(responseBody);
          return Left(errorData['message'] ?? 'Upload failed');
        } catch (_) {
          return Left('Upload failed with status: ${response.statusCode}');
        }
      }
    } catch (e) {
      return Left('Unexpected error: $e');
    }
  }
}
