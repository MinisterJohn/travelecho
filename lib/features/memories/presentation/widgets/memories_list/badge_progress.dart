import 'package:flutter/material.dart';

import '../../../memories_exports.dart';

class BadgeProgressBar extends StatelessWidget {
  final LevelInfoEntity level;
  final bool showProgress;
  const BadgeProgressBar({
    super.key,
    required this.level,
    this.showProgress = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Current badge
          _buildBadgeItem(context, badge: level.currentBadge, isEarned: true),
          WidgetsSpacer.horizontalSpacer16,

          // Progress bar in between
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    LinearProgressIndicator(
                      backgroundColor: AppColors.defaultColor100,
                      color: AppColors.primaryColor,
                      value: level.progress / 100,
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(12),
                    ),

                    Text(
                      "${level.progress.toStringAsFixed(0)}%",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                if (showProgress)
                  Text(
                    "${level.currentValue} / ${level.requiredValue} ${level.currentBadge?.category.toLowerCase() ?? ''}",
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.defaultColor400,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),

          // Next badge
          _buildBadgeItem(
            context,
            badge: level.nextBadge,
            isEarned: false,
            currentValue: level.currentValue,
            requiredValue: level.requiredValue,
            progress: level.progress,
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeItem(
    BuildContext context, {
    required BadgeEntity? badge,
    required bool isEarned,
    int? currentValue,
    int? requiredValue,
    double? progress,
  }) {
    if (badge == null) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder:
              (ctx) => FractionallySizedBox(
                widthFactor: 1,
                child:
                    isEarned
                        ? BadgeDetailsSheet(
                          badge: badge,
                          imageUrl: badgeAssetPath(badge),
                        )
                        : NextBadgeProgressSheet(
                          badge: badge,
                          imageUrl: badgeAssetPath(badge),
                          currentValue: currentValue ?? 0,
                          requiredValue: requiredValue ?? 0,
                          progress: progress ?? 0,
                        ),
              ),
        );
      },
      child: Row(
        children: [
          Image.asset(
            badgeAssetPath(badge),
            width: 30,
            height: 30,
            errorBuilder:
                (context, error, stackTrace) => const Icon(
                  Icons.emoji_events,
                  size: 30,
                  color: Colors.grey,
                ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                badge.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Text(
                "Level ${badge.level}",
                style: const TextStyle(color: Colors.grey, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
