import 'package:flutter/material.dart' hide CarouselController;
import "../../trip_exports.dart";

class DestinationBottomBar extends StatelessWidget {
  final VoidCallback onClear;
  final VoidCallback onNext;

  const DestinationBottomBar({
    super.key,
    required this.onClear,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlinedButton(
            onPressed: onClear,
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(100, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              side: const BorderSide(color: AppColors.primaryColor300),
            ),
            child: const Text(
              "Clear",
              style: TextStyle(
                color: AppColors.primaryColor300,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: onNext,
            style: mergeWithThemeButtonStyle(
              context,
              ElevatedButton.styleFrom(minimumSize: const Size(100, 40)),
            ),
            child: Text(
              "Next",
              style: TextStyle(
                fontSize: FontSize.size16,
                fontWeight: FontWeight.w400,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
