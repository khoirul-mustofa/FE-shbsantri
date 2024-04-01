import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:santrihub/infrastructure/theme/font/fonts.dart';
import 'package:santrihub/infrastructure/theme/screen/screen_size.dart';
import 'package:santrihub/infrastructure/theme/style/style.dart';
import 'package:santrihub/presentation/admin/dashboard/controllers/dashboard.controller.dart';

import '../../../../infrastructure/theme/color/colors.dart';
import '../../../../infrastructure/theme/theme.dart';

class ListCategory extends StatelessWidget {
  const ListCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (controller) {
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: getWidthScale(3)),
        child: Container(
          padding: theme.style.padding.allLarge,
          decoration: BoxDecoration(
            borderRadius: theme.style.borderRadius.allMedium,
            color: kWhiteColor,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: getWidthScale(1.8),
                minHeight: 100.w,
                maxWidth: getWidthScale(3)),
            child: SingleChildScrollView(
              child: Material(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Text('Daftar Kategori', style: theme.font.f18.semibold),
                    Gap(16.h),
                    const Divider(
                      height: 0,
                      color: kBorder,
                    ),
                    Gap(12.h),
                    Column(
                        children: List.generate(
                            controller.categories.length,
                            (index) => SizedBox(
                                  height: 52.h,
                                  width: getWidthScale(3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "${index + 1} . ${controller.categories[index].name}",
                                          style: theme.font.f16),
                                      GestureDetector(
                                        onTap: () => controller.deleteCategory(
                                            context,
                                            controller.categories[index].id ??
                                                0),
                                        child: const Icon(
                                          Icons.delete,
                                          color: kErrorColor,
                                        ),
                                      )
                                    ],
                                  ),
                                )))
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
