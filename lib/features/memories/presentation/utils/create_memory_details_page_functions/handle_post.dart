import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../memories_exports.dart';
import 'package:flutter/material.dart';

Future<void> handlePost({
  required BuildContext context,
  required bool isEditing,
  required MemoryModel? memory,
  required TextEditingController titleController,
  required TextEditingController descriptionController,
  required TextEditingController locationController,
  required DateTime? selectedDate,
  required List<String> tags,
  required bool isPublic,
  required Function() onLoading,
}) async {
  if (titleController.text.isEmpty) {
    DisplayMessage.errorMessage('Please enter a title', context);
    return;
  }
  onLoading();
  context.read<MemoriesBloc>().add(
  isEditing && memory != null
      ? EditMemory(
          memoryId: memory.id,
          title: titleController.text,
          description: descriptionController.text.isNotEmpty ? descriptionController.text : null,
          location: locationController.text.isNotEmpty ? locationController.text : null,
          date: selectedDate,
          tags: tags.isNotEmpty ? tags : null,
          isPublic: isPublic,
        )
      : CreateMemory(
          title: titleController.text,
          description: descriptionController.text.isNotEmpty ? descriptionController.text : null,
          location: locationController.text.isNotEmpty ? locationController.text : null,
          date: selectedDate,
          tags: tags.isNotEmpty ? tags : null,
          isPublic: isPublic,
        ),
);
   
}
