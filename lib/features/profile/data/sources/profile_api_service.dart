import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../profile_exports.dart';

abstract class ProfileApiService {
  Future<Either<String, Profile>> getUserProfile();
  Future<Either<String, Profile>> updateUserProfile(Map<String, dynamic> data);
Future<Either<String, Map<String, dynamic>>> updateProfileImage(
    FormData formData);
}

class ProfileApiServiceImpl implements ProfileApiService {
  final DioClient _dioClient;
  final SharedPreferences _prefs;
  // kIsWeb ? ImageHandlerWeb() :
  final ImageHandler _imageHandler =  ImageHandlerMobile();

  ProfileApiServiceImpl(this._dioClient, this._prefs);

  Future<Options> _getOptions() async {
    final token = _prefs.getString('token');
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
  Future<Either<String, Profile>> getUserProfile() async {
    try {
      final options = await _getOptions();
      final response = await _dioClient.get(
        "${ApiUrl.fullUrl(ApiUrl.userProfileURL)}?populate=user",
        options: options,
      );

      print('API Response data: ${response.data}');
      if (response.statusCode == 200) {
        final profileData = response.data['profile'];
        print('Profile data before parsing: $profileData');
        return Right(Profile.fromJson(profileData));
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
  Future<Either<String, Profile>> updateUserProfile(
      Map<String, dynamic> data) async {
    try {
      final options = await _getOptions();
      final response = await _dioClient.put(
        ApiUrl.fullUrl(ApiUrl.userProfileURL),
        data: data,
        options: options,
      );

      if (response.statusCode == 200) {
        return Right(Profile.fromJson(response.data['profile']));
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
    FormData formData) async {
    final token = _prefs.getString('token');

  try {
    final response = await Dio().put(
      ApiUrl.fullUrl(ApiUrl.userProfileImageURL),
      data: formData,
      options: Options(
        headers: {
          "Content-Type": "multipart/form-data",
          // Add auth header if needed
          "Authorization": "Bearer $token",
        },
      ),
    );

    if (response.statusCode == 200 && response.data['success'] == true) {
      return Right(response.data['image'] as Map<String, dynamic>);
    } else {
      return Left("Failed to upload image");
    }
  } catch (e) {
    return Left(e.toString());
  }
}
}
