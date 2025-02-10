import 'package:flutter/material.dart';

// Constants for design dimensions
const double kFigmaDesignWidth = 390;
const double kFigmaDesignHeight = 844;
const double kFigmaDesignStatusBar = 0;

// Enum to represent different device types
enum DeviceType { mobile, tablet, desktop }

// Typedef for responsive build function
typedef ResponsiveBuild = Widget Function(
    BuildContext context,
    Orientation orientation,
    DeviceType deviceType,
    );

// Extension for responsive scaling
extension ResponsiveExtension on num {
  /// Scales width relative to the design width
  double get w => (this * SizeUtils.width) / kFigmaDesignWidth;

  /// Scales height relative to the design height
  double get h => (this * SizeUtils.height) / kFigmaDesignHeight;

  /// Scales font size relative to the design width
  double get fSize => (this * SizeUtils.width) / kFigmaDesignWidth;
}

// Extension for formatting double values
extension FormatExtension on double {
  /// Returns a fixed precision value
  double toFixed(int fractionDigits) => double.parse(toStringAsFixed(fractionDigits));

  /// Returns the value if non-zero, otherwise a default value
  double nonZero({double defaultValue = 0.0}) => this > 0 ? this : defaultValue;

  /// Returns the value as a formatted string
  String toFormattedString({int fractionDigits = 2}) => toStringAsFixed(fractionDigits);
}

// Sizer widget to handle responsive layout
class Sizer extends StatelessWidget {
  const Sizer({super.key, required this.builder});

  /// Builds the widget whenever the orientation or device type changes
  final ResponsiveBuild builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            // Set the screen size and device type based on the constraints and orientation
            SizeUtils.setScreenSize(constraints, orientation, context);

            return builder(
              context,
              orientation,
              SizeUtils.deviceType,
            );
          },
        );
      },
    );
  }
}

// Utility class for handling screen size and device type
class SizeUtils {
  /// Device's BoxConstraints
  static late BoxConstraints boxConstraints;

  /// Device's Orientation
  static late Orientation orientation;

  /// Type of Device (mobile, tablet, or desktop)
  static late DeviceType deviceType;

  /// Device's Width
  static late double width;

  /// Device's Height
  static late double height;

  /// Safe Area Padding (for notches, status bar, etc.)
  static late EdgeInsets safeAreaPadding;

  /// Debug mode flag for printing debug info
  static bool debugMode = false;

  /// Sets the screen size and calculates width, height, and device type
  static void setScreenSize(
      BoxConstraints constraints,
      Orientation currentOrientation,
      BuildContext context,
      ) {
    boxConstraints = constraints;
    orientation = currentOrientation;
    safeAreaPadding = MediaQuery.of(context).padding;

    if (orientation == Orientation.portrait) {
      width = boxConstraints.maxWidth.nonZero(defaultValue: kFigmaDesignWidth);
      height = boxConstraints.maxHeight.nonZero();
    } else {
      width = boxConstraints.maxHeight.nonZero(defaultValue: kFigmaDesignWidth);
      height = boxConstraints.maxWidth.nonZero();
    }

    // Determine the device type based on screen width
    if (width >= 1200) {
      deviceType = DeviceType.desktop;
    } else if (width >= 600) {
      deviceType = DeviceType.tablet;
    } else {
      deviceType = DeviceType.mobile;
    }

    if (debugMode) debugPrintInfo();
  }

  /// Prints debug information about the current screen size
  static void debugPrintInfo() {
    debugPrint("Device Width: $width");
    debugPrint("Device Height: $height");
    debugPrint("Safe Area Padding: $safeAreaPadding");
    debugPrint("Device Type: $deviceType");
    debugPrint("Orientation: $orientation");
  }

  /// Utility for adaptive padding based on device type
  static double adaptivePadding({
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    switch (deviceType) {
      case DeviceType.tablet:
        return tablet;
      case DeviceType.desktop:
        return desktop;
      default:
        return mobile;
    }
  }

  /// Checks if the orientation is portrait
  static bool get isPortrait => orientation == Orientation.portrait;

  /// Checks if the orientation is landscape
  static bool get isLandscape => orientation == Orientation.landscape;
}