import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:santrihub/domain/core/components/card/card_image.dart';
import 'package:santrihub/infrastructure/theme/color/colors.dart';
import 'package:santrihub/infrastructure/theme/font/fonts.dart';
import 'package:santrihub/infrastructure/theme/screen/screen_size.dart';
import 'package:santrihub/infrastructure/theme/style/style.dart';
import 'package:santrihub/infrastructure/theme/theme.dart';
import 'package:santrihub/presentation/admin/dashboard/controllers/dashboard.controller.dart';
import 'package:santrihub/presentation/admin/dashboard/section/dashboard.dart';
import 'package:santrihub/presentation/admin/dashboard/section/news.dart';

class ContentMenuSection extends StatelessWidget {
  const ContentMenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 13,
        child: GetBuilder<DashboardController>(builder: (controller) {
          return Container(
            color: kWhiteColor,
            padding: theme.style.padding.allLarge.copyWith(bottom: 0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Dashboard', style: theme.font.f18.black),
                    const Spacer(),
                    SizedBox(
                      height: 44.h,
                      child: const CardImage.circle(
                        image:
                            'https://m.media-amazon.com/images/I/8179P8ww8BL._AC_UF1000,1000_QL80_.jpg',
                      ),
                    )
                  ],
                ),
                Gap(16.h),
                const Divider(
                  height: 0,
                  color: kBorder,
                  thickness: 1.2,
                ),
                // const DashboardSection(),
                const NewsSection(),
              ],
            ),
          );
        }));
  }
}
