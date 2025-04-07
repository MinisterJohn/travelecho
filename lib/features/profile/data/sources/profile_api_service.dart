import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProfileApiService {
  Future<Either<String, Map<String, dynamic>>> getProfile(String profileId);
  Future<Either<String, Map<String, dynamic>>> updateProfile(
      String profileId, Map<String, dynamic> data);
  Future<Either<String, Map<String, dynamic>>> updateProfileImage(
      String profileId, File imageFile);
}

class ProfileApiServiceImpl implements ProfileApiService {
  final Dio _dio;
  final SharedPreferences _prefs;

  ProfileApiServiceImpl(this._dio, this._prefs);

  Future<String?> _getToken() async {
    return _prefs.getString('token');
  }

  Future<Options> _getOptions() async {
    final token = await _getToken();
    return Options(
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
  }

  String _handleError(DioException e) {
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

  @override
  Future<Either<String, Map<String, dynamic>>> getProfile(
      String profileId) async {
    try {
      if (profileId.isEmpty) {
        return const Left('Profile ID is required');
      }

      final options = await _getOptions();
      final response = await _dio.get(
        'https://travel-echo-backend.onrender.com/api/profiles/$profileId',
        options: options,
      );

      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        return Left(response.data['message'] ?? 'Failed to get profile');
      }
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left('An unexpected error occurred: $e');
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> updateProfile(
      String profileId, Map<String, dynamic> data) async {
    try {
      if (profileId.isEmpty) {
        return const Left('Profile ID is required');
      }

      final options = await _getOptions();
      final response = await _dio.put(
        'https://travel-echo-backend.onrender.com/api/profiles/$profileId',
        data: data,
        options: options,
      );

      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        return Left(response.data['message'] ?? 'Failed to update profile');
      }
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left('An unexpected error occurred: $e');
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> updateProfileImage(
      String profileId, File imageFile) async {
    try {
      if (profileId.isEmpty) {
        return const Left('Profile ID is required');
      }

      final token = await _getToken();
      final options = Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        },
      );

      final formData = FormData.fromMap({
        'image': MultipartFile.fromBytes(
          await imageFile.readAsBytes(),
          filename: imageFile.path.split('/').last.replaceAll(" ", "_"),
        ),
      });

      final response = await _dio.post(
        'https://travel-echo-backend.onrender.com/api/profiles/image/$profileId',
        data: formData,
        options: options,
      );

      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        return Left(
            response.data['message'] ?? 'Failed to update profile image');
      }
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left('An unexpected error occurred: $e');
    }
  }
}
