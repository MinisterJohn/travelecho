import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../milestones_exports.dart';

abstract class LevelRemoteDataSource {
  Future<Either<String, List<dynamic>>> getEarnedBadges();
  Future<Either<String, Map<String, dynamic>>> getNextLevelBadges();
}

class LevelRemoteDataSourceImpl implements LevelRemoteDataSource {
  final DioClient _dioClient = sl<DioClient>();
  final SharedPreferences _prefs = sl<SharedPreferences>();
  final logger = sl<Logger>();

  LevelRemoteDataSourceImpl();

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
  Future<Either<String, List<dynamic>>> getEarnedBadges() async {
    try {
      final options = await _getOptions();
      final response = await _dioClient.get(
        ApiUrl.earnedBadgesURL,
        options: options,
      );
      logger.i(response);

      if (response.statusCode == 200) {
        return Right(response.data['earnedBadges'] ?? []);
      } else {
        return Left(
          response.data['message'] ?? 'Failed to fetch earned badges',
        );
      }
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left('An unexpected error occurred: $e');
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> getNextLevelBadges() async {
    try {
      final options = await _getOptions();
      final response = await _dioClient.get(
        ApiUrl.nextLevelBadgesURL,
        options: options,
      );
      logger.i(response);

      if (response.statusCode == 200) {
        return Right(response.data['data'] ?? {});
      } else {
        return Left(
          response.data['message'] ?? 'Failed to fetch next level badges',
        );
      }
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left('An unexpected error occurred: $e');
    }
  }
}
