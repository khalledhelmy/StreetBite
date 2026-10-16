import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:street_bite/core/theme/app_fonts.dart';

abstract final class AppTextStyles {
  AppTextStyles._();

  // Display
  static TextStyle displayLarge = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 36.sp,
    fontWeight: FontWeight.w700,
    height: 1.h,
    letterSpacing: -0.9.w,
  );

  static TextStyle displayMedium = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 26.sp,
    fontWeight: FontWeight.w700,
    height: 1.375.h,
    letterSpacing: -0.65.w,
  );

  static TextStyle displaySmall = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    height: 1.333.h,
    letterSpacing: -0.6.w,
  );

  // Headlines
  static TextStyle headlineLarge = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    height: 1.333.h,
    letterSpacing: -0.6.w,
  );

  static TextStyle headlineMedium = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    height: 1.4.h,
    letterSpacing: -0.5.w,
  );

  static TextStyle headlineSmall = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
    height: 1.556.h,
    letterSpacing: -0.45.w,
  );

  // Titles
  static TextStyle titleLarge = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
    height: 1.333.h,
  );

  static TextStyle titleMedium = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    height: 1.5.h,
  );

  static TextStyle titleSmall = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    height: 1.429.h,
  );

  // Body
  static TextStyle bodyLarge = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    height: 1.5.h,
  );

  static TextStyle bodyMedium = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 1.429.h,
  );

  static TextStyle bodySmall = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    height: 1.5.h,
  );

  // Labels and buttons
  static TextStyle labelLarge = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    height: 1.429.h,
  );

  static TextStyle labelMedium = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
    height: 1.333.h,
  );

  static TextStyle labelSmall = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 10.sp,
    fontWeight: FontWeight.w700,
    height: 1.5.h,
  );

  // Additional reusable styles

  // Form inputs
  static TextStyle input = bodyLarge;

  static TextStyle inputHint = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    height: 1.429.h,
  );

  static TextStyle caption = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
    height: 1.5.h,
  );

  // Food cards and prices
  static TextStyle cardTitle = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    height: 1.5.h,
  );

  static TextStyle price = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
    height: 1.333.h,
  );

  static TextStyle priceSmall = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    height: 1.429.h,
  );

  static TextStyle badge = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 10.sp,
    fontWeight: FontWeight.w700,
    height: 1.5.h,
  );

  static TextStyle overline = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 10.sp,
    fontWeight: FontWeight.w700,
    height: 1.5.h,
    letterSpacing: 1.w,
  );

  // TextTheme
  static TextTheme textTheme = TextTheme(
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    displaySmall: displaySmall,
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
  );
}
