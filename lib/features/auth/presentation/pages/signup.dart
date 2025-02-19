import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelecho/core/constants/app_navigation.dart';
import 'package:travelecho/core/constants/constants.dart';
import 'package:travelecho/core/errors/display_error_message.dart';
import 'package:travelecho/features/auth/data/models/signup_req_params.dart';
import 'package:travelecho/features/auth/domain/usecases/auth_usecases.dart';
import 'package:travelecho/features/auth/presentation/bloc/user_bloc.dart';
import 'package:travelecho/features/auth/presentation/bloc/user_state.dart';
import 'package:travelecho/features/auth/presentation/pages/login.dart';
import 'package:travelecho/features/auth/presentation/pages/new_user_welcome.dart';
import 'package:travelecho/navigation_menu/presentation/root_page.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/service_locator.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isPasswordVisible = false; // Track password visibility
  bool _isConfirmPasswordVisible = false; // Track confirm password visibility
  GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: WidgetsSpacer.pagePadding,
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading){
                 return const Center(child: CircularProgressIndicator());
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _signupTitleText(),
                  WidgetsSpacer.verticalSpacer8,
                  _signupDescriptionText(),

                  WidgetsSpacer.verticalSpacer32,

                  _signupForm(context),
                  WidgetsSpacer.verticalSpacer16,
                  _signInText(context),
                  // Footer with Login link
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _signupTitleText() {
    return const Text(
      'Sign Up',
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Color(0xff930BFF),
      ),
    );
  }

  Widget _signupDescriptionText() {
    return const Text(
      'Find a flight that matches your destination and schedule it instantly.',
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.black54,
      ),
    );
  }

  Widget _signupForm(BuildContext context) {
    return Form(
      child: Column(
        children: [
          // Full Name Field
          TextFormField(
            controller: _fullNameController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              labelText: 'Full Name',
              // border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value!.isEmpty) return "Please enter a username";
              return null;
            },
          ),
          WidgetsSpacer.verticalSpacer16,

          // Email Address Field
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              hintText: 'Email Address',
              // border: OutlineInputBorder(),
              // focusedBorder:
              //     OutlineInputBorder(borderSide: BorderSide(width: 1))
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty) return "Please enter a username";
              return null;
            },
          ),
          WidgetsSpacer.verticalSpacer16,

          // Password Field
          TextFormField(
            controller: _passwordController,
            obscureText: !_isPasswordVisible,
            validator: (value) {
              if (value!.isEmpty) return "Please enter password";
              return null;
            }, // Toggle password visibility
            decoration: InputDecoration(
              labelText: 'Password',
              // border: const OutlineInputBorder(),
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
          ),
          WidgetsSpacer.verticalSpacer16,

          // Confirm Password Field
          TextFormField(
            controller: _confirmPasswordController,
            obscureText:
                !_isConfirmPasswordVisible, // Toggle confirm password visibility
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              // border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(
                  _isConfirmPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _isConfirmPasswordVisible =
                        !_isConfirmPasswordVisible; // Toggle visibility
                  });
                },
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) return "Confirm your password";
              return null;
            },
          ),
          WidgetsSpacer.verticalSpacer32,

          // Sign Up Button
          ElevatedButton(
            onPressed: () async {
              if (_passwordController.text == _confirmPasswordController.text) {
                try {
                  await sl<SignupUseCase>().call(
                      params: SignupReqParams(
                          email: _emailController.text,
                          password: _passwordController.text,
                          name: _fullNameController.text));

                  AppNavigator.push(context, const NewUserWelcomePage());
                } catch (e) {
                  DisplayMessage.errorMessage(e.toString(), context);
                }
              } else {
                DisplayMessage.errorMessage('Passwords do not match', context);
              }
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child:
                const Text('Sign Up', style: TextStyle(color: AppColors.white)),
          ),

          WidgetsSpacer.verticalSpacer32,
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
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
          ),

          WidgetsSpacer.verticalSpacer16,
        ],
      ),
    );
  }

  Widget _signInText(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          children: [
            const TextSpan(text: 'Already have an account? '),
            TextSpan(
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  AppNavigator.push(context, const LoginPage());
                },
              text: 'Login',
            ),
          ],
        ),
      ),
    );
  }
}
