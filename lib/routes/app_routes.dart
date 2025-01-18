import 'package:get/get.dart';
import 'package:project_structure_temp/features/authentication/presentation/screens/login_screen.dart';
import 'package:project_structure_temp/features/splash_screen/presentation/screens/splash_screen.dart';

class AppRoute {
  static String loginScreen = "/loginScreen";
  static String init = "/";


  static List<GetPage> routes = [
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: init, page: () => const SplashScreen()),
  ];
}