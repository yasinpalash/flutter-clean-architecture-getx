import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Core/utils/validators/app_validator.dart';
import '../../controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Welcome Back 👋',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Login to continue',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: controller.usernameController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person_outline),
                        labelText: 'Username',
                        hintText: 'Enter your username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: AppValidator.validateUsername,
                    ),
                    const SizedBox(height: 16),
                    Obx(() => TextFormField(
                          controller: controller.passwordController,
                          obscureText: !controller.isPasswordVisible.value,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_outline),
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.isPasswordVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: controller.togglePasswordVisibility,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: AppValidator.validatePassword,
                        )),
                    const SizedBox(height: 24),
                    Obx(
                      () => SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: controller.isLoading.value
                              ? null
                              : controller.login,
                          child: controller.isLoading.value
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'LOGIN',
                                  style: TextStyle(fontSize: 16),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
