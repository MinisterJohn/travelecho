import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../memories_exports.dart';

void handleViewMemory(BuildContext context, MemoryModel memory) {
  AppNavigator.push(
    context,
    BlocProvider.value(
      value: sl<MemoriesBloc>(),
      child: ViewMemoryPage(memory: memory),
    ),
  );
}

void handleEditMemory(BuildContext context, MemoryModel memory) {
  AppNavigator.push(
    context,
    BlocProvider.value(
      value: context.read<MemoriesBloc>(),
      child: CreateMemoryDetailsPage(memory: memory, isEditing: true),
    ),
  );
}

void handleDeleteMemory(BuildContext context, MemoryModel memory) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text('Delete Memory'),
        content: const Text('Are you sure you want to delete this memory?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.defaultColor400,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<MemoriesBloc>().add(
                DeleteMemory(memoryId: memory.id),
              );
            },
            child: const Text(
              'Delete',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.errorColor,
              ),
            ),
          ),
        ],
      );
    },
  );
}
