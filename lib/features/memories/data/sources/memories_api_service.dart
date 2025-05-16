import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../memories_exports.dart';

import 'memory_crud_handler.dart';
import 'memory_image_handler.dart';

abstract class MemoriesApiService {
  Future<Either<String, Map<String, dynamic>>> createMemory({
    required String title,
    String? description,
    String? location,
    DateTime? date,
    List<String>? tags,
    bool isPublic = true,
  });

  // Future<Either<String, void>> uploadMemoryImage({
  //   required String memoryId,
  //   required String imagePath,
  // });

  Future<Either<String, void>> uploadMultipleMemoryImages({
    required String memoryId,
    required List<dynamic> imagePaths,
  });

  Future<Either<String, Map<String, dynamic>>> getMemories({
    String? search,
    String? title,
    String? location,
    String? tag,
    String? sort,
    required int limit,
    required int skip,
  });

  Future<Either<String, Map<String, dynamic>>> getMemoryDetails(
      String memoryId);

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

  Future<Either<String, void>> deleteMultipleMemories(List<String> memoryIds);
}

class MemoriesApiServiceImpl implements MemoriesApiService {
  final DioClient _dioClient = sl<DioClient>();
  final SharedPreferences _prefs = sl<SharedPreferences>();
  final MemoryCrudHandler _crudHandler;
  final MemoryImageHandler _imageHandler;

  MemoriesApiServiceImpl()
      : _crudHandler = MemoryCrudHandler(),
        _imageHandler = MemoryImageHandler();

  @override
  Future<Either<String, Map<String, dynamic>>> createMemory({
    required String title,
    String? description,
    String? location,
    DateTime? date,
    List<String>? tags,
    bool isPublic = true,
  }) {
    return _crudHandler.createMemory(
      title: title,
      description: description,
      location: location,
      date: date,
      tags: tags,
      isPublic: isPublic,
    );
  }

  // @override
  // Future<Either<String, void>> uploadMemoryImage({
  //   required String memoryId,
  //   required String imagePath,
  // }) {
  //   return _imageHandler.uploadMemoryImage(
  //     memoryId: memoryId,
  //     imagePath: imagePath,
  //   );
  // }

  @override
  Future<Either<String, void>> uploadMultipleMemoryImages({
    required String memoryId,
    required List<dynamic> imagePaths,
  }) {
    return _imageHandler.uploadMultipleMemoryImages(
      memoryId: memoryId,
      imagePaths: imagePaths,
    );
  }

  @override
  Future<Either<String, Map<String, dynamic>>> getMemories({
    String? search,
    String? title,
    String? location,
    String? tag,
    String? sort,
    required int limit,
    required int skip,
  }) {
    return _crudHandler.getMemories(
      search: search,
      title: title,
      location: location,
      tag: tag,
      sort: sort,
      limit: limit,
      skip: skip,
    );
  }

  @override
  Future<Either<String, Map<String, dynamic>>> getMemoryDetails(
      String memoryId) {
    return _crudHandler.getMemoryDetails(memoryId);
  }

  @override
  Future<Either<String, void>> deleteMemory(String memoryId) {
    return _crudHandler.deleteMemory(memoryId);
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
  }) {
    return _crudHandler.updateMemory(
      memoryId: memoryId,
      title: title,
      description: description,
      location: location,
      date: date,
      tags: tags,
      isPublic: isPublic,
    );
  }

  @override
  Future<Either<String, void>> deleteMultipleMemories(List<String> memoryIds) {
    return _crudHandler.deleteMultipleMemories(memoryIds);
  }
}
