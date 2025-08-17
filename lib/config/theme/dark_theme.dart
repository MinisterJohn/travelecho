import 'package:flutter/material.dart' hide CarouselController;
import '../../core/core_exports.dart';
import "package:flutter/services.dart";

class DarkThemeData {
  static final darkTheme = ThemeData(
    fontFamily: 'segoe_ui',
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: Colors.black,
    brightness: Brightness.dark,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.white),
      headlineLarge: TextStyle(color: Colors.white),
      headlineMedium: TextStyle(color: Colors.white),
      headlineSmall: TextStyle(color: Colors.white),
    ),
    colorScheme: const ColorScheme.dark(
      brightness: Brightness.dark,
      primary: AppColors.primaryColor,
      surface: Colors.black,
      error: Colors.red,
      onError: Colors.white,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: AppColors.primaryColor),
      ),
      contentTextStyle: const TextStyle(
        color: AppColors.primaryColor,
        overflow: TextOverflow.ellipsis,
      ),
      behavior: SnackBarBehavior.floating,
      actionTextColor: AppColors.primaryColor,
      elevation: 6,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: false,
      labelStyle: const TextStyle(color: AppColors.secondaryColor),
      hintStyle: const TextStyle(
        color: Colors.white70,
        fontWeight: FontWeight.w400,
      ),
      contentPadding: const EdgeInsets.all(16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(width: 1, color: Colors.white24),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white24),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.primaryColor),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        elevation: 5,
        shadowColor: AppColors.primaryColor100,
        textStyle: TextStyle(
          fontSize: FontSize.size18,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
        textStyle: TextStyle(
          fontSize: FontSize.size18,
          fontWeight: FontWeight.w400,
          color: AppColors.primaryColor,
        ),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
        textStyle: TextStyle(
          fontSize: FontSize.size18,
          fontWeight: FontWeight.w400,
          color: AppColors.primaryColor,
        ),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        side: const BorderSide(color: AppColors.primaryColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: FontSize.size18,
        fontWeight: FontWeight.w600,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: Colors.black,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: AppColors.primaryColor, size: 30);
        }
        return const IconThemeData(color: Colors.white, size: 25);
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(color: AppColors.primaryColor, fontSize: 10);
        }
        return const TextStyle(color: Colors.white, fontSize: 10);
      }),
    ),
  );
}
