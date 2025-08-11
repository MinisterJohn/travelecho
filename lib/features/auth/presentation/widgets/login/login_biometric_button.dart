import 'package:flutter/material.dart';
import "../../../auth_exports.dart";

class LoginBiometricButton extends StatelessWidget {
  final VoidCallback onPressed;
  const LoginBiometricButton({Key? key, required this.onPressed})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.fingerprint, color: AppColors.primaryColor, size: 73),
        WidgetsSpacer.verticalSpacer16,
        ElevatedButton.icon(
          style: mergeWithThemeButtonStyle(
            context,
            ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
          onPressed: onPressed,
          icon: const Icon(Icons.fingerprint),
          label: const Text('Login with Fingerprint'),
        ),
      ],
    );
  }
}
