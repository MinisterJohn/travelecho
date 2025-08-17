import "package:flutter/material.dart";
import "package:intl/intl.dart";

import "../../../milestones_exports.dart";

class BadgeDetailsSheet extends StatelessWidget {
  final BadgeEntity badge;
  final String imageUrl;

  const BadgeDetailsSheet({required this.badge, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
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

          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.primaryColor100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.check_circle,
                  color: AppColors.primaryColor,
                  size: 20,
                ),
                SizedBox(width: 6),
                Text(
                  "Earned",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          WidgetsSpacer.verticalSpacer8,
          Text(
            badge.earnedAt != null
                ? DateFormat('d MMMM yyyy').format(badge.earnedAt!.toLocal())
                : '',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.defaultColor400,
            ),
            textAlign: TextAlign.center,
          ),
          WidgetsSpacer.verticalSpacer16,
        ],
      ),
    );
  }
}
