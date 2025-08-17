import 'package:flutter/material.dart';

class LoginAppleButton extends StatelessWidget {
  final VoidCallback onTap;
  const LoginAppleButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/auth/apple_logo.png', height: 20),
            const SizedBox(width: 10),
            const Text('Sign in with Apple ID'),
          ],
        ),
      ),
    );
  }
}
