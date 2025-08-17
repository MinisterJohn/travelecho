import 'package:flutter/material.dart';

import '../../../milestones_exports.dart';

/// Bottom sheet for not-yet-earned badges
class NextBadgeProgressSheet extends StatelessWidget {
  final BadgeEntity badge;
  final String imageUrl;
  final int currentValue;
  final int requiredValue;
  final double progress;

  const NextBadgeProgressSheet({
    required this.badge,
    required this.imageUrl,
    required this.currentValue,
    required this.requiredValue,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final leftToNext = (requiredValue - currentValue).clamp(0, double.infinity);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imageUrl,
            width: 100,
            height: 100,
            errorBuilder:
                (context, error, stackTrace) => const Icon(
                  Icons.emoji_events,
                  size: 100,
                  color: Colors.grey,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            badge.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          WidgetsSpacer.verticalSpacer8,
          Text(
            "${badge.category} badge - Level ${badge.level}",
            style: const TextStyle(
              color: AppColors.defaultColor400,
              fontSize: 16,
            ),
          ),
          WidgetsSpacer.verticalSpacer16,
          Text(
            badge.description,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.defaultColor,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          WidgetsSpacer.verticalSpacer32,

          // Progress section
          Text(
            "Progress",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          WidgetsSpacer.verticalSpacer8,
          LinearProgressIndicator(
            value: progress / 100,
            backgroundColor: AppColors.defaultColor100,
            color: AppColors.primaryColor,
            minHeight: 10,
            borderRadius: BorderRadius.circular(12),
          ),
          WidgetsSpacer.verticalSpacer8,
          Text(
            "$currentValue / $requiredValue ${badge.category.toLowerCase()}",
            style: const TextStyle(fontSize: 14, color: AppColors.defaultColor),
          ),
          WidgetsSpacer.verticalSpacer8,
          Text(
            "$leftToNext more to unlock this badge",
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
