import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelecho/config/theme/colors.dart';

class TagButton extends StatefulWidget {
  final String tag;

  TagButton({required this.tag});

  @override
  _TagButtonState createState() => _TagButtonState();
}

class _TagButtonState extends State<TagButton> {
  bool _isSelected = false; // Track if the tag is selected

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _isSelected = !_isSelected; // Toggle selection state
        });
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(10.w, 50.h),
        backgroundColor: _isSelected
            ? AppColors.primaryColor
            : AppColors.primaryColor100, // Change color based on selection
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text(
        widget.tag,
        style: TextStyle(
            color: _isSelected ? AppColors.white : AppColors.defaultColor),
      ),
    );
  }
}
