import 'package:flutter/material.dart';

class AppBarThemeData {
  AppBarThemeData._();

  static  AppBarTheme lightAppBarTheme = const AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    actionsIconTheme: IconThemeData(color: Colors.black),
    centerTitle: true,
    // systemOverlayStyle: SystemUiOverlayStyle.light,
  );

  static final AppBarTheme darkAppBarTheme = AppBarTheme(
    foregroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    backgroundColor: Colors.grey[900],
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle:  const TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    actionsIconTheme: const IconThemeData(color: Colors.white),
    centerTitle: true,
    // systemOverlayStyle: SystemUiOverlayStyle.light,
  );
}
