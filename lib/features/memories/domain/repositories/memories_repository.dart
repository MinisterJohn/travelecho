import 'package:dartz/dartz.dart';
import '../../memories_exports.dart';

abstract class MemoriesRepository {
  Future<Either<String, Map<String, dynamic>>> createMemory({
    required String title,
    String? description,
    String? location,
    DateTime? date,
    List<String>? tags,
    bool isPublic = true,
  });

  Future<Either<String, void>> uploadMemoryImage({
    required String memoryId,
    required String imagePath,
  });

  Future<Either<String, void>> uploadMultipleMemoryImages({
    required String memoryId,
    required List<dynamic> imagePaths,
  });

  Future<Either<String, List<MemoryModel>>> getMemories({
    String? search,
    String? title,
    String? location,
    String? tag,
    String? sort,
    required int limit,
    required int skip,
  });

  Future<Either<String, void>> deleteMemory(String memoryId);

  Future<Either<String, Map<String, dynamic>>> updateMemory({
    required String memoryId,
    required String title,
    String? description,
    String? location,
    DateTime? date,
    List<String>? tags,
    bool isPublic = true,
  });

  // Future<Either<String, MemoryModel>> updateMemoryImages(
  //     String memoryId, List<String> images);

  Future<Either<String, void>> deleteMultipleMemories(List<String> memoryIds);
}
