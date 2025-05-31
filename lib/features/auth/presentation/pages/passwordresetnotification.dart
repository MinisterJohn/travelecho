import 'package:flutter/material.dart' hide CarouselController;
import "../../auth_exports.dart";

class PasswordResetFeedback extends StatelessWidget {
  const PasswordResetFeedback({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: WidgetsSpacer.pagePadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline,
                size: 80,
                color: AppColors.primaryColor,
              ),
              WidgetsSpacer.verticalSpacer32,
              const Text(
                "Password Reset Successful",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              WidgetsSpacer.verticalSpacer16,
              const Text(
                "Your password has been successfully reset. You can now login with your new password.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.defaultColor,
                ),
              ),
              WidgetsSpacer.verticalSpacer32,
              ElevatedButton(
                onPressed: () {
                  AppNavigator.pushAndRemove(context, const LoginPage());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  "Login to your account",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
