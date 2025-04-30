part of 'memories_bloc.dart';

class MemoriesState extends Equatable {
  final List<MemoryModel> memories;
  final bool isLoading;
  final String? error;
  final bool isCreating;
  final bool isUpdating;
  final bool isDeleting;
  final String? createError;
  final String? updateError;
  final String? deleteError;
  final String? multipleDeleteError;
  final bool isMultipleDeleting;
  final List<String>? successfullyDeletedIds;

  const MemoriesState({
    this.memories = const [],
    this.isLoading = false,
    this.error,
    this.isCreating = false,
    this.isUpdating = false,
    this.isDeleting = false,
    this.createError,
    this.updateError,
    this.deleteError,
    this.multipleDeleteError,
    this.isMultipleDeleting = false,
    this.successfullyDeletedIds,
  });

  MemoriesState copyWith({
    List<MemoryModel>? memories,
    bool? isLoading,
    String? error,
    bool? isCreating,
    bool? isUpdating,
    bool? isDeleting,
    String? createError,
    String? updateError,
    String? deleteError,
    String? multipleDeleteError,
    bool? isMultipleDeleting,
    List<String>? successfullyDeletedIds,
  }) {
    return MemoriesState(
      memories: memories ?? this.memories,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isCreating: isCreating ?? this.isCreating,
      isUpdating: isUpdating ?? this.isUpdating,
      isDeleting: isDeleting ?? this.isDeleting,
      createError: createError ?? this.createError,
      updateError: updateError ?? this.updateError,
      deleteError: deleteError ?? this.deleteError,
      multipleDeleteError: multipleDeleteError ?? this.multipleDeleteError,
      isMultipleDeleting: isMultipleDeleting ?? this.isMultipleDeleting,
      successfullyDeletedIds:
          successfullyDeletedIds ?? this.successfullyDeletedIds,
    );
  }

  @override
  List<Object?> get props => [
        memories,
        isLoading,
        error,
        isCreating,
        isUpdating,
        isDeleting,
        createError,
        updateError,
        deleteError,
        multipleDeleteError,
        isMultipleDeleting,
        successfullyDeletedIds,
      ];
}

class MemoriesInitial extends MemoriesState {}

class CreatingMemory extends MemoriesState {}

class MemoryCreated extends MemoriesState {
  final Map<String, dynamic> memory;

  const MemoryCreated(this.memory);

  @override
  List<Object> get props => [memory];
}

class MemoryImageUploaded extends MemoriesState {}

class MultipleMemoryImagesUploaded extends MemoriesState {}

class UploadProgress extends MemoriesState {
  final double progress;
  final int currentImage;
  final int totalImages;

  const UploadProgress({
    required this.progress,
    required this.currentImage,
    required this.totalImages,
  });

  @override
  List<Object> get props => [progress, currentImage, totalImages];
}

class MemoriesLoading extends MemoriesState {
  final List<MemoryModel> memories;

  const MemoriesLoading({this.memories = const []});

  @override
  List<Object> get props => [memories];
}

class MemoriesLoaded extends MemoriesState {
  final List<MemoryModel> memories;
  final bool hasMore;
  final int currentPage;
  final String? deletingMemoryId;

  const MemoriesLoaded({
    required this.memories,
    required this.hasMore,
    required this.currentPage,
    this.deletingMemoryId,
  });

  @override
  List<Object> get props =>
      [memories, hasMore, currentPage, deletingMemoryId ?? ''];
}

class MemoryError extends MemoriesState {
  final String message;

  const MemoryError(this.message);

  @override
  List<Object> get props => [message];
}

class MemoryDeleted extends MemoriesState {
  final String memoryId;

  const MemoryDeleted({required this.memoryId});

  @override
  List<Object> get props => [memoryId];
}

class MemoryUpdated extends MemoriesState {
  final MemoryModel memory;

  const MemoryUpdated(this.memory);

  @override
  List<Object> get props => [memory];
}

class MultipleMemoriesDeleted extends MemoriesState {
  final int deletedCount;

  const MultipleMemoriesDeleted({required this.deletedCount});

  @override
  List<Object> get props => [deletedCount];
}
