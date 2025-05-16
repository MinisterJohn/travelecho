import 'package:dartz/dartz.dart';
import '../../memories_exports.dart';

class UploadMemoryImageParams {
  final String memoryId;
  final String imagePath;

  const UploadMemoryImageParams({
    required this.memoryId,
    required this.imagePath,
  });
}

class UploadMultipleMemoryImagesParams {
  final String memoryId;
  final List<dynamic> imagePaths;

  const UploadMultipleMemoryImagesParams({
    required this.memoryId,
    required this.imagePaths,
  });
}

// class UploadMemoryImageUseCase extends UseCase<void, UploadMemoryImageParams> {
//   final MemoriesRepository _repository = sl<MemoriesRepository>();

//   UploadMemoryImageUseCase();

//   @override
//   Future<Either<String, void>> call(UploadMemoryImageParams params) async {
//     return await _repository.uploadMemoryImage(
//       memoryId: params.memoryId,
//       imagePath: params.imagePath,
//     );
//   }
// }

class UploadMultipleMemoryImagesUseCase
    extends UseCase<void, UploadMultipleMemoryImagesParams> {
  final MemoriesRepository _repository = sl<MemoriesRepository>();

  UploadMultipleMemoryImagesUseCase();

  @override
  Future<Either<String, void>> call(
      UploadMultipleMemoryImagesParams params) async {
    print(params);
    return await _repository.uploadMultipleMemoryImages(
      memoryId: params.memoryId,
      imagePaths: params.imagePaths,
    );
  }
}
