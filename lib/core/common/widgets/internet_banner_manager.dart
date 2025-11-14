import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_colors.dart';

class InternetBannerManager {
  static void show() {
    if (!Get.isSnackbarOpen) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!Get.isSnackbarOpen) {
          Get.rawSnackbar(
            backgroundColor: Colors.transparent,
            snackStyle: SnackStyle.FLOATING,
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.fromLTRB(6, 0, 6, 65),
            borderRadius: 8,
            padding: EdgeInsets.zero,
            duration: const Duration(days: 365),
            isDismissible: false,
            animationDuration: const Duration(milliseconds: 300),
            messageText: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.primary,
                    blurRadius: 8,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: AppColors.accent),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      "Please check your Internet connection and try again!",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.closeAllSnackbars(),
                    child: const Icon(
                      Icons.close,
                      color: AppColors.black,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      });
    }
  }

  static void hide() {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }
  }
}
