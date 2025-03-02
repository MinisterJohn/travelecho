import 'package:flutter/material.dart';
import 'package:travelecho/config/theme/colors.dart';

Future DraggableBottomModal(BuildContext context, Widget widget) {
  return showModalBottomSheet(
      backgroundColor: AppColors.white,
      elevation: 0,
      context: context,
      isScrollControlled: true, // Allows full height control
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
            initialChildSize: 0.75, // Starts at 75% of screen height
            minChildSize: 0.75, // Minimum height is 75% of screen height
            maxChildSize: 0.95, // Maximum height is 95% of screen height
            expand: false, // Prevents forced full-screen mode
            builder: (context, scrollController) {
              return Container(
                  padding: const EdgeInsets.all(20.0), child: widget);
            });
      });
}
