import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/constants.dart';

Widget userHeader() {
  return Row(
    children: [
      Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.defaultColor100,
            child: Icon(LineIcons.user),
          ),
          WidgetsSpacer.horinzontalSpacer8,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '@michaeljohn', // User's name
                style: TextStyle(fontSize: 12), // Reduced font size
              ),
              Text(
                "Lagos, Nigeria",
                style: TextStyle(color: AppColors.defaultColor400),
              )
            ],
          )
        ],
      ),
      const Spacer(),
      IconButton(
        icon: Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.defaultColor400),
                borderRadius: BorderRadius.circular(12)),
            child: Icon(Icons.more_horiz_outlined,
                color: AppColors
                    .defaultColor400)), // Replace with your more icon image path
        onPressed: () {
          // Your action here
        },
      ),
    ],
  );
}
