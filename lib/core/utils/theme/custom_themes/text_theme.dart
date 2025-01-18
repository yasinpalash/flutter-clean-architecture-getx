import 'package:flutter/material.dart';
import 'package:project_structure_temp/core/common/styles/get_text_style.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    displayLarge: getTextStyle(
      fontSize: 57.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    displayMedium: getTextStyle(
      fontSize: 45.0,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    ),
    displaySmall: getTextStyle(
      fontSize: 36.0,
      fontWeight: FontWeight.w500,
      color: Colors.black87,
    ),
    headlineLarge: getTextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headlineMedium: getTextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    ),
    headlineSmall: getTextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w500,
      color: Colors.black87,
    ),
    titleLarge: getTextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    ),
    titleMedium: getTextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: Colors.black87,
    ),
    titleSmall: getTextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: Colors.black87,
    ),
    bodyLarge: getTextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: Colors.black87,
    ),
    bodyMedium: getTextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: Colors.black87,
    ),
    bodySmall: getTextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: Colors.black54,
    ),
    labelLarge: getTextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    labelMedium: getTextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      color: Colors.black54,
    ),
    labelSmall: getTextStyle(
      fontSize: 11.0,
      fontWeight: FontWeight.w500,
      color: Colors.black45,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    displayLarge: getTextStyle(
      fontSize: 57.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    displayMedium: getTextStyle(
      fontSize: 45.0,
      fontWeight: FontWeight.w600,
      color: Colors.white70,
    ),
    displaySmall: getTextStyle(
      fontSize: 36.0,
      fontWeight: FontWeight.w500,
      color: Colors.white70,
    ),
    headlineLarge: getTextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headlineMedium: getTextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.w600,
      color: Colors.white70,
    ),
    headlineSmall: getTextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w500,
      color: Colors.white70,
    ),
    titleLarge: getTextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w600,
      color: Colors.white70,
    ),
    titleMedium: getTextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: Colors.white70,
    ),
    titleSmall: getTextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: Colors.white70,
    ),
    bodyLarge: getTextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: Colors.white70,
    ),
    bodyMedium: getTextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: Colors.white60,
    ),
    bodySmall: getTextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: Colors.white54,
    ),
    labelLarge: getTextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    labelMedium: getTextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      color: Colors.white60,
    ),
    labelSmall: getTextStyle(
      fontSize: 11.0,
      fontWeight: FontWeight.w500,
      color: Colors.white54,
    ),
  );
}
