void removeTag({
  required String tag,
  required List<String> tags,
  required Function(List<String>) onTagsChanged,
}) {
  final updatedTags = List<String>.from(tags)..remove(tag);
  onTagsChanged(updatedTags);
}
