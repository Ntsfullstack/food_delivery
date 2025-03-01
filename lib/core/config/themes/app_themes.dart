import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppThemes {
  static final TextTheme _textTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 32.sp,
      fontWeight: FontWeight.bold,
      fontFamily: 'Readex',
    ),
    displayMedium: TextStyle(
      fontSize: 28.sp,
      fontWeight: FontWeight.w600,
      fontFamily: 'Readex',
    ),
    displaySmall: TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w600,
      fontFamily: 'Readex',
    ),
    headlineMedium: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w500,
      fontFamily: 'Readex',
    ),
    bodyLarge: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.normal,
      fontFamily: 'Readex',
    ),
    bodyMedium: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.normal,
      fontFamily: 'Readex',
    ),
    bodySmall: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.normal,
      fontFamily: 'Readex',
    ),
  );

  static final lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    brightness: Brightness.light,
    fontFamily: 'Readex',
    scaffoldBackgroundColor: AppColors.lightColor,
    textTheme: _textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lightColor,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColors.primary),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        fontFamily: 'Readex',
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          fontFamily: 'Readex',
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[100],
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(
        fontSize: 14.sp,
        fontFamily: 'Readex',
        color: Colors.grey,
      ),
    ),
  );

  static final darkTheme = ThemeData(
    primaryColor: AppColors.primary,
    brightness: Brightness.dark,
    fontFamily: 'Readex',
    scaffoldBackgroundColor: AppColors.darkColor,
    textTheme: _textTheme.apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkColor,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColors.primary),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        fontFamily: 'Readex',
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          fontFamily: 'Readex',
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[900],
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(
        fontSize: 14.sp,
        fontFamily: 'Readex',
        color: Colors.grey,
      ),
    ),
  );
}