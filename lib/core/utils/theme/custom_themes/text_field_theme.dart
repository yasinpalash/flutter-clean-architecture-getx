import 'package:flutter/material.dart';

class AppTextFormFieldTheme {
  AppTextFormFieldTheme._();

  static InputDecorationTheme _baseInputDecorationTheme({
    required Color labelColor,
    required Color hintColor,
    required Color errorColor,
    required Color focusedErrorColor,
    required Color prefixIconColor,
    required Color suffixIconColor,
    required Color borderColor,
    required Color enabledBorderColor,
    required Color focusedBorderColor,
    required Color errorBorderColor,
    required Color focusedErrorBorderColor,
    required BorderRadius borderRadius,
    required EdgeInsetsGeometry contentPadding,
  }) {
    return InputDecorationTheme(
      errorMaxLines: 3,
      prefixIconColor: prefixIconColor,
      suffixIconColor: suffixIconColor,
      labelStyle: TextStyle(fontSize: 14, color: labelColor),
      hintStyle: TextStyle(fontSize: 14, color: hintColor),
      errorStyle: TextStyle(fontSize: 12, color: errorColor),
      floatingLabelStyle: TextStyle(color: labelColor.withOpacity(0.8)),
      border: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: enabledBorderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: focusedBorderColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: errorBorderColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: focusedErrorBorderColor),
      ),
      contentPadding: contentPadding,
    );
  }

  static final InputDecorationTheme lightInputDecorationTheme =
  _baseInputDecorationTheme(
    labelColor: Colors.black,
    hintColor: Colors.black54,
    errorColor: Colors.red,
    focusedErrorColor: Colors.orange,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    borderColor: Colors.grey,
    enabledBorderColor: Colors.grey,
    focusedBorderColor: Colors.black,
    errorBorderColor: Colors.red,
    focusedErrorBorderColor: Colors.orange,
    borderRadius: BorderRadius.circular(14),
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
  );

  static final InputDecorationTheme darkInputDecorationTheme =
  _baseInputDecorationTheme(
    labelColor: Colors.white,
    hintColor: Colors.white70,
    errorColor: Colors.redAccent,
    focusedErrorColor: Colors.orangeAccent,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    borderColor: Colors.grey,
    enabledBorderColor: Colors.grey,
    focusedBorderColor: Colors.white,
    errorBorderColor: Colors.redAccent,
    focusedErrorBorderColor: Colors.orangeAccent,
    borderRadius: BorderRadius.circular(14),
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
  );
}
