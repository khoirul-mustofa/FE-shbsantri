import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:santrihub/domain/core/components/card/card_image.dart';
import 'package:santrihub/domain/core/utils/extension/date_format.dart';
import 'package:santrihub/infrastructure/navigation/routes.dart';
import 'package:santrihub/infrastructure/theme/font/fonts.dart';
import 'package:santrihub/infrastructure/theme/style/style.dart';
import 'package:santrihub/infrastructure/theme/theme.dart';
import 'package:santrihub/presentation/detail_news/controllers/detail_news.controller.dart';

import '../../../infrastructure/theme/color/colors.dart';
import '../../../infrastructure/theme/screen/screen_size.dart';
import '../widget/item_news.dart';

class WebScreen extends StatelessWidget {
  const WebScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailNewsController>(builder: (controller) {
      if (controller.isLoading) {
        return const Center(
            child: CircularProgressIndicator(
          color: kPrimaryColor,
        ));
      } else {
        return Center(
          child: SizedBox(
            width: getWidthScale(1.3),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(42.h),
                  Center(
                    child: Text(
                      controller.detailNews?.title ?? '',
                      style: GoogleFonts.inter(
                          fontSize: 41.wr, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Gap(18.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.detailNews?.createdAt?.toLocalDateFormat ??
                            '',
                        style: theme.font.f22.copyWith(color: kSoftGrey),
                        textAlign: TextAlign.center,
                      ),
                      Gap(12.w),
                      Container(
                        height: 32.h,
                        width: 1.2,
                        color: kSoftGrey,
                      ),
                      Gap(12.w),
                      Text(
                        controller.detailNews?.createdAt?.convertToLocaleTime ??
                            '',
                        style: theme.font.f22.copyWith(color: kSoftGrey),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  Gap(52.h),
                  SizedBox(
                    width: getWidthScale(1.3),
                    height: getHeightScale(2),
                    child: CardImage.rectangle(
                      image: controller.detailNews?.image ?? '',
                    ),
                  ),
                  Gap(22.h),
                  Row(
                    children: [
                      CardImage.circle(
                        size: 34.r,
                        image: controller.detailNews?.user?.avatar ?? '',
                      ),
                      Gap(12.w),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(controller.detailNews?.user?.name ?? '',
                                style: theme.font.f18),
                            Text(controller.detailNews?.createdAt ?? '',
                                style: theme.font.f18.red),
                          ])
                    ],
                  ),
                  Gap(32.h),
                  QuillEditor.basic(
                    configurations: QuillEditorConfigurations(
                      controller: controller.htmlViewController,
                      readOnly: true,
                      sharedConfigurations:
                          const QuillSharedConfigurations(locale: Locale('id')),
                    ),
                  ),
                  Gap(52.h),
                  Text('Baca Juga',
                      style: GoogleFonts.inter(
                          fontSize: 23.wr, fontWeight: FontWeight.w700)),
                  Gap(18.h),
                  const Divider(
                    height: 0,
                    color: kBorder,
                  ),
                  Gap(18.h),
                  StaggeredGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      children: List.generate(
                          controller.news.length,
                          (index) => ItemNews(
                                data: controller.news[index],
                                onTap: () => Get.offNamed(Routes.DETAIL_NEWS,
                                    arguments: controller.news[index].id),
                              ))),
                  Gap(62.h),
                ],
              ),
            ),
          ),
        );
      }
    });
  }
}
