import 'package:flutter/material.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/app_navigation.dart';
import 'package:travelecho/core/constants/constants.dart';
import 'package:travelecho/features/auth/presentation/pages/login.dart';
import 'package:travelecho/features/auth/presentation/pages/verificationcodepage.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Forgot Password',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff930BFF),
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Find a flight that matches your destination and schedule it instantly',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
              ),
              WidgetsSpacer.verticalSpacer16,

              // Email Address Field
              _emailForm(),

              // Send Reset Link Button

              WidgetsSpacer.verticalSpacer16,

              // Footer with Login link (will stick to the bottom if space is available)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Remember your password?'),
                  TextButton(
                    onPressed: () {
                      // Navigate to login page
                      AppNavigator.pushAndRemove(context, const LoginPage());
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailForm() {
    return Form(
      key: emailFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email Address',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (email) {
              // Check if email is null or empty
              if (email == null || email.isEmpty) {
                return 'Please enter an email address';
              }
              // Validate email format using regex
              final emailRegex =
                  RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
              if (!emailRegex.hasMatch(email)) {
                return 'Email is invalid';
              }
              return null;
            },
          ),
          WidgetsSpacer.verticalSpacer8,
          Text(
            'A 6 Digit Code will be sent to your email to enable you change your password',
            style: TextStyle(
              fontSize: 12.0,
              color: AppColors.defaultColor400,
            ),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              // Validate the form before proceeding
              if (emailFormKey.currentState?.validate() ?? false) {
                // If form is valid, navigate to verification page
                AppNavigator.push(context, const OtpForm());
                print('Password reset link sent to ${_emailController.text}');
              } else {
                print('Please enter a valid email address');
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
              'Next',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
