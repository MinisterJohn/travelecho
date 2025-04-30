import 'package:dartz/dartz.dart';
import '../../memories_exports.dart';

class DeleteMultipleMemoriesParams {
  final List<String> memoryIds;

  const DeleteMultipleMemoriesParams({required this.memoryIds});
}

class DeleteMultipleMemoriesUseCase {
  final MemoriesRepository _repository = sl<MemoriesRepository>();

  DeleteMultipleMemoriesUseCase();

  Future<Either<String, void>> call(DeleteMultipleMemoriesParams params) async {
    return await _repository.deleteMultipleMemories(params.memoryIds);
  }
}
