import 'package:flutter/material.dart';
import '../../../features_exports.dart';

class DriverUploadPhotoScreen extends StatelessWidget {
  const DriverUploadPhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: setAppBar("Verification", context),
      body: Padding(
        padding: WidgetsSpacer.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WidgetsSpacer.verticalSpacer16,
            // Progress bar at the top
            FormProgressBar(
              progress: 0.2, // Example: 20% filled, pass actual value as needed
              color: AppColors.primaryColor,
            ),
            WidgetsSpacer.verticalSpacer32,
            const Text(
              "Upload Photo",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: AppColors.defaultColor,
              ),
            ),
            WidgetsSpacer.verticalSpacer32,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Upload from files
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Handle upload from files
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: const [
                          Icon(
                            Icons.upload_file,
                            color: AppColors.primaryColor,
                            size: 36,
                          ),
                          WidgetsSpacer.verticalSpacer8,
                          Text(
                            "Upload from files",
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                WidgetsSpacer.horizontalSpacer16,
                // Upload from camera
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Handle upload from camera
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: const [
                          Icon(
                            Icons.camera_alt_outlined,
                            color: AppColors.primaryColor,
                            size: 36,
                          ),
                          WidgetsSpacer.verticalSpacer8,
                          Text(
                            "Upload from Camera",
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            WidgetsSpacer.spacer,
            AppPrimaryButton(
              child: const Text(
                "Next",
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                // Handle next action
                AppNavigator.push(
                  context,
                  const DriverVehicleDetailsScreen(),
                );
              },
            ),
            WidgetsSpacer.verticalSpacer16,
          ],
        ),
      ),
    );
  }
}
