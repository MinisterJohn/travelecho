import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/constants.dart';
import 'package:travelecho/core/constants/font_size_constants.dart';
import 'package:travelecho/features/profile/presentation/widgets/bottomModalDraggable.dart';

// ignore: unused_element
void showWhereILiveDialog(BuildContext context) {
  DraggableBottomModal(
    context,
    Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Where I live",
              style: TextStyle(
                  fontSize: FontSize.size16, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Icon(
                LineIcons.timesCircleAlt,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        WidgetsSpacer.verticalSpacer16,
        TextField(
          decoration: InputDecoration(
            fillColor: AppColors.primaryColor100,
            filled: true,
            prefixIcon: const Icon(Icons.search, color: AppColors.primaryColor),
            hintText: "Type your location",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: AppColors.primaryColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: AppColors.primaryColor),
            ),
          ),
        ),
        WidgetsSpacer.verticalSpacer16,
        WidgetsSpacer.spacer,
        GestureDetector(
          onTap: () {
            // Handle the selection action
            Navigator.of(context).pop();
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Center(
              child: Text(
                "Select",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
