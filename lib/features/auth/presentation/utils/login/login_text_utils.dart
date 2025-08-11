import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../../../auth_exports.dart';

Widget signInTitle() {
  return const Text(
    'Login',
    style: TextStyle(
      color: Color(0xff930BFF),
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget forgotPasswordText(BuildContext context, String email) {
  return Center(
    child: Text.rich(
      TextSpan(
        children: [
          const TextSpan(text: "Forgot Password? "),
          TextSpan(
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    AppNavigator.push(
                      context,
                      ForgotPasswordPage(email: email),
                    );
                  },
            text: 'Reset',
          ),
        ],
      ),
    ),
  );
}

Widget signUpText(BuildContext context) {
  return Center(
    child: Text.rich(
      TextSpan(
        children: [
          const TextSpan(text: "Don't have an account? "),
          TextSpan(
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    AppNavigator.push(context, const SignUpPage());
                  },
            text: 'Sign Up',
          ),
        ],
      ),
    ),
  );
}
