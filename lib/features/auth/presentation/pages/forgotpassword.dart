import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth_exports.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar("", context),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            setState(() => _isLoading = false);
            // Navigate to verification page
            AppNavigator.push(
              context,
              OtpForm(
                email: _emailController.text,
                isSignup: false,
                isPasswordReset: true,
              ),
            );
          } else if (state is AuthFailure) {
            setState(() => _isLoading = false);
            DisplayMessage.errorMessage(state.error, context);
          } else if (state is AuthLoading) {
            setState(() => _isLoading = true);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: WidgetsSpacer.pagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeadingText(text: "Forgot Password"),
                  WidgetsSpacer.verticalSpacer8,
                  const Text(
                    "Enter your email address to receive a verification code",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: AppColors.defaultColor,
                    ),
                  ),
                  WidgetsSpacer.verticalSpacer32,
                  _emailForm(state),
                  WidgetsSpacer.verticalSpacer16,
                  _loginLink(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _emailForm(AuthState state) {
    return Form(
      key: emailFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _emailController,
            enabled: !_isLoading,
            decoration: const InputDecoration(
              labelText: 'Email Address',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email_outlined),
              prefixIconColor: AppColors.primaryColor300,
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (email) {
              if (email == null || email.isEmpty) {
                return 'Please enter an email address';
              }
              final emailRegex =
                  RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
              if (!emailRegex.hasMatch(email)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          WidgetsSpacer.verticalSpacer8,
          Text(
            'A 6-digit code will be sent to your email',
            style: TextStyle(
              fontSize: FontSize.size14,
              color: AppColors.defaultColor400,
            ),
          ),
          WidgetsSpacer.verticalSpacer32,
          ElevatedButton(
            onPressed: _isLoading
                ? null
                : () {
                    if (emailFormKey.currentState?.validate() ?? false) {
                      context.read<AuthBloc>().add(
                            SendOtpEvent(
                              email: _emailController.text.trim(),
                            ),
                          );
                    }
                  },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: _isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  )
                : const Text(
                    'Send Code',
                  ),
          ),
        ],
      ),
    );
  }

  Widget _loginLink() {
    return Center(
      child: Text.rich(
        TextSpan(
          children: [
            const TextSpan(text: "Remember your password? "),
            TextSpan(
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  AppNavigator.pushAndRemove(context, const LoginPage());
                },
              text: 'Login',
            ),
          ],
        ),
      ),
    );
  }
}
