import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';

class AppThemes {
  static ThemeData lightTheme() {
    final errorInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(
        color: AppColors.red.withValues(alpha: .4),
      ),
    );
    final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0.r),
      borderSide: const BorderSide(
        color: AppColors.primaryColor,
      ),
    );
    final disabledBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0.r),
      borderSide: BorderSide.none,
    );
    return ThemeData(
      // useMaterial3: true,
      fontFamily: 'Kanit',
      scaffoldBackgroundColor: AppColors.white,
      colorScheme: ColorScheme.light(
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
        onErrorContainer: AppColors.red.withValues(alpha: .3),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: AppColors.primaryA29FB3,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        errorStyle: const TextStyle(fontSize: 0, height: -30),
        filled: true,
        fillColor: AppColors.greyFill,
        focusedErrorBorder: errorInputBorder,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        border: focusedBorder,
        enabledBorder: disabledBorder,
        errorBorder: errorInputBorder,
        focusedBorder: focusedBorder,
        disabledBorder: disabledBorder,
        outlineBorder: const BorderSide(color: Colors.red),
      ),
      appBarTheme: const AppBarTheme(
        color: AppColors.white,
        elevation: .2,
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: AppColors.white,
      ),
    );
  }

  static ThemeData darkTheme() {
    final errorInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(
        color: AppColors.red.withValues(alpha: .4),
      ),
    );
    final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0.r),
      borderSide: const BorderSide(
        color: AppColors.primaryColor,
      ),
    );
    final disabledBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0.r),
      borderSide: BorderSide.none,
    );
    return ThemeData(
      //   useMaterial3: true,
      fontFamily: 'Kanit',
      scaffoldBackgroundColor: Colors.black,
      colorScheme: ColorScheme.light(
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
        onErrorContainer: AppColors.red.withValues(alpha: .3),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: AppColors.primaryC4C4C4.withValues(alpha: 0.4),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        errorStyle: const TextStyle(fontSize: 0, height: -30),
        filled: true,
        fillColor: AppColors.greyFill,
        focusedErrorBorder: errorInputBorder,
        // contentPadding:
        //     const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        border: focusedBorder,

        enabledBorder: disabledBorder,
        errorBorder: errorInputBorder,
        focusedBorder: focusedBorder,
        disabledBorder: disabledBorder,
        outlineBorder: const BorderSide(color: Colors.red),
      ),
      appBarTheme: const AppBarTheme(
        color: AppColors.white,
        elevation: .2,
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: AppColors.white,
      ),
    );
  }
}
