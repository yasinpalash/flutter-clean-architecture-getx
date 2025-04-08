

import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _tokenKey = 'token';

  static late SharedPreferences _preferences;

  static String? _token;

  // Initialize SharedPreferences (call this during app startup)
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    // Load token and userId from SharedPreferences into private variables
    _token = _preferences.getString(_tokenKey);
  }

  // Check if a token exists in local storage
  static bool hasToken() {
    return _preferences.containsKey(_tokenKey);
  }

  // Save the token and user ID to local storage
  static Future<void> saveToken(String token, String id) async {
    try {
      await _preferences.setString(_tokenKey, token);
      // Update private variables
      _token = token;
    } catch (e) {
      log('Error saving token: $e');
    }
  }


  static Future<void> logoutUser() async {
    try {
      await _preferences.clear();
      _token = null;
      await goToLogin();
    } catch (e) {
      log('Error during logout: $e');
    }
  }

  static Future<void> goToLogin() async {
    // Get.offAllNamed('/login');
  }

  // Getter for token
  static String? get token => _token;
}
