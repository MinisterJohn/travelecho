import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth_exports.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false; // Track password visibility
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoginSuccess) {
          AppNavigator.pushReplacement(context, const RootPage());
        } else if (state is AuthFailure) {
          DisplayMessage.errorMessage(state.error, context);
        }
      },
      child: Scaffold(
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

                // Email Address Field
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    prefixIcon: Icon(Icons.email_outlined),
                    prefixIconColor: AppColors.primaryColor300,
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                WidgetsSpacer.verticalSpacer16,

                // Password Field
                TextField(
                  controller: _passwordController,
                  obscureText:
                      !_isPasswordVisible, // Toggle password visibility
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock_outline),
                    prefixIconColor: AppColors.primaryColor300,
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
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed:
                            state is AuthLoading ? null : () => _handleLogin(),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: state is AuthLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors.white),
                                ),
                              )
                            : const Text('Login',
                                style: TextStyle(color: AppColors.white)),
                      );
                    },
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/auth/google_logo.png',
                            height: 20),
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/auth/apple_logo.png',
                            height: 20),
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

  void _handleLogin() {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      DisplayMessage.errorMessage("Please enter all fields", context);
    } else {
      context.read<AuthBloc>().add(LoginEvent(email: email, password: password));
    }
  }
}
