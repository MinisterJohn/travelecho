import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelecho/config/theme/colors.dart';
import 'package:travelecho/core/constants/app_navigation.dart';
import 'package:travelecho/core/constants/constants.dart';
import 'package:travelecho/core/constants/font_size_constants.dart';
import 'package:travelecho/features/auth/presentation/bloc/user_bloc.dart';
import 'package:travelecho/features/auth/presentation/pages/signup.dart';
import 'package:travelecho/features/onboarding/presentation/blocs/onboardingpage_cubit.dart';
import 'package:travelecho/features/onboarding/presentation/pages/welcomepage.dart';
import 'package:travelecho/features/splashscreen/presentation/bloc/splash_cubit.dart';
import 'package:travelecho/features/splashscreen/presentation/bloc/splash_state.dart';
import 'package:travelecho/navigation_menu/presentation/root_page.dart';
import 'package:travelecho/service_locator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  late List<bool> _textVisible; // Tracks visibility of each letter
  bool _showSecondText = false; // Tracks visibility of second text and image
  bool _showSpinner = false; // Tracks visibility of the loading spinner

  @override
  void initState() {
    super.initState();
    _textVisible = List.generate("Travel echo".length, (_) => false);
    _animateFirstText();
  }

  Future<void> _animateFirstText() async {
    for (int i = 0; i < _textVisible.length; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      if (!mounted) return; // Ensure the widget is still mounted
      setState(() {
        _textVisible[i] = true;
      });
    }

    // After the first text animation, show the second text with image
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return; // Ensure the widget is still mounted
    setState(() {
      _showSecondText = true;
    });

    // After the second text and image, show the spinner
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return; // Ensure the widget is still mounted
    setState(() {
      _showSpinner = true;
    });

    // Uncomment if navigation is needed
    // await Future.delayed(const Duration(seconds: 3));
    // if (!mounted) return;
    // Navigator.pushNamed(context, "/welcome");
  }

  @override
  void dispose() {
    _animateFirstText(); // Dispose of the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            AppNavigator.pushReplacement(
                context,
                BlocProvider.value(
                  value: sl<AuthBloc>(),
                  child: const SignUpPage(),
                ));
          } else if (state is Authenticated) {
            AppNavigator.pushReplacement(context, const RootPage());
          } else if (state is FirstLaunch) {
            AppNavigator.pushReplacement(
                context,
                BlocProvider(
                  create: (context) => OnboardingPageCubit(),
                  child: const WelcomePage(),
                ));
          }
        },
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // First Text Animation
              if (!_showSecondText && !_showSpinner)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate("Travel echo".length, (index) {
                    return AnimatedOpacity(
                      opacity: _textVisible[index] ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        "Travel echo"[index],
                        style: TextStyle(
                            fontSize: FontSize.size32,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                            fontFamily: "vaio_con_dios"),
                      ),
                    );
                  }),
                ),

              // Second Text and Image Animation
              if (!_showSpinner)
                AnimatedOpacity(
                  opacity: _showSecondText ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 800),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/travel_echo_logo.png", // Replace with your image URL
                        height: 100,
                      ),
                      WidgetsSpacer.verticalSpacer8,
                      Text(
                        "Travel echo",
                        style: TextStyle(
                            fontSize: FontSize.size32,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                            fontFamily: "vaio_con_dios"),
                      ),
                    ],
                  ),
                ),

              // Loading Spinner
              if (_showSpinner)
                AnimatedOpacity(
                  opacity: _showSpinner ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 1000),
                  child: const CircularProgressIndicator(),
                )
            ],
          ),
        ),
      ),
    );
  }
}
