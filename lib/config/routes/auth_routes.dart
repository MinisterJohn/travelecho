import 'package:flutter/material.dart';
import "../../features/auth/presentation/pages/login.dart";
import "../../features/auth/presentation/pages/signup.dart";

class AuthRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';

  static Map<String, WidgetBuilder> routes = {
    login: (context) => LoginPage(),
    signup: (context) => SignUpPage(),
    // forgotPassword: (context) => ForgotPasswordPage(),
  };
}
