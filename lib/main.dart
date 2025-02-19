import 'package:flutter/material.dart';
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:travelecho/config/theme/theme.dart";
import "package:travelecho/features/splashscreen/presentation/bloc/splash_cubit.dart";
import "package:travelecho/features/splashscreen/presentation/pages/splashscreen.dart";
import "package:travelecho/service_locator.dart";

// Import the signup and login pages with aliases to avoid ambiguity
import 'features/auth/presentation/pages/signup.dart' as signup;
import 'features/auth/presentation/pages/login.dart' as login;
import "features/auth/presentation/pages/forgotpassword.dart" as forgotpassword;
import "features/auth/presentation/pages/verificationcodepage.dart"
    as verificationcodepage;
import "features/auth/presentation/pages/resetpassword.dart" as resetpassword;
import "features/auth/presentation/pages/passwordresetnotification.dart"
    as passwordresetnotification;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle( statusBarColor: Colors.transparent, // Transparent status bar
    statusBarIconBrightness: Brightness.dark, // Black icons
    systemNavigationBarColor: Colors.white, // Optional: Change navigation bar color
    systemNavigationBarIconBrightness: Brightness.dark,));
    return BlocProvider(
      create: (context) => SplashCubit()..appStarted(),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Travel Echo',
        theme: AppTheme.appTheme,
        // Define routes for navigation using aliases
        routes: {
          '/signup': (context) =>
              const signup.SignUpPage(), // Use alias to call SignUpPage
          '/login': (context) =>
              const login.LoginPage(), // Use alias to call LoginPage
          '/forgotpassword': (context) =>
              const forgotpassword.ForgotPasswordPage(),
          '/verificationcode': (context) =>
              const verificationcodepage.OtpForm(),
          '/resetpassword': (context) =>
              const resetpassword.ResetPasswordPage(),
          '/passwordresetsuccess': (context) =>
              const passwordresetnotification.PasswordResetFeedback(),
          // '/homescreen': (context) => HomeScreen(),
          '/splashscreen': (context) => const SplashScreen(),
        },
        home: const SplashScreen(), // Use alias for SignUpPage
      ),)
    );
  }
}
