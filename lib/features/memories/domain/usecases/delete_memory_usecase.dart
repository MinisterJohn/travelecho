import 'package:dartz/dartz.dart';
import '../../memories_exports.dart';

class DeleteMemoryUseCase implements UseCase<void, String> {
  final MemoriesRepository _memoriesRepository = sl<MemoriesRepository>();

  DeleteMemoryUseCase();

  @override
  Future<Either<String, void>> call(String memoryId) async {
    return await _memoriesRepository.deleteMemory(memoryId);
  }
}
