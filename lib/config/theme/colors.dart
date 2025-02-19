import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xff930BFF); // Example color code
  static final Color primaryColor300 =
      Color.fromARGB(102, 145, 11, 255).withOpacity(0.3); // Example color code
  static final Color primaryColor100 =
      Color.fromARGB(26, 145, 11, 255).withOpacity(0.1); // Example color code
  static const Color secondaryColor = Color.fromARGB(255, 150, 150, 150);
  static const Color errorColor = Colors.red;
  static final Color errorColor300 = Colors.red.shade300;
  static const Color defaultColor = Color.fromARGB(255, 20, 20, 20);
  static final Color defaultColor400 =
      const Color.fromARGB(225, 20, 20, 20).withOpacity(0.4);
  static final Color defaultColor100 =
      const Color.fromARGB(225, 20, 20, 20).withOpacity(0.1);
  static const Color white = Colors.white;
}
