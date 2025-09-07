import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const _keyAccessToken = 'accessToken';
  static const _keyAccessTokenExpiry = 'accessTokenExpiry';
  static const _keyRefreshToken = 'refreshToken';
  static const _keyRefreshTokenExpiry = 'refreshTokenExpiry';

  static late SharedPreferences _preferences;

  static String? _accessToken;
  static DateTime? _accessTokenExpiry;
  static String? _refreshToken;
  static DateTime? _refreshTokenExpiry;

  // Token refresh callback for UI updates
  static Function()? onTokenRefreshed;
  static Function()? onTokenExpired;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    await _loadTokensFromStorage();
  }

  static Future<void> _loadTokensFromStorage() async {
    try {
      _accessToken = _preferences.getString(_keyAccessToken);
      _accessTokenExpiry = DateTime.tryParse(
        _preferences.getString(_keyAccessTokenExpiry) ?? '',
      );
      _refreshToken = _preferences.getString(_keyRefreshToken);
      _refreshTokenExpiry = DateTime.tryParse(
        _preferences.getString(_keyRefreshTokenExpiry) ?? '',
      );

      log('Tokens loaded from storage');
    } catch (e) {
      log('Error loading tokens: $e');
    }
  }

  static bool hasAccessToken() =>
      _accessToken != null && _accessToken!.isNotEmpty;

  static bool hasValidTokens() {
    return hasAccessToken() && !isAccessTokenExpired();
  }

  static Future<void> saveTokens({
    required String accessToken,
    required DateTime accessTokenExpiry,
    required String refreshToken,
    required DateTime refreshTokenExpiry,
  }) async {
    try {
      await Future.wait([
        _preferences.setString(_keyAccessToken, accessToken),
        _preferences.setString(
          _keyAccessTokenExpiry,
          accessTokenExpiry.toIso8601String(),
        ),
        _preferences.setString(_keyRefreshToken, refreshToken),
        _preferences.setString(
          _keyRefreshTokenExpiry,
          refreshTokenExpiry.toIso8601String(),
        ),
      ]);

      _accessToken = accessToken;
      _accessTokenExpiry = accessTokenExpiry;
      _refreshToken = refreshToken;
      _refreshTokenExpiry = refreshTokenExpiry;

      log('Tokens saved successfully');
      onTokenRefreshed?.call();
    } catch (e) {
      log('Error saving tokens: $e');
    }
  }

  static bool isAccessTokenExpired() {
    if (_accessTokenExpiry == null) return true;
    final bufferTime = DateTime.now().add(const Duration(seconds: 30));
    return bufferTime.isAfter(_accessTokenExpiry!);
  }

  static bool isRefreshTokenExpired() {
    if (_refreshTokenExpiry == null) return true;
    return DateTime.now().isAfter(_refreshTokenExpiry!);
  }

  static Duration? getTokenTimeRemaining() {
    if (_accessTokenExpiry == null) return null;
    final remaining = _accessTokenExpiry!.difference(DateTime.now());
    return remaining.isNegative ? Duration.zero : remaining;
  }

  static Future<void> logoutUser() async {
    try {
      await _preferences.clear();
      _accessToken = null;
      _accessTokenExpiry = null;
      _refreshToken = null;
      _refreshTokenExpiry = null;
      onTokenExpired?.call();
      await goToLogin();
      log('User logged out successfully');
    } catch (e) {
      log('Error during logout: $e');
    }
  }

  static Future<void> goToLogin() async {
   // Get.offAllNamed(AppRoute.loginScreen);
  }

  static String? get accessToken => _accessToken;
  static DateTime? get accessTokenExpiry => _accessTokenExpiry;
  static String? get refreshToken => _refreshToken;
  static DateTime? get refreshTokenExpiry => _refreshTokenExpiry;

  // Helper methods
  static String get authHeader => 'Bearer $_accessToken';

  static Map<String, String> get authHeaders => {'Authorization': authHeader};

  static bool get isLoggedIn => hasValidTokens();
}
