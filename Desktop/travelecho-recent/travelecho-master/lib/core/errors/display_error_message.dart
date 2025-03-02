import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/constants.dart';

class DisplayMessage {
  static void errorMessage(String message, BuildContext context) {
    final snackbar = SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  static void successMessage(String message, BuildContext context) {
    final snackbar = SnackBar(
      content: Row(
        children: [
          const Icon(LineIcons.checkCircleAlt, color: AppColors.white,),
          WidgetsSpacer.horinzontalSpacer8,
          Text(message)
        ],
      ),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
