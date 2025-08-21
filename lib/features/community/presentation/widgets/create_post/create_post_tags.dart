import 'package:flutter/material.dart';
import '../../../community_exports.dart';

class CreatePostTags extends StatelessWidget {
  final List<String> tags;
  final TextEditingController controller;
  final void Function(String tag) onAdd;
  final void Function(String tag) onRemove;

  const CreatePostTags({
    super.key,
    required this.tags,
    required this.controller,
    required this.onAdd,
    required this.onRemove,
  });

  bool _containsSpecialCharacters(String text) {
    final RegExp specialChars = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');
    return specialChars.hasMatch(text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Add tags that describe your post'),
        const SizedBox(height: 8),
        StatefulBuilder(
          builder: (context, setStateSB) {
            return TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Enter tag',
                suffixIcon: TextButton(
                  onPressed:
                      controller.text.trim().isEmpty
                          ? null
                          : () {
                            final tag = controller.text.trim().toLowerCase();
                            if (tag.isNotEmpty &&
                                !_containsSpecialCharacters(tag)) {
                              onAdd(tag);
                              controller.clear();
                              setStateSB(() {});
                            }
                          },
                  child: const Text("Add"),
                ),
              ),
              onSubmitted: (_) {
                final tag = controller.text.trim().toLowerCase();
                if (tag.isNotEmpty && !_containsSpecialCharacters(tag)) {
                  onAdd(tag);
                  controller.clear();
                  setStateSB(() {});
                }
              },
              onChanged: (_) => setStateSB(() {}),
            );
          },
        ),
        const SizedBox(height: 8),
        if (tags.isNotEmpty)
          Wrap(
            spacing: 8,
            children:
                tags
                    .map(
                      (tag) => Chip(
                        label: Text(tag),
                        onDeleted: () => onRemove(tag),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                          side: BorderSide(color: AppColors.primaryColor),
                        ),
                        deleteIconColor: AppColors.primaryColor,
                        backgroundColor: AppColors.primaryColor100,
                        labelStyle: const TextStyle(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )
                    .toList(),
          ),
      ],
    );
  }
}
