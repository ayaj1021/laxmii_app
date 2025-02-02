import 'package:flutter/material.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';

class DateRangePickerTheme {
  static datePickerTheme(
      {required BuildContext context, required Widget child}) {
    return Theme(
      data: Theme.of(context).copyWith(
        unselectedWidgetColor: Colors.white,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaryColor,
          onPrimary: Colors.white, // Text color on primary elements
          surface: AppColors.white, // Background color
          onSurface: Colors.white, // Text color on surface elements
          secondary: AppColors.primaryColor,
          onSecondary: Colors.white, // Text color on secondary elements
        ),
        dialogBackgroundColor: AppColors.white,
        scaffoldBackgroundColor: AppColors.primary101010,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white, // Button text color
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white), // General text color
          bodyMedium: TextStyle(color: Colors.white), // General text color
        ),
      ),
      child: child,
    );
  }
}
