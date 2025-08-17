import 'package:flutter/material.dart' hide CarouselController;
import '../../core/core_exports.dart';
import "package:flutter/services.dart";

class AppThemeData {
  static final appTheme = ThemeData(
    fontFamily: 'segoe_ui',
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.white,
    brightness: Brightness.light,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.defaultColor),
      bodyMedium: TextStyle(color: AppColors.defaultColor),
      bodySmall: TextStyle(color: AppColors.defaultColor),
      headlineLarge: TextStyle(color: AppColors.defaultColor),
      headlineMedium: TextStyle(color: AppColors.defaultColor),
      headlineSmall: TextStyle(color: AppColors.defaultColor),
    ),
    colorScheme: const ColorScheme.light(
      brightness: Brightness.light,
      primary: AppColors.primaryColor,
      surface: AppColors.white,
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
      actionTextColor: AppColors.primaryColor,
      elevation: 6,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: false,
      labelStyle: const TextStyle(color: AppColors.secondaryColor),
      hintStyle: const TextStyle(
        color: Color.fromRGBO(158, 158, 158, 1),
        fontWeight: FontWeight.w400,
      ),
      contentPadding: const EdgeInsets.all(16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          width: 1,
          color: AppColors.defaultColor100,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.defaultColor100),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.primaryColor),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        elevation: 5,
        shadowColor: AppColors.primaryColor100,
        textStyle: TextStyle(
          fontSize: FontSize.size18,
          fontWeight: FontWeight.w400,
          color: AppColors.white,
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
      indicatorColor: AppColors.white,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(
            color: AppColors.primaryColor,
            size: 30,
          );
        }
        return const IconThemeData(
          color: AppColors.defaultColor,
          size: 25,
        );
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(
            color: AppColors.primaryColor,
            fontSize: 10,
          );
        }
        return const TextStyle(
          color: Colors.black,
          fontSize: 10,
        );
      }),
    ),
  );
}
