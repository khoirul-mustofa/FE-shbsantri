import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:santrihub/domain/core/components/button/primary_button.dart';
import 'package:santrihub/domain/core/components/form/app_form.dart';
import 'package:santrihub/infrastructure/theme/screen/screen_size.dart';
import 'package:santrihub/infrastructure/theme/style/style.dart';
import 'package:santrihub/presentation/admin/dashboard/controllers/dashboard.controller.dart';

import '../../../../infrastructure/theme/color/colors.dart';
import '../../../../infrastructure/theme/theme.dart';

class CategoryForm extends StatelessWidget {
  const CategoryForm({super.key});

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
                    AppForm(
                      type: AppFormType.withLabel,
                      controller: controller.categoryController,
                      label: 'Category',
                      hintText: 'Masukkan nama kategori',
                    ),
                    Gap(22.h),
                    PrimaryButton(
                      isLoading: controller.isLoadingCategory,
                      isExpanded: true,
                      text: 'Tambahkan',
                      onPressed: () => controller.createCategory(context),
                    )
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
