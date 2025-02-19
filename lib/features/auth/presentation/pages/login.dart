import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/app_navigation.dart';
import 'package:travelecho/core/constants/constants.dart';
import 'package:travelecho/core/errors/display_error_message.dart';
import 'package:travelecho/features/auth/domain/usecases/auth_usecases.dart';
import 'package:travelecho/features/auth/presentation/pages/forgotpassword.dart';
import 'package:travelecho/features/auth/presentation/pages/resetpassword.dart';
import 'package:travelecho/features/auth/presentation/pages/signup.dart';
import 'package:travelecho/features/auth/data/models/signin_req_params.dart';

import 'package:travelecho/navigation_menu/presentation/root_page.dart';
import 'package:travelecho/service_locator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false; // Track password visibility
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: WidgetsSpacer.pagePadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Login Text
              _signInTitle(),
              WidgetsSpacer.verticalSpacer32,
              // Full Name Field

              TextField(
                controller: _fullNameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                ),
                keyboardType: TextInputType.name,
              ),

              WidgetsSpacer.verticalSpacer16,

              // Email Address Field
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              WidgetsSpacer.verticalSpacer16,

              // Password Field
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible, // Toggle password visibility
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
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
              ),
              WidgetsSpacer.verticalSpacer8,

              _forgotPasswordText(context),

              WidgetsSpacer.verticalSpacer16,

              // Login Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _login(context);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Login',
                      style: TextStyle(color: AppColors.white)),
                ),
              ),

              WidgetsSpacer.verticalSpacer16,

              // Line Separator
              const Row(
                children: [
                  Expanded(child: Divider(thickness: 1)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('OR'),
                  ),
                  Expanded(child: Divider(thickness: 1)),
                ],
              ),

              WidgetsSpacer.verticalSpacer16,

              // Login with Google
              GestureDetector(
                onTap: () {
                  // Handle Google Login Logic
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/auth/google_logo.png', height: 20),
                      const SizedBox(width: 10),
                      const Text('Sign in with Google'),
                    ],
                  ),
                ),
              ),
              WidgetsSpacer.verticalSpacer8,

              // Login with Apple ID
              GestureDetector(
                onTap: () {
                  // Handle Apple ID Login Logic
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
              ),

              WidgetsSpacer.verticalSpacer16,

              // Sign Up Prompt
              _signUpText(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInTitle() {
    return const Text(
      'Login',
      style: TextStyle(
        color: Color(0xff930BFF),
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _forgotPasswordText(BuildContext context) {
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
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  AppNavigator.push(context, const ForgotPasswordPage());
                },
              text: 'Reset',
            ),
          ],
        ),
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

  void _login(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String fullname = _fullNameController.text;

    if (email.isEmpty || password.isEmpty) {
      DisplayMessage.errorMessage("Please enter all fields", context);
    } else {
      // Implement login logic here
      print('Logging in with $email and $password');
      try {
        await sl<SigninUseCase>().call(
            params: SigninReqParams(
                email: email, password: password, fullname: fullname));
        // Navigate to HomeScreen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RootPage()),
        );
      } catch (e) {
        DisplayMessage.errorMessage(e.toString(), context);
      }
    }
  }
}
