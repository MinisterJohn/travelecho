import 'package:flutter/material.dart' hide CarouselController;
import '../../trip_exports.dart';

class TripProgressDisplay extends StatelessWidget {
  final IconData progressIcon;
  final String progressKey;
  final String progressValue;
  final VoidCallback onPressed;
  const TripProgressDisplay(
      {super.key,
      required this.progressIcon,
      required this.progressKey,
      required this.progressValue,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(50, 70),
        backgroundColor: Colors.white,
        shadowColor: AppColors.defaultColor100,
        foregroundColor: Colors.black,
        elevation: 1.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(progressKey,
              style: const TextStyle(
                  color: AppColors.defaultColor400, fontSize: 12)),
          WidgetsSpacer.verticalSpacer8,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(progressIcon, size: 24, color: AppColors.defaultColor400),
              WidgetsSpacer.horizontalSpacer8,
              Text(
                progressValue,
                style: TextStyle(
                    color: AppColors.defaultColor,
                    fontSize: FontSize.size16,
                    fontWeight: FontWeight.bold),
                softWrap: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
