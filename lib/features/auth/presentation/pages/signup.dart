import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth_exports.dart';

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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthSignupSuccess) {
          AppNavigator.push(
            context,
            OtpForm(email: state.email, isSignup: true),
          );
        } else if (state is AuthFailure) {
          DisplayMessage.errorMessage(state.error, context);
        }
      },
      child: Scaffold(
        body: ScreenContainer(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SignupTitleText(),
                WidgetsSpacer.verticalSpacer8,
                const SignupDescriptionText(),
                WidgetsSpacer.verticalSpacer32,
                _signupForm(context),
                WidgetsSpacer.verticalSpacer16,
                signInText(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _signupForm(BuildContext context) {
    return Form(
      key: form,
      child: Column(
        children: [
          // Full Name Field
          TextFormField(
            controller: _fullNameController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              labelText: 'Full Name',
              prefixIcon: Icon(Icons.person_outline),
              prefixIconColor: AppColors.primaryColor300,
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
              prefixIcon: Icon(Icons.email_outlined),
              prefixIconColor: AppColors.primaryColor300,
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
            },
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock_outline),
              prefixIconColor: AppColors.primaryColor300,
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
            ),
          ),
          WidgetsSpacer.verticalSpacer16,

          // Confirm Password Field
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: !_isConfirmPasswordVisible,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              prefixIcon: const Icon(Icons.lock_outline),
              prefixIconColor: AppColors.primaryColor300,
              suffixIcon: IconButton(
                icon: Icon(
                  _isConfirmPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
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
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return SignupButton(
                isLoading: state is AuthLoading,
                onPressed: () {
                  state is AuthLoading
                      ? null
                      : () async {
                        if (form.currentState!.validate()) {
                          if (_passwordController.text ==
                              _confirmPasswordController.text) {
                            context.read<AuthBloc>().add(
                              SignupEvent(
                                email: _emailController.text,
                                password: _passwordController.text,
                                name: _fullNameController.text,
                              ),
                            );
                          } else {
                            DisplayMessage.errorMessage(
                              'Passwords do not match',
                              context,
                            );
                          }
                        }
                      };
                },
              );
            },
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
          SignupGoogleButton(
            onTap: () {
              // Handle Google Login Logic
            },
          ),
          WidgetsSpacer.verticalSpacer8,

          // Login with Apple ID
          SignupAppleButton(
            onTap: () {
              // Handle Apple ID Login Logic
            },
          ),

          WidgetsSpacer.verticalSpacer16,
        ],
      ),
    );
  }

}
