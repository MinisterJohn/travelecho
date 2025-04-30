import 'package:dartz/dartz.dart';
import '../../memories_exports.dart';

class GetMemoriesParams {
  final String? search;
  final String? title;
  final String? location;
  final String? tag;
  final String? sort;
  final int limit;
  final int skip;

  const GetMemoriesParams({
    this.search,
    this.title,
    this.location,
    this.tag,
    this.sort,
    required this.limit,
    required this.skip,
  });
}

class GetMemoriesUseCase {
  final MemoriesRepository _repository = sl<MemoriesRepository>();

  GetMemoriesUseCase();

  Future<Either<String, List<MemoryModel>>> call(
      GetMemoriesParams params) async {
    final result = await _repository.getMemories(
      search: params.search,
      title: params.title,
      location: params.location,
      tag: params.tag,
      sort: params.sort,
      limit: params.limit,
      skip: params.skip,
    );


    return result.fold(
      (error) => Left(error),
      (memories) => Right(memories),
    );
  }
}
