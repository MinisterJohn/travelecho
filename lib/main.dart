import 'package:flutter/material.dart';

// Import the signup and login pages with aliases to avoid ambiguity
import 'pages/signup.dart' as signup;
import 'pages/login.dart' as login;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Echo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Define routes for navigation using aliases
      routes: {
        '/signup': (context) => signup.SignUpPage(),  // Use alias to call SignUpPage
        '/login': (context) => login.LoginPage(),     // Use alias to call LoginPage
      },
      home: const signup.SignUpPage(), // Use alias for SignUpPage
    );
  }
}
