import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../memories_exports.dart';

part 'memories_event.dart';
part 'memories_state.dart';

class MemoriesBloc extends Bloc<MemoriesEvent, MemoriesState> {
  final CreateMemoryUseCase _createMemoryUseCase = sl<CreateMemoryUseCase>();
  // final UploadMemoryImageUseCase _uploadMemoryImageUseCase =
  //     sl<UploadMemoryImageUseCase>();
  final UploadMultipleMemoryImagesUseCase _uploadMultipleMemoryImagesUseCase =
      sl<UploadMultipleMemoryImagesUseCase>();
  final GetMemoriesUseCase _getMemoriesUseCase = sl<GetMemoriesUseCase>();
  final DeleteMemoryUseCase _deleteMemoryUseCase = sl<DeleteMemoryUseCase>();
  final EditMemoryUseCase _editMemoryUseCase = sl<EditMemoryUseCase>();
  final DeleteMultipleMemoriesUseCase _deleteMultipleMemoriesUseCase =
      sl<DeleteMultipleMemoriesUseCase>();
  final GetMemoryDetailsUseCase _getMemoryDetailsUseCase =
      sl<GetMemoryDetailsUseCase>();

  MemoriesBloc() : super(MemoriesInitial()) {
    on<CreateMemory>(_onCreateMemory);
    // on<UploadMemoryImage>(_onUploadMemoryImage);
    on<UploadMultipleMemoryImages>(_onUploadMultipleMemoryImages);
    on<FetchMemories>(_onFetchMemories);
    on<DeleteMemory>(_onDeleteMemory);
    on<EditMemory>(_onEditMemory);
    on<DeleteMultipleMemories>(_onDeleteMultipleMemories);
    on<FetchMemoryDetails>(_onFetchMemoryDetails);
  }

  Future<void> _onCreateMemory(
    CreateMemory event,
    Emitter<MemoriesState> emit,
  ) async {
    emit(CreatingMemory());
    try {
      final result = await _createMemoryUseCase(
        CreateMemoryParams(
          title: event.title,
          description: event.description,
          location: event.location,
          date: event.date,
          tags: event.tags,
          isPublic: event.isPublic,
        ),
      );
      print("Create Memory Result: $result");
      result.fold(
        (error) => emit(MemoryError(error)),
        (memory) {
          print("Memory: $memory");
          final Map<String, dynamic> memoryData = memory['memory'];
          print("Memory Data: $memoryData");
          emit(MemoryCreated(memoryData));
        },
      );
    } catch (e) {
      emit(MemoryError(e.toString()));
    }
  }

  // Future<void> _onUploadMemoryImage(
  //   UploadMemoryImage event,
  //   Emitter<MemoriesState> emit,
  // ) async {
  //   try {
  //     final result = await _uploadMemoryImageUseCase(
  //       UploadMemoryImageParams(
  //         memoryId: event.memoryId,
  //         imagePath: event.imagePath,
  //       ),
  //     );

  //     result.fold(
  //       (error) => emit(MemoryError(error)),
  //       (_) => emit(MemoryImageUploaded()),
  //     );
  //   } catch (e) {
  //     emit(MemoryError(e.toString()));
  //   }
  // }

  Future<void> _onUploadMultipleMemoryImages(
    UploadMultipleMemoryImages event,
    Emitter<MemoriesState> emit,
  ) async {
    try {
      final totalImages = event.imagePaths.length;
      var currentImage = 0;

      // Emit initial progress
      emit(UploadProgress(
        progress: 0,
        currentImage: 0,
        totalImages: totalImages,
      ));

      final result = await _uploadMultipleMemoryImagesUseCase(
        UploadMultipleMemoryImagesParams(
          memoryId: event.memoryId,
          imagePaths: event.imagePaths,
        ),
      );

      result.fold(
        (error) => emit(MemoryError(error)),
        (_) {
          // Update progress to 100% when complete
          emit(UploadProgress(
            progress: 1.0,
            currentImage: totalImages,
            totalImages: totalImages,
          ));
          emit(MultipleMemoryImagesUploaded());
        },
      );
    } catch (e) {
      emit(MemoryError(e.toString()));
    }
  }

  Future<void> _onFetchMemories(
    FetchMemories event,
    Emitter<MemoriesState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is! MemoriesLoaded) {
        emit(const MemoriesLoading());
      }

      final result = await _getMemoriesUseCase(
        GetMemoriesParams(
          search: event.search,
          title: event.title,
          location: event.location,
          tag: event.tag,
          sort: event.sort,
          limit: event.limit,
          skip: event.skip,
        ),
      );

