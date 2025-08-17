import '../../domain/entities/badge.dart';

class BadgeModel extends BadgeEntity {
  const BadgeModel({
    required super.id,
    required super.name,
    required super.level,
    required super.description,
    required super.category,
    required super.operator,
    required super.value,
    super.earnedAt,
  });

  factory BadgeModel.fromJson(Map<String, dynamic> json, {DateTime? earnedAt}) {
    final badgeJson = json['badge'] ?? json;
    return BadgeModel(
      id: badgeJson['_id'],
      name: badgeJson['name'],
      level:
          badgeJson['level'] is int
              ? badgeJson['level']
              : int.tryParse(badgeJson['level'].toString()) ?? 0,
      description: badgeJson['description'],
      category: badgeJson['category'],
      operator: badgeJson['operator'],
      value:
          badgeJson['value'] is num
              ? badgeJson['value']
              : num.tryParse(badgeJson['value'].toString()) ?? 0,
      earnedAt:
          earnedAt ??
          (json['earnedAt'] != null
              ? DateTime.tryParse(json['earnedAt'])
              : null),
    );
  }
}
