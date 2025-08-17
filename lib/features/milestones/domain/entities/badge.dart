class BadgeEntity {
  final String id;
  final String name;
  final int level;
  final String description;
  final String category;
  final String operator;
  final int value;
  final DateTime? earnedAt;

  const BadgeEntity({
    required this.id,
    required this.name,
    required this.level,
    required this.description,
    required this.category,
    required this.operator,
    required this.value,
    this.earnedAt,
  });
}
