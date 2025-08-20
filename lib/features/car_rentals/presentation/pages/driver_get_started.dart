import 'package:flutter/material.dart';
import '../../../features_exports.dart';

class BecomeDriverScreen extends StatelessWidget {
  const BecomeDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: WidgetsSpacer.pagePadding,
        child: Column(
          children: [
            WidgetsSpacer.verticalSpacer32,
            // SizedBox(
            //   child: Image.asset(
            //     'assets/images/car_rentals/car_rentals.png',
            //     fit: BoxFit.contain,
            //     height: 300,
            //   ),
            // ),
            WidgetsSpacer.verticalSpacer32,
            WidgetsSpacer.spacer,
            const Text(
              "Become a highly paid driver",
              style: TextStyle(
                color: AppColors.defaultColor,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            WidgetsSpacer.verticalSpacer16,
            AppPrimaryButton(
              child: const Text(
                "Get Started",
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                // Handle get started logic
                AppNavigator.push(
                  context,
                  const DriverUploadPhotoScreen(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


