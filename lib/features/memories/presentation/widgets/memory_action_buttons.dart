import 'package:flutter/material.dart';
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            isEditing ? 'Update Memory' : 'Create Memory',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                ),
              ),
            ),
            WidgetsSpacer.horinzontalSpacer8,
            // Add/Update Pictures Button
            Flexible(
              flex: 5,
              child: SizedBox(
                height: 48.h,
                child: TextButton(
                  onPressed: isLoading ? null : onAddUpdatePictures,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                            strokeWidth: 2,
                          ),
                        )
                      : FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                LineIcons.image,
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                isEditing ? 'Update Pictures' : 'Add Pictures',
                                style: const TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
