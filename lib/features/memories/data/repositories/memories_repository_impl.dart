import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../memories_exports.dart';

class MemoriesRepositoryImpl implements MemoriesRepository {
  final MemoriesApiService _apiService = sl<MemoriesApiService>();
  final SharedPreferences _prefs = sl<SharedPreferences>();

  MemoriesRepositoryImpl();

  @override
  Future<Either<String, Map<String, dynamic>>> createMemory({
    required String title,
    String? description,
    String? location,
    DateTime? date,
    List<String>? tags,
    bool isPublic = true,
  }) async {
    try {
      final storedUserId = _prefs.getString('user_id');
      if (storedUserId == null || storedUserId.isEmpty) {
        return const Left('User ID is required');
      }

      return await _apiService.createMemory(
        title: title,
        description: description,
        location: location,
        date: date,
        tags: tags,
        isPublic: isPublic,
      );
    } catch (e) {
      return const Left('Failed to create memory. Please try again later');
    }
  }

  // @override
  // Future<Either<String, void>> uploadMemoryImage({
  //   required String memoryId,
  //   required String imagePath,
  // }) async {
  //   try {
  //     return await _apiService.uploadMemoryImage(
  //       memoryId: memoryId,
  //       imagePath: imagePath,
  //     );
  //   } catch (e) {
  //     return Left('Failed to upload image. Please try again later');
  //   }
  // }

  @override
  Future<Either<String, void>> uploadMultipleMemoryImages({
    required String memoryId,
    required List<dynamic> imagePaths,
  }) async {
    try {
      return await _apiService.uploadMultipleMemoryImages(
        memoryId: memoryId,
        imagePaths: imagePaths,
      );
    } catch (e) {
      return const Left('Failed to upload images. Please try again later');
    }
  }

  @override
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
      return await _apiService.updateMemory(
        memoryId: memoryId,
        title: title,
        description: description,
        location: location,
        date: date,
        tags: tags,
        isPublic: isPublic,
      );
    } catch (e) {
      return const Left('Failed to update memory. Please try again later');
    }
  }

  @override
  Future<Either<String, List<MemoryModel>>> getMemories({
    String? search,
    String? title,
    String? location,
    String? tag,
    String? sort,
    required int limit,
    required int skip,
  }) async {
    try {
      final result = await _apiService.getMemories(
        search: search,
        title: title,
        location: location,
        tag: tag,
        sort: sort,
        limit: limit,
        skip: skip,
      );

      return result.fold(
        (error) => Left(error),
        (data) {
          try {
            final List<dynamic> memoriesList = data['memories'] ?? [];
            final List<MemoryModel> memories = memoriesList.map((memory) {
              if (memory is Map<String, dynamic>) {
                final model = MemoryModel.fromJson(memory);
                return model;
              } else if (memory is Map) {
                final model =
                    MemoryModel.fromJson(Map<String, dynamic>.from(memory));
                return model;
              } else {
                return MemoryModel(
                  id: '',
                  title: '',
                  description: '',
                  location: '',
                  date: DateTime.now(),
                  images: const [],
                  tags: const [],
                  userId: '',
                  name: '',
                  email: '',
                  isPublic: false,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                );
              }
            }).toList();
            return Right(memories);
          } catch (e) {
            print('Error converting memories data: $e');
            return const Left('Failed to process memories data');
          }
        },
      );
    } catch (e) {
      print('Error fetching memories: $e');
      return const Left('Failed to fetch memories. Please try again later');
    }
  }

  @override
  Future<Either<String, void>> deleteMemory(String memoryId) async {
    return await _apiService.deleteMemory(memoryId);
  }

  @override
  Future<Either<String, void>> deleteMultipleMemories(List<String> memoryIds) {
    return _apiService.deleteMultipleMemories(memoryIds);
  }

  @override
  Future<Either<String, MemoryModel>> getMemoryDetails(String memoryId) async {
    try {
      final result = await _apiService.getMemoryDetails(memoryId);
      return result.fold(
        (error) => Left(error),
        (data) {
          try {
            final memory = MemoryModel.fromJson(data);
            return Right(memory);
          } catch (e) {
            print('Error converting memory data: $e');
            return const Left('Failed to process memory data');
          }
        },
      );
    } catch (e) {
      print('Error fetching memory details: $e');
      return const Left('Failed to fetch memory details. Please try again later');
    }
  }
}
