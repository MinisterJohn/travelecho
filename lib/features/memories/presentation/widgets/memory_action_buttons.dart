import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import '../../memories_exports.dart';

class MemoryActionButtons extends StatelessWidget {
  final bool isLoading;
  final bool isEditing;
  final VoidCallback onCreateUpdate;
  final VoidCallback onAddUpdatePictures;

  const MemoryActionButtons({
    super.key,
    required this.isLoading,
    required this.isEditing,
    required this.onCreateUpdate,
    required this.onAddUpdatePictures,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Create/Update Memory Button
            Flexible(
              flex: 5,
              child: SizedBox(
                height: 48.h,
                child: ElevatedButton(
                  onPressed: isLoading ? null : onCreateUpdate,
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        )
                      : Text(
                          isEditing ? 'Update Memory' : 'Create Memory',
                        ),
                ),
              ),
            ),
            WidgetsSpacer.horizontalSpacer8,
            // Add/Update Pictures Button
            TextButton(
              onPressed: isLoading ? null : onAddUpdatePictures,
              child: isLoading
                  ? const CircularProgressIndicator(
                      color: AppColors.primaryColor,
                      strokeWidth: 2,
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          LineIcons.image,
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          isEditing ? 'Update Pictures' : 'Add Pictures',
                        ),
                      ],
                    ),
            ),
          ],
        );
      },
    );
  }
}
