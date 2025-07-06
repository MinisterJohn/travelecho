import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../memories_exports.dart';

class TagButton extends StatefulWidget {
  final String tag;

  const TagButton({super.key, required this.tag});

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
      style: mergeWithThemeButtonStyle(
        context,
        ElevatedButton.styleFrom(
          minimumSize: Size(10.w, 50.h),
          backgroundColor:
              _isSelected
                  ? AppColors.primaryColor
                  : AppColors
                      .primaryColor100, // Change color based on selection
        ),
      ),
      child: Text(
        widget.tag,
        style: TextStyle(
          color: _isSelected ? AppColors.white : AppColors.defaultColor,
          fontSize: FontSize.size14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
