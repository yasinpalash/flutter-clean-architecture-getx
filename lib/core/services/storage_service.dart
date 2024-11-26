import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  // Constants for preference keys
  static const String _tokenKey = 'token';
  static const String _idKey = 'userId';

  // Singleton instance for SharedPreferences
  static late SharedPreferences _preferences;

  // Initialize SharedPreferences (call this during app startup)
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Check if a token exists in local storage
  static bool hasToken() {
    return _preferences.containsKey(_tokenKey);
  }

  // Save the token and user ID to local storage
  static Future<void> saveToken(String token, String id) async {
    try {
      await _preferences.setString(_tokenKey, token);
      await _preferences.setString(_idKey, id);
    } catch (e) {
      print('Error saving token: $e');
    }
  }

  // Clear authentication data (for logout or clearing auth data)
  static Future<void> logoutUser() async {
    try {
      await _preferences.remove(_tokenKey);
      await _preferences.remove(_idKey);
    } catch (e) {
      print('Error during logout: $e');
    }
  }

  // Clear all preferences (useful for full app reset or logout)
  static Future<void> clearAllData() async {
    try {
      await _preferences.clear();
    } catch (e) {
      print('Error clearing all data: $e');
    }
  }

  // Navigate to the login screen (e.g., after logout or token expiry)
  static Future<void> goToLogin() async {
    // Uncomment this line when integrating with your app navigation
    // Get.offAllNamed('/login');
  }

  // Getter for user ID
  static String? get userId => _preferences.getString(_idKey);

  // Getter for token
  static String? get token => _preferences.getString(_tokenKey);
}
