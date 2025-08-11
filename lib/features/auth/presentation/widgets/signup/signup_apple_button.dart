import 'package:flutter/material.dart';

class SignupAppleButton extends StatelessWidget {
  final VoidCallback onTap;
  const SignupAppleButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
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
