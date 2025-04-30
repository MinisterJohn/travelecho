import 'package:flutter/material.dart';

class AppNavigator {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext? get currentContext => navigatorKey.currentContext;

  static void pushNamedAndRemoveUntil(String routeName,
      {bool Function(Route<dynamic>)? predicate}) {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      predicate ?? (route) => false,
    );
  }

  static void pushNamed(String routeName) {
    navigatorKey.currentState?.pushNamed(routeName);
  }

  static void pop() {
    navigatorKey.currentState?.pop();
  }

  static void popUntil(String routeName) {
    navigatorKey.currentState
        ?.popUntil((route) => route.settings.name == routeName);
  }
}
