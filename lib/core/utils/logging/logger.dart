import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLoggerHelper {
  AppLoggerHelper._();
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: true,
    ),
    level: kReleaseMode ? Level.off : Level.debug,
  );

  static void debug(String message) {
    if (!kReleaseMode) _logger.d(message);
  }

  static void info(String message) {
    if (!kReleaseMode) _logger.i(message);
  }

  static void warning(String message) {
    if (!kReleaseMode) _logger.w(message);
  }

  static void error(String message, [dynamic error]) {
    if (!kReleaseMode) {
      _logger.e(message, error: error, stackTrace: StackTrace.current);
    }
  }
}
