part of 'memories_bloc.dart';

abstract class MemoriesEvent extends Equatable {
  const MemoriesEvent();

  @override
  List<Object?> get props => [];
}

class CreateMemory extends MemoriesEvent {
  final String title;
  final String? description;
  final String? location;
  final DateTime? date;
  final List<String>? tags;
  final bool isPublic;

  const CreateMemory({
    required this.title,
    this.description,
    this.location,
    this.date,
    this.tags,
    this.isPublic = true,
  });

  @override
  List<Object> get props => [title, isPublic];
}

class UploadMemoryImage extends MemoriesEvent {
  final String memoryId;
  final String imagePath;

  const UploadMemoryImage({
    required this.memoryId,
    required this.imagePath,
  });

  @override
  List<Object> get props => [memoryId, imagePath];
}

class UploadMultipleMemoryImages extends MemoriesEvent {
  final String memoryId;
  final List<dynamic> imagePaths;

  const UploadMultipleMemoryImages({
    required this.memoryId,
    required this.imagePaths,
  });

  @override
  List<Object> get props => [memoryId, imagePaths];
}

class FetchMemories extends MemoriesEvent {
  final String? search;
  final String? title;
  final String? location;
  final String? tag;
  final String? sort;
  final int limit;
  final int skip;

  const FetchMemories({
    this.search,
    this.title,
    this.location,
    this.tag,
    this.sort,
    this.limit = 10,
    this.skip = 0,
  });

  @override
  List<Object> get props => [limit, skip];
}

class DeleteMemory extends MemoriesEvent {
  final String memoryId;

  const DeleteMemory({required this.memoryId});

  @override
  List<Object> get props => [memoryId];
}

class EditMemory extends MemoriesEvent {
  final String memoryId;
  final String title;
  final String? description;
  final String? location;
  final DateTime? date;
  final List<String>? tags;
  final bool isPublic;

  const EditMemory({
    required this.memoryId,
    required this.title,
    this.description,
    this.location,
    this.date,
    this.tags,
    this.isPublic = true,
  });

  @override
  List<Object> get props => [memoryId, title, isPublic];
}

class DeleteMultipleMemories extends MemoriesEvent {
  final List<String> memoryIds;

  const DeleteMultipleMemories({required this.memoryIds});

  @override
  List<Object> get props => [memoryIds];
}

class FetchMemoryDetails extends MemoriesEvent {
  final String memoryId;

  const FetchMemoryDetails(this.memoryId);

  @override
  List<Object?> get props => [memoryId];
}
