import 'package:flutter/material.dart';

class LoginBiometricButton extends StatelessWidget {
  final VoidCallback onPressed;
  const LoginBiometricButton({Key? key, required this.onPressed})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: const Icon(Icons.fingerprint),
      label: const Text('Login with Fingerprint'),
      style: TextButton.styleFrom(
        foregroundColor: Color(0xff930BFF),
        minimumSize: const Size(double.infinity, 50),
      ),
      onPressed: onPressed,
    );
  }
}
