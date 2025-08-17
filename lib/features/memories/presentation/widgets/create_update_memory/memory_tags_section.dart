import 'package:flutter/material.dart' hide CarouselController;
import '../../../memories_exports.dart';

class MemoryTagsSection extends StatefulWidget {
  final TextEditingController tagController;
  final List<String> tags;
  final Function() onAddTag;
  final Function(String) onRemoveTag;

  const MemoryTagsSection({
    super.key,
    required this.tagController,
    required this.tags,
    required this.onAddTag,
    required this.onRemoveTag,
  });

  @override
  State<MemoryTagsSection> createState() => _MemoryTagsSectionState();
}

class _MemoryTagsSectionState extends State<MemoryTagsSection> {
  bool _containsSpecialCharacters(String text) {
    final RegExp specialChars = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');
    return specialChars.hasMatch(text);
  }

  void _handleTagSubmission(BuildContext context) {
    final tag = widget.tagController.text.trim().toLowerCase();
    if (tag.isEmpty) return;

    if (_containsSpecialCharacters(tag)) {
      DisplayMessage.errorMessage(
        "Tags cannot contain special characters",
        context,
      );
      return;
    }

    widget.onAddTag();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add tags that describe your experience',
          style: TextStyle(fontSize: FontSize.size16),
        ),
        WidgetsSpacer.verticalSpacer8,
        StatefulBuilder(
          builder: (context, setState) {
            return TextField(
              controller: widget.tagController,
              decoration: InputDecoration(
                hintText: 'Enter tag',
                hintStyle: const TextStyle(color: AppColors.secondaryColor),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: TextButton(
                    onPressed:
                        widget.tagController.text.trim().isEmpty
                            ? null
                            : () => _handleTagSubmission(context),
                    child: Text(
                      'Add',
                      style: TextStyle(
                        fontSize: FontSize.size16,
                        fontWeight: FontWeight.w400,
                        color:
                            widget.tagController.text.trim().isEmpty
                                ? AppColors.defaultColor400
                                : AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              style: const TextStyle(fontSize: 16),
              maxLines: 1,
              onChanged: (_) => setState(() {}),
              onSubmitted: (_) => _handleTagSubmission(context),
              onEditingComplete: () => _handleTagSubmission(context),
            );
          },
        ),
        WidgetsSpacer.verticalSpacer8,
        if (widget.tags.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                widget.tags.map((tag) {
                  return Chip(
                    label: Text(tag),
                    onDeleted: () => widget.onRemoveTag(tag),
                    deleteIconColor: AppColors.primaryColor,
                    shape: const StadiumBorder(
                      side: BorderSide(color: AppColors.primaryColor100),
                    ),
                    backgroundColor: AppColors.primaryColor100,
                    labelStyle: const TextStyle(color: AppColors.primaryColor),
                  );
                }).toList(),
          ),
      ],
    );
  }
}
