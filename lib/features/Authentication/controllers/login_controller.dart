import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:network_caller/Core/utils/logging/logger.dart';
import 'package:network_caller/Features/Authentication/data/models/login_request_body.dart';
import 'package:network_caller/Features/Courses/presentation/screens/course_screen.dart';
import '../../../Core/models/response_data.dart';
import '../../../Core/network/result.dart';
import '../../../Core/network/server_exception.dart';
import '../domain/repositories/login_repository.dart';

class LoginController extends GetxController {
  final LoginRepository _loginRepository;
  LoginController(this._loginRepository);

  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController(text: "emilys");
  final passwordController = TextEditingController(text: "emilyspass");

  final isLoading = false.obs;
  final isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }


  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    isLoading.value = true;

    try {
      final result = await _loginRepository.login(
        SignInRequest(username: username, password: password),
      );

      switch (result) {
        case Ok<ResponseData>():
          final response = result.value;
          final raw = response.rawBody;
          final accessToken = raw['accessToken'];
          AppLoggerHelper.info("Login Success | Access Token: $accessToken");

          Get.to(()=> CourseScreen());

          break;

        case Error<ResponseData>():
          final error = result.error;
          if (error is ServerException) {
            AppLoggerHelper.error("❌ Server Error: ${error.message}");
          }
      }
    } catch (e) {
      AppLoggerHelper.error("Unexpected Error: $e");
      Get.snackbar(
        "Error",
        "Something went wrong. Please try again later.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
