import 'package:flutter/material.dart';

void addTag({
  required TextEditingController tagController,
  required List<String> tags,
  required Function(List<String>) onTagsChanged,
}) {
  if (tagController.text.isNotEmpty) {
    final updatedTags = List<String>.from(tags)..add(tagController.text.trim());
    tagController.clear();
    onTagsChanged(updatedTags);
  }
}
