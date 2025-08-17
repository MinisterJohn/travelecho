import 'package:flutter/material.dart';
import '../../../milestones_exports.dart';

class MilestoneHeader extends StatelessWidget {
  final BadgeEntity badge;
  final String imageUrl;

  const MilestoneHeader({
    super.key,
    required this.badge,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Congratulations on earning the ${badge.name} badge!",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        WidgetsSpacer.verticalSpacer20,
        Center(
          child: Image.asset(
            imageUrl,
            width: 200,
            height: 200,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.emoji_events,
              size: 120,
              color: Colors.grey,
            ),
          ),
        ),
        WidgetsSpacer.verticalSpacer20,
      ],
    );
  }
}
