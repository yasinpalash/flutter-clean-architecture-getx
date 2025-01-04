import 'package:flutter/material.dart';
import 'package:project_structure_temp/core/common/styles/get_text_style.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Text("Log in",style: getTextStyle(fontSize: 20),),
      ),
    );
  }
}
