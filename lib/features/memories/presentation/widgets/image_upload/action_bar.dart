// lib/widgets/action_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "../../../memories_exports.dart";

class ActionBar extends StatelessWidget {
  final Future<void> Function()? onTakePicture;
  final Future<void> Function()? onSelectFromGallery;
  final VoidCallback? onClear;
  final VoidCallback? onUpload;
  final bool isUploading;

  const ActionBar({
    super.key,
    this.onTakePicture,
    this.onSelectFromGallery,
    this.onClear,
    this.onUpload,
    this.isUploading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onTakePicture,
              child: Container(
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: AppColors.white,
                  size: 30.sp,
                ),
              ),
            ),
            WidgetsSpacer.horizontalSpacer20,
            GestureDetector(
              onTap: onSelectFromGallery,
              child: Container(
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor100,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(
                  Icons.photo_library_outlined,
                  color: AppColors.primaryColor,
                  size: 30.sp,
                ),
              ),
            ),
          ],
        ),
        WidgetsSpacer.verticalSpacer16,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (onClear != null)
              TextButton(
                onPressed: onClear,
                child: Text(
                  'Clear Images',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.defaultColor400,
                  ),
                ),
              ),
            WidgetsSpacer.horizontalSpacer8,
            if (onUpload != null)
              ElevatedButton(
                onPressed: onUpload,
                child: isUploading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'Upload Images',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
              ),
          ],
        ),
      ],
    );
  }
}
