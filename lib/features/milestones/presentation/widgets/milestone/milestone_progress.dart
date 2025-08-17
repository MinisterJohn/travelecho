import 'package:flutter/material.dart';
import '../../../milestones_exports.dart';

class MilestoneProgress extends StatelessWidget {
  final LevelInfoEntity level;
  final BadgeEntity badge;

  const MilestoneProgress({
    super.key,
    required this.level,
    required this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Progress",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Stack(
            alignment: Alignment.center,
            children: [
              LinearProgressIndicator(
                backgroundColor: AppColors.defaultColor100,
                color: AppColors.primaryColor,
                value: level.progress / 100,
                minHeight: 12,
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
          const SizedBox(height: 8),
          Text(
            "${level.currentValue} / ${level.requiredValue} ${badge.category.toLowerCase()}",
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
