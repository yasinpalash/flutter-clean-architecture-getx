import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project_structure_temp/core/bindings/controller_binder.dart';
import 'package:project_structure_temp/routes/app_routes.dart';
import 'core/utils/theme/theme.dart';

// Utility for Platform Checks
class PlatformUtils {
  static bool get isIOS => foundation.defaultTargetPlatform == TargetPlatform.iOS;
  static bool get isAndroid => foundation.defaultTargetPlatform == TargetPlatform.android;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoute.loginScreen,
        getPages: AppRoute.routes,
        initialBinding: ControllerBinder(),
        themeMode: ThemeMode.system,
        theme: _getLightTheme(),
        darkTheme: _getDarkTheme(),
        defaultTransition: PlatformUtils.isIOS ? Transition.cupertino : Transition.fade,
        locale: Get.deviceLocale,
        builder: (context, child) => PlatformUtils.isIOS 
            ? CupertinoTheme(data: const CupertinoThemeData(), child: child!)
            : child!,
      ),
    );
  }


  ThemeData _getLightTheme() {
    return PlatformUtils.isIOS
        ? AppTheme.lightTheme.copyWith(platform: TargetPlatform.iOS)
        : AppTheme.lightTheme;
  }


  ThemeData _getDarkTheme() {
    return PlatformUtils.isIOS
        ? AppTheme.darkTheme.copyWith(platform: TargetPlatform.iOS)
        : AppTheme.darkTheme;
  }
}
