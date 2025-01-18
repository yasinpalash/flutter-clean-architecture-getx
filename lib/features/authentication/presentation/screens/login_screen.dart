import 'package:flutter/material.dart';
import 'package:project_structure_temp/core/common/styles/get_text_style.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width, // Full width of the screen
        height: MediaQuery.of(context).size.height, // Full height of the screen
        color: Colors.green, // Optional background color
        child: Center(
          child: Text(
            "Log in",
            style: getTextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
