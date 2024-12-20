import 'package:flutter/material.dart';

// Import the signup and login pages with aliases to avoid ambiguity
import 'pages/signup.dart' as signup;
import 'pages/login.dart' as login;
import "pages/welcomepage.dart" as welcomepage;
import "pages/forgotpassword.dart" as forgotpassword;
import "pages/verificationcodepage.dart" as verificationcodepage;
import "pages/resetpassword.dart" as resetpassword;
import "pages/passwordresetnotification.dart" as passwordresetnotification;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel Echo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Define routes for navigation using aliases
      routes: {
        '/signup': (context) =>
            const signup.SignUpPage(), // Use alias to call SignUpPage
        '/login': (context) =>
            const login.LoginPage(), // Use alias to call LoginPage
        '/welcome': (context) => welcomepage.WelcomePage(),
        '/forgotpassword': (context) =>
            const forgotpassword.ForgotPasswordPage(),
        '/verificationcode': (context) => const verificationcodepage.OtpForm(),
        '/resetpassword': (context) => const resetpassword.ResetPassword(),
        '/passwordresetsuccess': (context) =>
            const passwordresetnotification.PasswordResetFeedback(),
      },
      home: welcomepage.WelcomePage(), // Use alias for SignUpPage
    );
  }
}
