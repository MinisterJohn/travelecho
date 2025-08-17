import 'package:flutter/material.dart';

class SignupTitleText extends StatelessWidget {
  const SignupTitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Sign Up',
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Color(0xff930BFF),
      ),
    );
  }
}

class SignupDescriptionText extends StatelessWidget {
  const SignupDescriptionText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Find a flight that matches your destination and schedule it instantly.',
      style: TextStyle(fontSize: 16.0, color: Colors.black54),
    );
  }
}
