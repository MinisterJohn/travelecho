import 'package:flutter/material.dart';
import '../../../memories_exports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePicturesButton extends StatelessWidget {
  final String memoryId;
  final bool isEditing;
  final List<dynamic>? existingImages;

  const UpdatePicturesButton({
    super.key,
    required this.memoryId,
    required this.isEditing,
    this.existingImages,
  });

  @override
  Widget build(BuildContext context) {
    if (!isEditing) return const SizedBox.shrink();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            AppNavigator.push(
              context,
              BlocProvider.value(
                value: sl<MemoriesBloc>(),
                child: AddDetailsToMemoryPage(
                  memoryId: memoryId,
                  isEditing: isEditing,
                  existingImages: existingImages,
                ),
              ),
            );
          },
          child: const Text("Update Pictures"),
        ),
      ],
    );
  }
}
