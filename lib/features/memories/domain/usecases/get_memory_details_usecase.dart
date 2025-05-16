import 'package:dartz/dartz.dart';
import '../../memories_exports.dart';

class GetMemoryDetailsUseCase implements UseCase<MemoryModel, String> {
  final MemoriesRepository _repository = sl<MemoriesRepository>();

  GetMemoryDetailsUseCase();

  @override
  Future<Either<String, MemoryModel>> call(String memoryId) async {
    try {
      final result = await _repository.getMemoryDetails(memoryId);
      return result.fold(
        (error) => Left(error),
        (memory) => Right(memory),
      );
    } catch (e) {
      return Left('Failed to fetch memory details: $e');
    }
  }
} 