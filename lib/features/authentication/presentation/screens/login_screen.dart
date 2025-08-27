import 'package:flutter/material.dart';
import 'package:project_structure_temp/core/constants/app_sizer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigoAccent, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Logo
                Image.network(
                  'https://images.unsplash.com/photo-1498629718354-908b63db7fb1?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', // Replace with your app logo URL
                  height: 80.h,
                ),
                SizedBox(height: 10.h),
                // Welcome Header
                Text(
                  "Welcome to Eventify!",
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "Plan your events effortlessly. Sign up to get started!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 30.h),
                // Form Card
                Container(
                  padding: EdgeInsets.all(20.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.h),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.h,
                        offset: Offset(0, 5.h),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Name Input
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Full Name",
                          labelStyle: TextStyle(fontSize: 14.sp),
                          prefixIcon: Icon(Icons.person, size: 24.h),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.h),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      // Email Input
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Email Address",
                          labelStyle: TextStyle(fontSize: 14.sp),
                          prefixIcon: Icon(Icons.email, size: 24.h),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.h),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      // Password Input
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(fontSize: 14.sp),
                          prefixIcon: Icon(Icons.lock, size: 24.h),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.h),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      // Password Tips
                      Text(
                        "Password must be at least 8 characters, including a number and a symbol.",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      // Sign Up Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blueAccent,
                          minimumSize: Size(double.infinity, 50.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.h),
                          ),
                        ),
                        onPressed: () {
                          // Sign-up logic
                        },
                        child: Text("Sign Up", style: TextStyle(fontSize: 16.sp)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                // Social Sign-up Buttons
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.grey[800],
                    backgroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50.h),
                    side: BorderSide(color: Colors.grey[300]!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.h),
                    ),
                  ),
                  icon: Image.network(
                    'https://images.unsplash.com/photo-1498629718354-908b63db7fb1?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', // Replace with Google icon URL
                    height: 24.h,
                  ),
                  label: Text("Sign up with Google", style: TextStyle(fontSize: 14.sp)),
                  onPressed: () {
                    // Google Sign-up logic
                  },
                ),
                SizedBox(height: 15.h),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    minimumSize: Size(double.infinity, 50.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.h),
                    ),
                  ),
                  icon: Icon(Icons.apple, size: 24.h),
                  label: Text("Sign up with Apple", style: TextStyle(fontSize: 14.sp)),
                  onPressed: () {
                    // Apple Sign-up logic
                  },
                ),
                SizedBox(height: 15.h),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF4267B2),
                    minimumSize: Size(double.infinity, 50.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.h),
                    ),
                  ),
                  icon: Icon(Icons.facebook, size: 24.h),
                  label: Text("Sign up with Facebook", style: TextStyle(fontSize: 14.sp)),
                  onPressed: () {
                    // Facebook Sign-up logic
                  },
                ),
                SizedBox(height: 30.h),
                // Already Have an Account
                FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to Login Screen
                        },
                        child: Text(
                          "Log in",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Footer Links
                GestureDetector(
                  onTap: () {
                    // Navigate to Terms of Service
                  },
                  child: Text(
                    "Terms of Service & Privacy Policy",
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
