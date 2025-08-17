import 'package:flutter/material.dart';
import "../../../auth_exports.dart";

class LoginBiometricButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const LoginBiometricButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Icon(
            Icons.fingerprint,
            color: AppColors.primaryColor,
            size: 73,
          ),
        ),
        WidgetsSpacer.verticalSpacer16,
        Center(
          child: ElevatedButton.icon(
            icon:
                isLoading
                    ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                    : const Icon(Icons.fingerprint),
            label:
                isLoading
                    ? const Text('Logging in...')
                    : const Text(
                      'Login with Fingerprint',
                      style: TextStyle(color: AppColors.white),
                    ),
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              padding: EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),
      ],
    );
  }
}
