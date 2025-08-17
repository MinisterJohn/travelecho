import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../memories_exports.dart';

class MemoryDetailsBlocListener extends StatelessWidget {
  final Function(MemoryModel memoryData) onMemoryCreatedOrUpdated;
  final Function(String message) onError;
  final bool isEditing;
  final MemoryModel? memory;

  const MemoryDetailsBlocListener({
    super.key,
    required this.onMemoryCreatedOrUpdated,
    required this.onError,
    required this.isEditing,
    this.memory,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<MemoriesBloc, MemoriesState>(
      listener: (context, state) {
        if (state is MemoryCreated || state is MemoryUpdated) {
          final memoryData =
              state is MemoryCreated
                  ? state.memory
                  : (state as MemoryUpdated).memory;
          final memoryId = memoryData.id;
          onMemoryCreatedOrUpdated(memoryData);
        } else if (state is MemoryError) {
          onError(state.message);
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
