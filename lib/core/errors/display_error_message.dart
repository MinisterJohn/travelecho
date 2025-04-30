import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/constants.dart';

class DisplayMessage {
  static void errorMessage(String message, BuildContext context) {
    final snackbar = SnackBar(
      content: Row(
        children: [
          const Icon(
            LineIcons.timesCircleAlt,
            color: AppColors.errorColor,
          ),
          WidgetsSpacer.horinzontalSpacer8,
          Text(
            message,
            style: const TextStyle(
              color: AppColors.errorColor,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: AppColors.errorColor),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  static void successMessage(String message, BuildContext context) {
    final snackbar = SnackBar(
      content: Row(
        children: [
          const Icon(
            LineIcons.checkCircleAlt,
            color: AppColors.primaryColor,
          ),
          WidgetsSpacer.horinzontalSpacer8,
          Text(message)
        ],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
