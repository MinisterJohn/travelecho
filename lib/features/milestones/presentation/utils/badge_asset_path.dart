import '../../milestones_exports.dart';

String badgeAssetPath(BadgeEntity badge) {
  return 'assets/images/milestones/'
      '${badge.category.toLowerCase()}/'
      '${badge.name.toLowerCase().replaceAll(' ', '-')}.png';
}
