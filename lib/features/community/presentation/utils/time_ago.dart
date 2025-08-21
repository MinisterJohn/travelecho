String timeAgo(DateTime date) {
  final diff = DateTime.now().difference(date);
  if (diff.inDays > 7) return "${date.day}/${date.month}/${date.year}";
  if (diff.inDays >= 1) return "${diff.inDays}d";
  if (diff.inHours >= 1) return "${diff.inHours}h";
  if (diff.inMinutes >= 1) return "${diff.inMinutes}m";
  return "just now";
}
