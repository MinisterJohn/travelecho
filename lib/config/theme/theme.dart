import 'package:flutter/material.dart' hide CarouselController;
import 'colors.dart';
import '../../core/core_exports.dart';
import "package:flutter/services.dart";

class AppTheme {
  static final appTheme = ThemeData(
    // useMaterial3: true,
    fontFamily: 'Segoe UI',
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.white,
    brightness: Brightness.light,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.defaultColor), // Default large body
      bodyMedium:
          TextStyle(color: AppColors.defaultColor), // Default medium body
      bodySmall: TextStyle(color: AppColors.defaultColor), // Default small body
      headlineLarge: TextStyle(color: AppColors.defaultColor),
      headlineMedium: TextStyle(color: AppColors.defaultColor),
      headlineSmall: TextStyle(color: AppColors.defaultColor),
      // labelLarge: TextStyle(color: AppColors.defaultColor),
      // labelMedium: TextStyle(color: AppColors.defaultColor),
      // labelSmall: TextStyle(color: AppColors.defaultColor),
    ),
    colorScheme: const ColorScheme.light(
      brightness: Brightness.light,
      primary: AppColors.primaryColor,
      // onPrimary: AppColors.defaultColor,
      // secondary: AppColors.defaultColor,
      // onSecondary: AppColors.defaultColor,
      surface: AppColors.white,
      // surface: AppColors.defaultColor,
      // onSurface: AppColors.defaultColor,
      error: Colors.red,
      onError: AppColors.defaultColor,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: AppColors.primaryColor),
      ),
      contentTextStyle: const TextStyle(
        color: AppColors.primaryColor,
        overflow: TextOverflow.ellipsis,
      ),
      behavior: SnackBarBehavior.floating,
      // width: 400,
      actionTextColor: AppColors.primaryColor,
      elevation: 6,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: false,
      // fillColor: AppColors.defaultColor,
      labelStyle: const TextStyle(
        color: AppColors.secondaryColor,
      ),
      hintStyle: const TextStyle(
        color: Color.fromRGBO(158, 158, 158, 1),
        fontWeight: FontWeight.w400,
      ),
      contentPadding: const EdgeInsets.all(16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(width: 1, color: AppColors.secondaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.secondaryColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.primaryColor),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white, // ✅ Needed for button text
        elevation: 5,
        shadowColor: AppColors.primaryColor100,
        textStyle: TextStyle(
          fontSize: FontSize.size18,
          fontWeight: FontWeight.w400,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryColor, // ✅ Added
        textStyle: TextStyle(
          fontSize: FontSize.size18,
          fontWeight: FontWeight.w400,
        ),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryColor, // ✅ Added
        textStyle: TextStyle(
          fontSize: FontSize.size18,
          fontWeight: FontWeight.w400,
        ),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        side: const BorderSide(color: AppColors.primaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      iconTheme: const IconThemeData(color: AppColors.white),
      titleTextStyle: TextStyle(
        color: AppColors.defaultColor,
        fontSize: FontSize.size18,
        fontWeight: FontWeight.w600,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: AppColors.white, // Remove the background
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(
              color: AppColors.primaryColor, size: 30); // Active icon color
        }
        return const IconThemeData(
            color: AppColors.defaultColor, size: 25); // Inactive icon color
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(
              color: AppColors.primaryColor,
              fontSize: 10); // Active label style
        }
        return const TextStyle(
            color: Colors.black, fontSize: 10); // Inactive label style
      }),
    ),
  );
}
