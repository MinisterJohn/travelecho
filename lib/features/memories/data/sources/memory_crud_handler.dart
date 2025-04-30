import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../memories_exports.dart';

class MemoryCrudHandler {
  final DioClient _dioClient = sl<DioClient>();
  final SharedPreferences _prefs = sl<SharedPreferences>();
  MemoryCrudHandler();

  Future<Options> _getOptions() async {
    final token = await _prefs.getString('token');
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

  Future<Either<String, Map<String, dynamic>>> createMemory({
    required String title,
    String? description,
    String? location,
    DateTime? date,
    List<String>? tags,
    bool isPublic = true,
  }) async {
    try {
      if (title.isEmpty) {
        return const Left('Title is required');
      }

      final storedUserId = await _prefs.getString('user_id');
      if (storedUserId == null || storedUserId.isEmpty) {
        return const Left('User ID is required');
      }

      final options = await _getOptions();
      final response = await _dioClient.post(
        'https://travel-echo-backend.onrender.com/api/memories?populate=user,name,email',
        data: {
          'user': storedUserId,
          'title': title,
          if (description != null) 'description': description,
          if (location != null) 'location': location,
          if (date != null) 'date': date.toIso8601String(),
          if (tags != null && tags.isNotEmpty) 'tags': tags,
          'isPublic': isPublic,
        },
        options: options,
      );

      if (response.statusCode == 201) {
        return Right(response.data);
      } else {
        return Left(response.data['message'] ?? 'Failed to create memory');
      }
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left('An unexpected error occurred: $e');
    }
  }

  Future<Either<String, Map<String, dynamic>>> getMemories({
    String? search,
    String? title,
    String? location,
    String? tag,
    String? sort,
    required int limit,
    required int skip,
  }) async {
    try {
      final options = await _getOptions();
      final token = options.headers?['Authorization'];
      final effectiveLimit = limit > 0 ? limit : 10;

      if (token == null || token.isEmpty) {
        return const Left('Authentication token is missing');
      }

      final response = await _dioClient.get(
        'https://travel-echo-backend.onrender.com/api/memories?populate=user,name,email',
        queryParameters: {
          if (search != null) 'search': search,
          if (title != null) 'title': title,
          if (location != null) 'location': location,
          if (tag != null) 'tag': tag,
          if (sort != null) 'sort': sort,
          'limit': effectiveLimit,
          'skip': skip,
        },
        options: options,
      );

      if (response.statusCode == 200) {
        final List<dynamic> memoriesData = response.data['memories'] ?? [];
        final List<Map<String, dynamic>> memoriesJson =
            memoriesData.map((memory) {
          if (memory is Map<String, dynamic>) {
            return memory;
          } else if (memory is Map) {
            return Map<String, dynamic>.from(memory);
          } else {
            return <String, dynamic>{};
          }
        }).toList();

        return Right({'memories': memoriesJson});
      } else {
        final errorMessage =
            response.data['message'] ?? 'Failed to get memories';
        return Left(errorMessage);
      }
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left('An unexpected error occurred: $e');
    }
  }

  Future<Either<String, void>> deleteMemory(String memoryId) async {
    try {
      final options = await _getOptions();
      final token = options.headers?['Authorization'];

      if (token == null || token.isEmpty) {
        return const Left('Authentication token is missing');
      }

      final response = await _dioClient.delete(
        'https://travel-echo-backend.onrender.com/api/memories/$memoryId',
        options: options,
      );
      print("Delete Response: ${response.data}");

      if (response.statusCode == 200) {
        return const Right(null);
      } else if (response.statusCode == 403) {
        return const Left('You do not have permission to delete this memory');
      } else {
        return Left(response.data['message'] ?? 'Failed to delete memory');
      }
    } on DioException catch (e) {
      print("Delete Error: ${e.response?.data}");
      if (e.response?.statusCode == 403) {
        return const Left('You do not have permission to delete this memory');
      }
      return Left(_handleError(e));
    } catch (e) {
      print("Delete Error: $e");
      return Left('An unexpected error occurred: $e');
    }
  }

  Future<Either<String, Map<String, dynamic>>> updateMemory({
    required String memoryId,
    required String title,
    String? description,
    String? location,
    DateTime? date,
    List<String>? tags,
    bool isPublic = true,
  }) async {
    try {
      final options = await _getOptions();
      final response = await _dioClient.put(
        'https://travel-echo-backend.onrender.com/api/memories/$memoryId/',
        data: {
          'title': title,
          if (description != null) 'description': description,
          if (location != null) 'location': location,
          if (date != null) 'date': date.toIso8601String(),
          if (tags != null && tags.isNotEmpty) 'tags': tags,
          'isPublic': isPublic,
        },
        options: options,
      );

      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        return Left(response.data['message'] ?? 'Failed to update memory');
      }
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left('An unexpected error occurred: $e');
    }
  }

  Future<Either<String, void>> deleteMultipleMemories(
      List<String> memoryIds) async {
    try {
      if (memoryIds.isEmpty) {
        return const Left('No memory IDs provided');
      }

      final options = await _getOptions();
      final token = options.headers?['Authorization'];

      if (token == null || token.isEmpty) {
        return const Left('Authentication token is missing');
      }

      // Track successful and failed deletions
      final List<String> failedDeletions = [];
      final List<String> successfulDeletions = [];

      for (final memoryId in memoryIds) {
        try {
          final response = await _dioClient.delete(
            'https://travel-echo-backend.onrender.com/api/memories/$memoryId',
            options: options,
          );

          if (response.statusCode == 200) {
            successfulDeletions.add(memoryId);
          } else if (response.statusCode == 403) {
            failedDeletions.add('$memoryId: Permission denied');
          } else {
            failedDeletions.add(
                '$memoryId: ${response.data['message'] ?? 'Failed to delete'}');
          }
        } catch (e) {
          failedDeletions.add('$memoryId: $e');
        }
      }

      if (failedDeletions.isNotEmpty) {
        final errorMessage =
            'Failed to delete ${failedDeletions.length} memories:\n'
            '${failedDeletions.join('\n')}\n\n'
            'Successfully deleted ${successfulDeletions.length} memories.';
        return Left(errorMessage);
      }

      return const Right(null);
    } catch (e) {
      return Left('An unexpected error occurred: $e');
    }
  }
}
