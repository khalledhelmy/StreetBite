import 'package:flutter/material.dart';

abstract final class AppColors {
  AppColors._();

  // Brand colors (shared)
  static const Color primary = Color(0xFFFF6800);
  static const Color primaryDark = Color(0xFFE65100);
  static const Color primaryLight = Color(0xFFFF7A00);
  static const Color primarySoft = Color(0xFFFFA040);

  // Common colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color success = Color(0xFF10B954);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF1877F2);
  static const Color rating = Color(0xFFFFB800);

  // Light theme
  static const Color primaryBackground = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color fieldBackground = Color(0xFFF7F8F9);

  static const Color textPrimary = Color(0xFF1D2129);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color placeholder = Color(0xFF9CA3AF);
  static const Color textDisabled = Color(0xFFD1D5DB);

  static const Color border = Color(0xFFE5E7EB);
  static const Color borderStrong = Color(0xFFD1D5DB);
  static const Color divider = Color(0xFFE5E5E5);

  static const Color primaryContainer = Color(0xFFFFEDD5);
  static const Color successBackground = Color(0xFFECFDF5);
  static const Color warningBackground = Color(0xFFFEF3C7);
  static const Color errorBackground = Color(0xFFFEF2F2);
  static const Color infoBackground = Color(0xFFEFF6FF);

  // Dark theme
  static const Color darkPrimaryBackground = Color(0xFF111827);
  static const Color darkSurface = Color(0xFF1F2937);
  static const Color darkFieldBackground = Color(0xFF1F2937);

  static const Color darkTextPrimary = Color(0xFFF9FAFB);
  static const Color darkTextSecondary = Color(0xFFD1D5DB);
  static const Color darkPlaceholder = Color(0xFF9CA3AF);
  static const Color darkTextDisabled = Color(0xFF6B7280);

  static const Color darkBorder = Color(0xFF374151);
  static const Color darkBorderStrong = Color(0xFF4B5563);
  static const Color darkDivider = Color(0xFF374151);

  static const Color darkPrimaryContainer = Color(0xFF4A2614);
  static const Color darkSuccessBackground = Color(0xFF123A2A);
  static const Color darkWarningBackground = Color(0xFF422F0D);
  static const Color darkErrorBackground = Color(0xFF451D24);
  static const Color darkInfoBackground = Color(0xFF172D4D);

  // Light ColorScheme
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: white,
    primaryContainer: primaryContainer,
    secondary: primaryDark,
    onSecondary: white,
    tertiary: info,
    onTertiary: white,
    error: error,
    onError: white,
    errorContainer: errorBackground,
    surface: surface,
    onSurface: textPrimary,
    onSurfaceVariant: textSecondary,
    outline: borderStrong,
    outlineVariant: border,
    shadow: black,
    scrim: black,
    onInverseSurface: white,
  );

  // Dark ColorScheme
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: primary,
    onPrimary: white,
    primaryContainer: darkPrimaryContainer,
    onPrimaryContainer: Color(0xFFFFDCC5),
    secondary: primaryLight,
    onSecondary: Color(0xFF1E1917),
    secondaryContainer: Color(0xFF4A2614),
    onSecondaryContainer: Color(0xFFFFDCC5),
    tertiary: Color(0xFF93C5FD),

    error: error,
    onError: white,
    errorContainer: darkErrorBackground,
    surface: darkSurface,
    onSurface: darkTextPrimary,
    onSurfaceVariant: darkTextSecondary,
    outline: darkBorderStrong,
    outlineVariant: darkBorder,
    shadow: black,
    scrim: black,

    inversePrimary: primaryDark,
  );
}
