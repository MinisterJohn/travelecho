
import 'package:dartz/dartz.dart';
import '../../memories_exports.dart';

class EditMemoryParams {
  final String memoryId;
  final String title;
  final String? description;
  final String? location;
  final DateTime? date;
  final List<String>? tags;
  final bool isPublic;

  const EditMemoryParams({
    required this.memoryId,
    required this.title,
    this.description,
    this.location,
    this.date,
    this.tags,
    this.isPublic = true,
  });
}

class EditMemoryUseCase implements UseCase<Map<String, dynamic>, EditMemoryParams> {
  final MemoriesRepository _memoriesRepository = sl<MemoriesRepository>();

  EditMemoryUseCase();

  @override
  Future<Either<String, Map<String, dynamic>>> call(EditMemoryParams params) async {
    return await _memoriesRepository.updateMemory(
      memoryId: params.memoryId,
      title: params.title,
      description: params.description,
      location: params.location,
      date: params.date,
      tags: params.tags,
      isPublic: params.isPublic,
    );
  }
}