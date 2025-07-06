import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import '../../../passport_exports.dart';

class TravelDocumentTabBar extends StatelessWidget {
  final TabController controller;
  const TravelDocumentTabBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      indicatorColor: Colors.transparent,
      dividerHeight: 0,
      labelPadding: const EdgeInsets.symmetric(horizontal: 4),
      tabs: [
        _buildTab(context, 0, LineIcons.infoCircle, 'Details'),
        _buildTab(context, 1, LineIcons.image, 'Images'),
      ],
    );
  }

  Widget _buildTab(
    BuildContext context,
    int index,
    IconData icon,
    String label,
  ) {
    final isSelected = controller.index == index;
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
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(color: isSelected ? Colors.white : Colors.black),
          ),
        ],
      ),
    );
  }
}
