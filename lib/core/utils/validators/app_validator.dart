class AppValidator {
  AppValidator._();

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }
    final emailRegExp = RegExp(r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address.';
    }
    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Username is required';
    }
    if (value.length < 3) {
      return 'Username must be at least 3 characters';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required.';
    }
    final phoneRegExp = RegExp(r'^\d{10}$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number format (10 digits required).';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required.';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters long.';
    }
    return null;
  }

  static String? validateConfirmPassword(
      String? value, String? originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password.';
    }
    if (value != originalPassword) {
      return 'Passwords do not match.';
    }
    return null;
  }

  static String? validateNotEmpty(String? value,
      [String fieldName = 'This field']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required.';
    }
    return null;
  }

  static String? validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Address is required.';
    }
    if (value.length < 10) {
      return 'Address must be at least 10 characters.';
    }
    return null;
  }

  static String? validateZipCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'ZIP Code is required.';
    }
    final zipRegExp = RegExp(r'^\d{4,6}$');
    if (!zipRegExp.hasMatch(value)) {
      return 'Invalid ZIP Code format.';
    }
    return null;
  }
}
