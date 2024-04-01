import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:santrihub/infrastructure/theme/font/fonts.dart';
import 'package:santrihub/infrastructure/theme/style/style.dart';

import '../../../../infrastructure/theme/color/colors.dart';
import '../../../../infrastructure/theme/theme.dart';

enum SnackType { success, error, dark }

class AppSnackbar {
  static void show(
      {String? message,
      SnackType type = SnackType.success,
      bool onTop = false}) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: type == SnackType.success
          ? kSuccessColor
          : type == SnackType.dark
              ? kBlackColor.withOpacity(0.8)
              : kErrorColor,
      messageText: Text(
        message == null || message == "" ? "Error not define" : message,
        style: theme.font.f12.regular.white,
      ),
      duration: 2.seconds,
      icon: type == SnackType.dark
          ? const SizedBox.shrink()
          : Icon(
              type == SnackType.success
                  ? Icons.check_circle_rounded
                  : Icons.close,
              color: Colors.white,
              size: 18.r,
            ),
      padding: type == SnackType.dark
          ? theme.style.padding.allSmall
          : theme.style.padding.allLarge,
      margin: type == SnackType.dark
          ? EdgeInsets.symmetric(vertical: 82.h, horizontal: 16.w)
          : EdgeInsets.all(16.r),
      borderRadius: 8.r,
      snackPosition: onTop ? SnackPosition.TOP : SnackPosition.BOTTOM,
    ));
  }
}
