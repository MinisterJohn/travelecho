import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

import 'package:travelecho/navigation_menu/blocs/navigation_menu_cubit.dart';
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
  // bool _showBiometricOption = false;
  bool _isPasswordFieldVisible = false;
  bool _isBiometricEnabledForEmail = false;

  @override
  void initState() {
    super.initState();
    _loadLastBiometricEmail(context);
    _emailController.addListener(_checkBiometricForEmail);
  }

  Future<void> _loadLastBiometricEmail(BuildContext context) async {
    final lastEmail = await LoginStorageUtils.getLastBiometricEmail();
    print(lastEmail);
    if (!mounted) return;
    if (lastEmail != null && lastEmail.isNotEmpty) {
      _emailController.text = lastEmail; // prefill
      await _checkBiometricForEmail();
      if (!mounted) return;
      // Auto-trigger biometric login
      if (_isBiometricEnabledForEmail) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _handleBiometricLogin(context);
          }
        });
      }
    }
  }

  Future<void> _checkBiometricForEmail() async {
    final email = _emailController.text.trim().toLowerCase();
    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.[a-zA-Z]{2,}$');
    if (email.isEmpty || !emailRegex.hasMatch(email)) {
      setState(() {
        _isBiometricEnabledForEmail = false;
        _isPasswordFieldVisible = false;
      });
      return;
    }
    final biometricsEnabled =
        await LoginStorageUtils.isBiometricsEnabledForEmail(email);
    setState(() {
      _isBiometricEnabledForEmail = biometricsEnabled;
      _isPasswordFieldVisible = !biometricsEnabled;
    });
  }

  Future<void> _handleBiometricLogin(BuildContext context) async {
    final localAuth = LocalAuthentication();
    final didAuthenticate = await localAuth.authenticate(
      localizedReason: 'Authenticate to login',
      options: const AuthenticationOptions(
        biometricOnly: true,
        stickyAuth: true,
      ),
    );

    if (!mounted) return;
    if (didAuthenticate) {
      final email = await LoginStorageUtils.getLastBiometricEmail() ?? '';
      final password = await LoginStorageUtils.getBiometricPassword(email);
      if (!mounted) return;
      if (email.isNotEmpty && password != null) {
        // Call your login API automatically
        context.read<AuthBloc>().add(
          LoginEvent(email: email, password: password),
        );
      } else {
        DisplayMessage.errorMessage(
          'Stored credentials not found. Please login manually.',
          context,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthUnverifiedUser) {
          // Navigate to VerificationCodePage for unverified users
          AppNavigator.push(
            context,
            OtpForm(
              email:
                  _emailController
                      .text, // Pass the email if available in the state
              isSignup: false,
            ),
          );
        } else if (state is AuthLoginSuccess) {
          // if (_isBiometricEnabledForEmail) {
            await BiometricsPrompt.maybeShow(
              context,
              email: _emailController.text,
              password: _passwordController.text,
              onEnabled: () => debugPrint("Biometrics setup done"),
            );
          // }
          AppNavigator.pushReplacement(
            context,
            BlocProvider(
              create: (context) => sl<NavigationMenuCubit>(),
              child: const RootPage(),
            ),
          );
        } else if (state is AuthFailure) {
          DisplayMessage.errorMessage(state.error, context);
        }
      },
      child: Scaffold(
        body: ScreenContainer(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Login Text
                signInTitle(),
                WidgetsSpacer.verticalSpacer32,

                // Email Address Field
                LoginEmailField(controller: _emailController),
                WidgetsSpacer.verticalSpacer16,

                if (_isBiometricEnabledForEmail &&
                    !_isPasswordFieldVisible) ...[
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return LoginBiometricButton(
                        onPressed: () => _handleBiometricLogin(context),
                        isLoading: state is AuthLoading,
                      );
                    },
                  ),
                  WidgetsSpacer.verticalSpacer8,
                  Center(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _isPasswordFieldVisible = true;
                        });
                      },
                      child: const Text(
                        'Use password instead',
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ),
                  ),
                ],
                if (_isPasswordFieldVisible) ...[
                  LoginPasswordField(
                    controller: _passwordController,
                    isPasswordVisible: _isPasswordVisible,
                    onVisibilityToggle: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  WidgetsSpacer.verticalSpacer8,
                  if (_isBiometricEnabledForEmail)
                    Center(
                      child: TextButton.icon(
                        onPressed: () {
                          setState(() {
                            _isPasswordFieldVisible = false;
                          });
                        },
                        icon: Icon(Icons.fingerprint),
                        label: const Text(
                          'Use fingerprint instead',
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                      ),
                    ),
                  WidgetsSpacer.verticalSpacer8,
                  forgotPasswordText(context, _emailController.text),
                  WidgetsSpacer.verticalSpacer16,
                  Center(
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return LoginButton(
                          onPressed:
                              () => handleLogin(
                                context: context,
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                          isLoading: state is AuthLoading,
                        );
                      },
                    ),
                  ),
                  WidgetsSpacer.verticalSpacer16,
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
                  LoginGoogleButton(
                    onTap: () {
                      // Handle Google Login Logic
                    },
                  ),
                  WidgetsSpacer.verticalSpacer8,
                  LoginAppleButton(
                    onTap: () {
                      // Handle Apple ID Login Logic
                    },
                  ),
                ],
                WidgetsSpacer.verticalSpacer16,

                // Sign Up Prompt
                signUpText(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
