import 'package:dartz/dartz.dart';
import "../../memories_exports.dart";

class CreateMemoryParams {
  final String title;
  final String? description;
  final String? location;
  final DateTime? date;
  final List<String>? tags;
  final bool isPublic;

  const CreateMemoryParams({
    required this.title,
    this.description,
    this.location,
    this.date,
    this.tags,
    this.isPublic = true,
  });
}

class CreateMemoryUseCase
    extends UseCase<Map<String, dynamic>, CreateMemoryParams> {
  final MemoriesRepository _repository = sl<MemoriesRepository>();

  CreateMemoryUseCase();

  @override
  Future<Either<String, Map<String, dynamic>>> call(
      CreateMemoryParams params) async {
    return await _repository.createMemory(
      title: params.title,
      description: params.description,
      location: params.location,
      date: params.date,
      tags: params.tags,
      isPublic: params.isPublic,
    );
  }
}