      result.fold(
        (error) => emit(MemoryError(error)),
        (memories) {
          final currentMemories = currentState is MemoriesLoaded
              ? currentState.memories
              : <MemoryModel>[];

          final allMemories = event.skip == 0 || event.search != null
              ? memories
              : [...currentMemories, ...memories];

          final hasMore = memories.length == event.limit;
          emit(MemoriesLoaded(
            memories: allMemories,
            hasMore: hasMore,
            currentPage: event.skip ~/ event.limit + 1,
            isSearching: event.search != null,
          ));
        },
      );
    } catch (e) {
      emit(MemoryError(e.toString()));
    }
  }

  Future<void> _onDeleteMemory(
    DeleteMemory event,
    Emitter<MemoriesState> emit,
  ) async {
    try {
      // Get current state
      final currentState = state;
      if (currentState is MemoriesLoaded) {
        // First emit a state with the memory marked for deletion
        emit(MemoriesLoaded(
          memories: currentState.memories,
          hasMore: currentState.hasMore,
          currentPage: currentState.currentPage,
          deletingMemoryId: event.memoryId,
        ));

        // Wait a short moment for the animation to start
        await Future.delayed(const Duration(milliseconds: 300));

        // Remove the memory from the list
        final updatedMemories = currentState.memories
            .where((memory) => memory.id != event.memoryId)
            .toList();

        // Update UI with the memory removed
        emit(MemoriesLoaded(
          memories: updatedMemories,
          hasMore: currentState.hasMore,
          currentPage: currentState.currentPage,
        ));

        // Delete from backend in the background without emitting any states
        await _deleteMemoryUseCase(event.memoryId);
      } else {
        // If not in loaded state, proceed with normal deletion
        final result = await _deleteMemoryUseCase(event.memoryId);
        result.fold(
          (error) => emit(MemoryError(error)),
          (_) => emit(MemoryDeleted(memoryId: event.memoryId)),
        );
      }
    } catch (e) {
      // Only emit error if we're not in MemoriesLoaded state
      if (state is! MemoriesLoaded) {
        emit(MemoryError(e.toString()));
      }
    }
  }

  Future<void> _onEditMemory(
    EditMemory event,
    Emitter<MemoriesState> emit,
  ) async {
    try {
      final result = await _editMemoryUseCase(
        EditMemoryParams(
          memoryId: event.memoryId,
          title: event.title,
          description: event.description,
          location: event.location,
          date: event.date,
          tags: event.tags,
          isPublic: event.isPublic,
        ),
      );

      result.fold(
        (error) => emit(MemoryError(error)),
        (memory) {
          final Map<String, dynamic> memoryData = memory['memory'];
          print("Update Memory Response: $memoryData");

          emit(MemoryUpdated(memoryData));
        },
      );
    } catch (e) {
      print("Update Memory Error: $e");
      emit(MemoryError(e.toString()));
    }
  }

  Future<void> _onDeleteMultipleMemories(
    DeleteMultipleMemories event,
    Emitter<MemoriesState> emit,
  ) async {
    try {
      // Get current state
      final currentState = state;
      if (currentState is MemoriesLoaded) {
        // First emit a state with the memories marked for deletion
        emit(MemoriesLoaded(
          memories: currentState.memories,
          hasMore: currentState.hasMore,
          currentPage: currentState.currentPage,
          deletingMemoryId: event.memoryIds.first,
        ));

        // Wait a short moment for the animation to start
        await Future.delayed(const Duration(milliseconds: 300));

        // Remove the memories from the list
        final updatedMemories = currentState.memories
            .where((memory) => !event.memoryIds.contains(memory.id))
            .toList();

        // Update UI with the memories removed
        emit(MemoriesLoaded(
          memories: updatedMemories,
          hasMore: currentState.hasMore,
          currentPage: currentState.currentPage,
        ));

        // Delete from backend in the background
        final result = await _deleteMultipleMemoriesUseCase(
          DeleteMultipleMemoriesParams(memoryIds: event.memoryIds),
        );

        result.fold(
          (error) {
            // If there's an error, we might want to show a snackbar or dialog
            // but we won't revert the UI changes
            print('Error deleting multiple memories: $error');
          },
          (_) {
            // Success - no need to do anything as UI is already updated
            print('Successfully deleted ${event.memoryIds.length} memories');
          },
        );
      } else {
        // If not in loaded state, proceed with normal deletion
        final result = await _deleteMultipleMemoriesUseCase(
          DeleteMultipleMemoriesParams(memoryIds: event.memoryIds),
        );

        result.fold(
          (error) => emit(MemoryError(error)),
          (_) => emit(MemoryDeleted(memoryId: event.memoryIds.first)),
        );
      }
    } catch (e) {
      // Only emit error if we're not in MemoriesLoaded state
      if (state is! MemoriesLoaded) {
        emit(MemoryError(e.toString()));
      }
    }
  }

  Future<void> _onFetchMemoryDetails(
    FetchMemoryDetails event,
    Emitter<MemoriesState> emit,
  ) async {
    try {
      final result = await _getMemoryDetailsUseCase(event.memoryId);

      result.fold(
        (error) => emit(MemoryError(error)),
        (memory) => emit(MemoryDetailsLoaded(memory)),
      );
    } catch (e) {
      emit(MemoryError(e.toString()));
    }
  }
}
