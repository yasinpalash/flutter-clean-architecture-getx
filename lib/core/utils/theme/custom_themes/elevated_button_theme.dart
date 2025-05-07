import 'package:flutter/material.dart';
import 'package:project_structure_temp/core/utils/constants/app_sizer.dart';

class AppElevatedButtonTheme {
  AppElevatedButtonTheme._();

  static ElevatedButtonThemeData _baseTheme({
    required Color defaultTextColor,
    required Color disabledTextColor,
    required Color defaultBackgroundColor,
    required Color disabledBackgroundColor,
    required Color borderColor,
    required EdgeInsetsGeometry padding,
    required BorderRadius borderRadius,
  }) {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: const WidgetStatePropertyAll(0),
        foregroundColor: WidgetStateProperty.resolveWith<Color>(
              (states) => states.contains(WidgetState.disabled) ? disabledTextColor : defaultTextColor,
        ),
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
              (states) => states.contains(WidgetState.disabled) ? disabledBackgroundColor : defaultBackgroundColor,
        ),
        side: WidgetStateProperty.all(BorderSide(color: borderColor)),
        padding: WidgetStatePropertyAll(padding),
        textStyle:  WidgetStatePropertyAll(
          TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: borderRadius),
        ),
      ),
    );
  }

  static final ElevatedButtonThemeData lightElevatedButtonTheme = _baseTheme(
    defaultTextColor: Colors.white,
    disabledTextColor: Colors.grey,
    defaultBackgroundColor: Colors.blue,
    disabledBackgroundColor: Colors.grey.shade300,
    borderColor: Colors.blue,
    padding:  EdgeInsets.symmetric(vertical: 18.h),
    borderRadius: BorderRadius.circular(12.h),
  );

  static final ElevatedButtonThemeData darkElevatedButtonTheme = _baseTheme(
    defaultTextColor: Colors.white,
    disabledTextColor: Colors.grey.shade600,
    defaultBackgroundColor: Colors.blueGrey,
    disabledBackgroundColor: Colors.grey.shade800,
    borderColor: Colors.blueGrey,
    padding:  EdgeInsets.symmetric(vertical: 18.h),
    borderRadius: BorderRadius.circular(12.h),
  );
}
