import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/constants.dart';
import 'package:travelecho/core/constants/font_size_constants.dart';

class SharePost extends StatelessWidget {
  const SharePost({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(LineIcons.copyAlt, size: FontSize.size32),
          WidgetsSpacer.verticalSpacer32,
          Icon(LineIcons.linkedin, size: FontSize.size32),
          WidgetsSpacer.verticalSpacer32,
          Icon(LineIcons.instagram, size: FontSize.size32),
          WidgetsSpacer.verticalSpacer32,
          Icon(LineIcons.facebook, size: FontSize.size32),
          WidgetsSpacer.verticalSpacer32,
          Icon(LineIcons.pinterest, size: FontSize.size32),
        ],
      ),
    );
  }
}
