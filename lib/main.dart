import 'package:flutter/material.dart';

// Import the signup page from the 'pages' folder
import 'pages/signup.dart'; // Adjusted the import path

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
      // Remove 'const' from here since SignUpPage does not have a 'const' constructor
      home: SignUpPage(), // Now using the signup page from the 'pages' folder
    );
  }
}
