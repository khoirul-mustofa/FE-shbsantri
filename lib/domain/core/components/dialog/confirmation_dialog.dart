import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:santrihub/infrastructure/theme/font/fonts.dart';
import 'package:santrihub/infrastructure/theme/style/style.dart';

import '../../../../infrastructure/theme/color/colors.dart';
import '../../../../infrastructure/theme/screen/screen_size.dart';
import '../../../../infrastructure/theme/theme.dart';
import '../button/primary_button.dart';

class ConfirmationDialog {
  static void show(
      {required String title,
      required String message,
      String? onTapText,
      bool? isCenterMessage,
      Function()? onPressed}) {
    Get.dialog(Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: getWidthScale(4)),
      child: Container(
        padding: theme.style.padding.allLarge,
        decoration: BoxDecoration(
          borderRadius: theme.style.borderRadius.allMedium,
          color: kWhiteColor,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: getWidthScale(2),
              minHeight: 100.w,
              maxWidth: getWidthScale(4)),
          child: SingleChildScrollView(
            child: Material(
              color: Colors.transparent,
              child: Column(
                children: [
                  Text(
                    title,
                    style: theme.font.f14.semibold,
                  ),
                  Gap(6.h),
                  Text(
                    message,
                    style: theme.font.f14,
                    textAlign: isCenterMessage == true
                        ? TextAlign.center
                        : TextAlign.left,
                  ),
                  Gap(26.h),
                  SizedBox(
                    width: getWidthScale(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: PrimaryButton(
                                isDelete: true,
                                isExpanded: true,
                                text: "Batal",
                                onPressed: () => Get.back())),
                        Gap(22.w),
                        Expanded(
                            child: PrimaryButton(
                                isExpanded: true,
                                text: "Ya, $onTapText",
                                onPressed: onPressed)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
