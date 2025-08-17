import 'package:flutter/material.dart';
import '../../../milestones_exports.dart';

class EarnedBadgesHeader extends StatelessWidget {
  final String? username;
  final int totalCount;

  const EarnedBadgesHeader({
    super.key,
    required this.username,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Icon(Icons.emoji_events, color: AppColors.primaryColor, size: 80),
          WidgetsSpacer.verticalSpacer16,
          Text(
            "Well done, ${username ?? 'Explorer'}!",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          WidgetsSpacer.verticalSpacer8,
          Text(
            "You've earned $totalCount badge${totalCount == 1 ? '' : 's'}!",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
