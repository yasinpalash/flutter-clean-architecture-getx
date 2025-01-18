import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_structure_temp/core/common/styles/get_text_style.dart';

class AppBarThemeData {
  AppBarThemeData._();

  static  AppBarTheme lightAppBarTheme = AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.black),
    titleTextStyle: getTextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    actionsIconTheme: const IconThemeData(color: Colors.black),
    centerTitle: true,
    // systemOverlayStyle: SystemUiOverlayStyle.light,
  );

  static final AppBarTheme darkAppBarTheme = AppBarTheme(
    foregroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    backgroundColor: Colors.grey[900],
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle:  getTextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    actionsIconTheme: const IconThemeData(color: Colors.white),
    centerTitle: true,
    // systemOverlayStyle: SystemUiOverlayStyle.light,
  );
}
