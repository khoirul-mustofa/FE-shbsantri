import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:santrihub/domain/core/components/card/card_image.dart';
import 'package:santrihub/domain/core/utils/extension/date_format.dart';
import 'package:santrihub/infrastructure/navigation/routes.dart';

import 'package:santrihub/infrastructure/theme/color/colors.dart';
import 'package:santrihub/infrastructure/theme/font/fonts.dart';
import 'package:santrihub/infrastructure/theme/screen/screen_size.dart';
import 'package:santrihub/infrastructure/theme/style/style.dart';
import 'package:santrihub/infrastructure/theme/theme.dart';
import 'package:santrihub/presentation/main_pages/controllers/main_pages.controller.dart';

class FirstNews extends StatelessWidget {
  const FirstNews({super.key, required this.isMobile, required this.index});

  final bool isMobile;
  final int index;

  @override
  Widget build(BuildContext context) {
    return isMobile ? _mobileScreen() : _webScreen();
  }

  Widget _mobileScreen() {
    return Visibility(
      visible: index == 0,
      child: Padding(
        padding: theme.style.padding.allLarge,
        child: SizedBox(
          height: getHeightScale(10),
          width: getWidthScale(1),
          child: const CardImage.rectangle(
            image:
                'https://m.media-amazon.com/images/I/8179P8ww8BL._AC_UF1000,1000_QL80_.jpg',
          ),
        ),
      ),
    );
  }

  Widget _webScreen() {
    return GetBuilder<MainPagesController>(builder: (controller) {
      return Visibility(
        visible: controller.news.isNotEmpty,
        child: GestureDetector(
          onTap: () =>
              Get.toNamed(Routes.DETAIL_NEWS, arguments: controller.news[0].id),
          child: Padding(
            padding: theme.style.padding.horizontalSmall,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: getHeightScale(3),
                    child: CardImage.rectangle(
                      image: controller.news[0].image,
                    ),
                  ),
                ),
                Gap(32.w),
                Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 30.h,
                              child: CardImage.circle(
                                image: controller.news[0].user?.avatar ?? '',
                              ),
                            ),
                            Gap(12.w),
                            Text(controller.news[0].user?.name ?? '',
                                style: theme.font.f16.medium),
                            Gap(12.w),
                            CircleAvatar(
                              backgroundColor: kSoftGrey,
                              radius: 2.r,
                            ),
                            Gap(12.w),
                            Text(
                                controller
                                        .news[0].createdAt?.toLocalDateFormat ??
                                    '',
                                style: theme.font.f16.medium),
                          ],
                        ),
                        Gap(16.h),
                        Text(
                          controller.news[0].title ?? '',
                          style: theme.font.f28.bold.copyWith(fontSize: 41.wr),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Gap(16.h),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec adipiscing tristique risus nec. Integer enim neque volutpat ac tincidunt vitae semper quis. Vitae nunc sed velit dignissim sodales ut. Amet justo donec enim diam. Tortor id aliquet lectus proin. Non curabitur gravida arcu ac tortor dignissim convallis. Nisl purus in mollis nunc sed id. Massa id neque aliquam vestibulum. Ut sem nulla pharetra diam sit amet nisl. Elementum integer enim neque volutpat ac tincidunt vitae semper quis. Ut eu sem integer vitae justo eget magna fermentum iaculis. Eget egestas purus viverra accumsan in nisl.',
                          style: theme.font.f18.copyWith(color: kSoftGrey),
                        ),
                        Gap(16.h),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                  color: kInfoColor,
                                  borderRadius: BorderRadius.circular(6.r)),
                              child: Text(
                                  controller.news[0].category?.name ?? '',
                                  style: theme.font.f12.white),
                            ),
                            Gap(12.w),
                            CircleAvatar(
                              backgroundColor: kSoftGrey,
                              radius: 2.r,
                            ),
                            Gap(12.w),
                            Text(
                              "4 Min Read",
                              style: theme.font.f16.medium,
                            ),
                          ],
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      );
    });
  }
}
