import 'package:flutter/material.dart';
import '../../../milestones_exports.dart';

class NextBadgeSection extends StatelessWidget {
  final BadgeEntity nextBadge;

  const NextBadgeSection({super.key, required this.nextBadge});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Next Level Badge:",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        WidgetsSpacer.verticalSpacer8,
        Text(
          nextBadge.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.defaultColor,
          ),
        ),
        Text(
          "Level: ${nextBadge.level}",
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.defaultColor,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          "Description: ${nextBadge.description}",
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.defaultColor,
            fontStyle: FontStyle.italic,
          ),
        ),
        WidgetsSpacer.verticalSpacer20,
      ],
    );
  }
}
