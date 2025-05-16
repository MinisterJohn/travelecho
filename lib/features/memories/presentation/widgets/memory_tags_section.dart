import 'package:flutter/material.dart';
import '../../memories_exports.dart';

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
    final tag = widget.tagController.text.trim();
    if (tag.isEmpty) return;

    if (_containsSpecialCharacters(tag)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tags cannot contain special characters'),
          backgroundColor: AppColors.errorColor,
        ),
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
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: FontSize.size14,
          ),
        ),
        WidgetsSpacer.verticalSpacer8,
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: widget.tagController,
                decoration: InputDecoration(
                  hintText: 'Enter tag',
                  hintStyle: const TextStyle(color: AppColors.secondaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style: const TextStyle(fontSize: 16),
                maxLines: 1,
                onSubmitted: (_) => _handleTagSubmission(context),
                onEditingComplete: () => _handleTagSubmission(context),
              ),
            ),
            WidgetsSpacer.horinzontalSpacer8,
            ElevatedButton(
              onPressed: () => _handleTagSubmission(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                minimumSize: const Size(0, 0),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        WidgetsSpacer.verticalSpacer8,
        if (widget.tags.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.tags.map((tag) {
              return Chip(
                label: Text(tag),
                onDeleted: () => widget.onRemoveTag(tag),
                deleteIconColor: AppColors.primaryColor,
                shape: const StadiumBorder(
                  side: BorderSide(color: AppColors.primaryColor),
                ),
                backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                labelStyle: const TextStyle(color: AppColors.primaryColor),
              );
            }).toList(),
          ),
      ],
    );
  }
}
