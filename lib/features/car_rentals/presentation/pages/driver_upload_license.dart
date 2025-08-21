import 'package:flutter/material.dart';
import '../../../features_exports.dart';

class DriverUploadLicenseScreen extends StatelessWidget {
  const DriverUploadLicenseScreen({super.key});

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
              progress: 0.7, // Example: 70% filled, pass actual value as needed
              color: AppColors.primaryColor,
            ),
            WidgetsSpacer.verticalSpacer20,
            const Text(
              "Upload drivers licence",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: AppColors.defaultColor,
              ),
            ),
            WidgetsSpacer.verticalSpacer32,
            Center(
              child: GestureDetector(
                onTap: () {
                  // Handle upload license
                },
                child: Container(
                  width: 120,
                  height: 90,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.upload_file,
                    color: AppColors.primaryColor,
                    size: 40,
                  ),
                ),
              ),
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
                  const DriverAgreementScreen(),
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
