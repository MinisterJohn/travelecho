import 'package:flutter/material.dart';
import '../../../milestones_exports.dart';

class CategoryBadgeGroup extends StatelessWidget {
  final String category;
  final List<BadgeEntity> badges;

  const CategoryBadgeGroup({
    super.key,
    required this.category,
    required this.badges,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$category (${badges.length})",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        WidgetsSpacer.verticalSpacer16,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < badges.length; i++)
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: BadgeTile(
                    badge: badges[i],
                    isLast:
                        badges[i].level ==
                        badges.length, // ✅ tell if it's the last badge
                  ),
                ),
            ],
          ),
        ),
        WidgetsSpacer.verticalSpacer16,
      ],
    );
  }
}
