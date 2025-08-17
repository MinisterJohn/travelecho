import 'package:flutter/material.dart';
import '../../../milestones_exports.dart';

class MilestoneInfo extends StatelessWidget {
  final BadgeEntity badge;
  final String requirementText;

  const MilestoneInfo({
    super.key,
    required this.badge,
    required this.requirementText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Milestone: ${badge.name}",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 15),
        Text.rich(
          TextSpan(
            text: "${badge.category} Badge",
            style: const TextStyle(fontSize: 16, color: AppColors.defaultColor),
            children: [
              TextSpan(
                text: " - Level ${badge.level}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.defaultColor,
                ),
              ),
            ],
          ),
        ),
        Text(
          badge.description,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.defaultColor,
            fontStyle: FontStyle.italic,
          ),
        ),
        WidgetsSpacer.verticalSpacer20,
        Text(
          "Requirement(s):",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        WidgetsSpacer.verticalSpacer8,
        Text(
          requirementText,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
        WidgetsSpacer.verticalSpacer20,
        const Divider(thickness: 1.5, color: AppColors.defaultColor100),
        WidgetsSpacer.verticalSpacer20,
      ],
    );
  }
}
