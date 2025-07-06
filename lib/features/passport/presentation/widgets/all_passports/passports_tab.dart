import 'package:flutter/material.dart';
import '../../../passport_exports.dart';

class TravelDocumentTab extends StatelessWidget {
  final TabController controller;
  final int index;
  final IconData icon;
  final String label;

  const TravelDocumentTab({
    super.key,
    required this.controller,
    required this.index,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = controller.index == index;

    return Container(
      // Make sure it expands evenly inside TabBar
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border:
            isSelected ? null : Border.all(color: AppColors.defaultColor400),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? Colors.white : Colors.black, size: 16),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
