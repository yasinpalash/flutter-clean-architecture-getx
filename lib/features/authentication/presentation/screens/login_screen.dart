import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_structure_temp/routes/app_routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width, // Full width of the screen
        height: MediaQuery.of(context).size.height, // Full height of the screen
        color: Colors.green, // Optional background color
        child: Column(
          children: [
            const Center(
              child: Text(
                "this is my book ",
                style: TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(AppRoute.signUpScreen);
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
