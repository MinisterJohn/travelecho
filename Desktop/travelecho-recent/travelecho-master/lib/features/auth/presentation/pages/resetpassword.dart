import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/app_navigation.dart';
import 'package:travelecho/core/constants/constants.dart';
import 'package:travelecho/features/auth/presentation/pages/signup.dart';
import 'package:travelecho/features/auth/presentation/widgets/heading.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPasswordPage> {
  bool _isPasswordVisible = false; // Track password visibility
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

  GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: WidgetsSpacer.pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeadingText(text: "Reset Password"),
              WidgetsSpacer.verticalSpacer32,
              _newPasswordForm(),
              WidgetsSpacer.verticalSpacer16,
              WidgetsSpacer.verticalSpacer32,
              _signUpText(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _newPasswordForm() {
    return Form(
      key: passwordFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: _newPasswordController,
            obscureText: !_isPasswordVisible, // Toggle password visibility
            decoration: InputDecoration(
              labelText: 'New Password',
              helperText: "Password must be at least 8 characters",
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible =
                        !_isPasswordVisible; // Toggle visibility
                  });
                },
              ),
            ),
            validator: (newPassword) {
              if (newPassword == null || newPassword.isEmpty) {
                return "Enter new password";
              } else if (newPassword.length < 8) {
                return "Password is less than 8 characters";
              }
              return null; // Return null when password is valid
            },
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            controller: _confirmNewPasswordController,
            obscureText: true, // Toggle password visibility
            decoration: const InputDecoration(
              labelText: 'Confirm Password',
              border: OutlineInputBorder(),
            ),
            validator: (cNewPassword) {
              // Check if new password is already validated first
              if (_newPasswordController.text.length >=
                  8) if (cNewPassword == null || cNewPassword.isEmpty) {
                return "Re-enter new password";
              } else if (cNewPassword != _newPasswordController.text) {
                return "Password Mismatch";
              }
              return null; // Return null if password matches
            },
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              if (passwordFormKey.currentState?.validate() ?? false) {
                Navigator.pushNamed(context, '/passwordresetsuccess');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Text(
              'Reset Password',
              style: TextStyle(color: AppColors.white, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _signUpText(BuildContext context) {
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
              recognizer: TapGestureRecognizer()
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
}
