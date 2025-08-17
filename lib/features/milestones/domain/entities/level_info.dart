import 'badge.dart';
class LevelInfoEntity {
  final String category;
  final BadgeEntity? currentBadge;
  final BadgeEntity? nextBadge;
  final int? currentValue;
  final int? requiredValue;
  final double progress;

  const LevelInfoEntity({
    required this.category,
    this.currentBadge,
    this.nextBadge,
    this.currentValue,
    this.requiredValue,
    required this.progress,
  });
}
