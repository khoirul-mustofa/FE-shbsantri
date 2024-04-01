import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:santrihub/infrastructure/navigation/routes.dart';
import 'package:santrihub/infrastructure/theme/color/colors.dart';
import 'package:santrihub/infrastructure/theme/font/fonts.dart';
import 'package:santrihub/infrastructure/theme/style/style.dart';
import 'package:santrihub/infrastructure/theme/theme.dart';
import 'package:santrihub/presentation/main_pages/controllers/main_pages.controller.dart';

import '../../../domain/core/components/card/card_image.dart';
import '../../../domain/core/components/content/web_content_grid.dart';
import '../../../infrastructure/theme/screen/screen_size.dart';

class LastNews extends StatelessWidget {
  const LastNews({super.key, required this.isMobile, required this.index});

  final bool isMobile;
  final int index;

  @override
  Widget build(BuildContext context) {
    return isMobile ? _mobileScreen() : _webScreen();
  }

  Widget _mobileScreen() {
    return Padding(
      padding: theme.style.padding.allLarge,
      child: SizedBox(
        height: getHeightScale(1.3),
        child: ListView.separated(
            itemBuilder: (_, index) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: getHeightScale(11),
                      child: const CardImage.rectangle(
                        image:
                            'https://m.media-amazon.com/images/I/8179P8ww8BL._AC_UF1000,1000_QL80_.jpg',
                      ),
                    ),
                  ),
                  Gap(12.h),
                  Expanded(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 26.h,
                                child: const CardImage.circle(
                                  image:
                                      'https://m.media-amazon.com/images/I/8179P8ww8BL._AC_UF1000,1000_QL80_.jpg',
                                ),
                              ),
                              Gap(16.w),
                              Text('KH. Halim Mahfudz',
                                  style: isMobile
                                      ? theme.font.f24.medium
                                      : theme.font.f16.medium),
                              Gap(12.w),
                              CircleAvatar(
                                backgroundColor: kSoftGrey,
                                radius: 4.r,
                              ),
                              Gap(12.w),
                              Text('12 Minute Ago',
                                  style: isMobile
                                      ? theme.font.f24.medium
                                      : theme.font.f16.medium),
                            ],
                          ),
                          Text(
                            "Where to watch 'Jhon Wich: Chapter 4'",
                            style:
                                theme.font.f28.bold.copyWith(fontSize: 41.wr),
                          ),
                          Gap(6.h),
                          Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec adipiscing tristique risus nec. Integer enim neque volutpat ac tincidunt vitae semper quis. Vitae nunc sed velit dignissim sodales ut. Amet justo donec enim diam. Tortor id aliquet lectus proin. Non curabitur gravida arcu ac tortor dignissim convallis. Nisl purus in mollis nunc sed id. Massa id neque aliquam vestibulum. Ut sem nulla pharetra diam sit amet nisl. Elementum integer enim neque volutpat ac tincidunt vitae semper quis. Ut eu sem integer vitae justo eget magna fermentum iaculis. Eget egestas purus viverra accumsan in nisl.',
                            style: isMobile
                                ? theme.font.f26.medium
                                    .copyWith(color: kSoftGrey)
                                : theme.font.f18.copyWith(color: kSoftGrey),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Gap(12.h),
                          Row(
                            children: [
                              Text(
                                "Antariksa",
                                style: isMobile
                                    ? theme.font.f24.medium
                                        .copyWith(color: kSecondaryColor)
                                    : theme.font.f16.bold
                                        .copyWith(color: kSecondaryColor),
                              ),
                              Gap(12.w),
                              CircleAvatar(
                                backgroundColor: kSoftGrey,
                                radius: 4.r,
                              ),
                              Gap(12.w),
                              Text(
                                "4 Min Read",
                                style: isMobile
                                    ? theme.font.f24.medium
                                    : theme.font.f16.medium,
                              ),
                            ],
                          )
                        ],
                      ))
                ],
              );
            },
            separatorBuilder: (_, i) => Gap(12.h),
            itemCount: 16),
      ),
    );
  }

  Widget _webScreen() {
    return GetBuilder<MainPagesController>(builder: (controller) {
      return Padding(
          padding: theme.style.padding.allLarge.copyWith(top: 32),
          child: Column(children: [
            Row(children: [
              Gap(16.w),
              Text('Last News', style: theme.font.f20.bold),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Text('See all', style: theme.font.f16.secondary.semibold),
                      Gap(12.w),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12.sp,
                        color: kSecondaryColor,
                      )
                    ],
                  ),
                ),
              ),
            ]),
            Gap(20.h),
            StaggeredGrid.count(
                crossAxisCount: 4,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: List.generate(
                    controller.news.length,
                    (index) => WebContentGrid(
                          data: controller.news[index],
                          onTap: () => Get.toNamed(Routes.DETAIL_NEWS,
                              arguments: controller.news[index].id),
                        )))
          ]));
    });
  }
}
