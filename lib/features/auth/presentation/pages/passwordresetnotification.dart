import 'package:flutter/material.dart';

class PasswordResetFeedback extends StatelessWidget {
  const PasswordResetFeedback({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Text(
              "Password Reset Successful",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: const Text(
                "Login to your account",
                style: TextStyle(color: Color(0xff930BFF)),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
