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
      iconTheme: const IconThemeData(
        color: AppColors.primary5E5E5E,
      ),
      unselectedWidgetColor: AppColors.primaryC4C4C4,
      dialogBackgroundColor: AppColors.primaryEFEFEF,
      canvasColor: AppColors.white,
      cardColor: AppColors.primaryEFEFEF,
      scaffoldBackgroundColor: AppColors.white,
      colorScheme: ColorScheme.light(
        onSurface: AppColors.primary5E5E5E,
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
        onPrimaryContainer: AppColors.primaryEFEFEF,
        tertiary: AppColors.primary1E1E1E,
        onErrorContainer: AppColors.red.withValues(alpha: .3),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          // color: AppColors.primaryA29FB3,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        errorStyle: const TextStyle(fontSize: 0, height: -30),
        filled: true,
        isDense: false,
        fillColor: AppColors.greyFill,
        focusedErrorBorder: errorInputBorder,
        //  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        border: focusedBorder,
        enabledBorder: disabledBorder,
        errorBorder: errorInputBorder,
        focusedBorder: focusedBorder,
        disabledBorder: disabledBorder,
        outlineBorder: const BorderSide(color: Colors.red),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
        elevation: .2,
        foregroundColor: AppColors.white,
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
      iconTheme: const IconThemeData(
        color: AppColors.white,
      ),
      unselectedWidgetColor: AppColors.primary505050,
      dialogBackgroundColor: AppColors.primary101010,
      canvasColor: AppColors.black,
      scaffoldBackgroundColor: Colors.black,
      cardColor: AppColors.primary101010,
      colorScheme: ColorScheme.light(
        primary: AppColors.primaryColor,
        tertiary: AppColors.primaryC4C4C4,
        onSurface: AppColors.primaryC4C4C4,
        secondary: AppColors.secondaryColor,
        onPrimaryContainer: AppColors.primary101010,
        onErrorContainer: AppColors.red.withValues(alpha: .3),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(
          //  color: AppColors.primaryC4C4C4.withValues(alpha: 0.4),
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
        backgroundColor: AppColors.black,
        elevation: .2,
        foregroundColor: AppColors.white,
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: AppColors.white,
      ),
    );
  }
}
