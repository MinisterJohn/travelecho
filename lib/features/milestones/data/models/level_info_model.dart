import '../../domain/entities/level_info.dart';
import 'badge_model.dart';

class LevelInfoModel extends LevelInfoEntity {
  const LevelInfoModel({
    required super.category,
    super.currentBadge,
    super.nextBadge,
    super.currentValue,
    super.requiredValue,
    required super.progress,
  });

  static List<LevelInfoModel> fromData({
    required Map<String, dynamic> nextJson,
  }) {
    final infos = <LevelInfoModel>[];

    nextJson.forEach((category, data) {
      final nextBadge = data['nextLevelBadge'] != null
          ? BadgeModel.fromJson(data['nextLevelBadge'])
          : null;

      final currentBadge = data['highestEarnedBadge'] != null
          ? BadgeModel.fromJson(data['highestEarnedBadge'])
          : null;

      final currentValue = data['currentValue'] is int ? data['currentValue'] : 0;
      final requiredValue = data['requiredValue'] is int ? data['requiredValue'] : 0;

      final progress = (data['percentageProgress'] is num)
          ? (data['percentageProgress'] as num).toDouble()
          : 0.0;

      infos.add(
        LevelInfoModel(
          category: category,
          currentBadge: currentBadge,
          nextBadge: nextBadge,
          currentValue: currentValue,
          requiredValue: requiredValue,
          progress: progress,
        ),
      );
    });

    return infos;
  }
}
