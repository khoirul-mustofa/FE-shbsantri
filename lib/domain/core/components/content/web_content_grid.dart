import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:santrihub/domain/core/utils/extension/date_format.dart';
import 'package:santrihub/domain/model/news.dart';
import 'package:santrihub/infrastructure/theme/font/fonts.dart';

import '../../../../infrastructure/theme/color/colors.dart';
import '../../../../infrastructure/theme/screen/screen_size.dart';
import '../../../../infrastructure/theme/theme.dart';
import '../card/card_image.dart';

class WebContentGrid extends StatelessWidget {
  const WebContentGrid({super.key, required this.data, this.onTap});

  final NewsModel data;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: getHeightScale(3),
              width: getWidthScale(4),
              child: CardImage.rectangle(
                image: data.image,
              ),
            ),
            Gap(12.h),
            Row(
              children: [
                SizedBox(
                  height: 24.h,
                  child: CardImage.circle(
                    image: data.user?.avatar,
                  ),
                ),
                Gap(8.w),
                Expanded(
                    child: Text(
                  data.user?.name ?? '',
                  style: theme.font.f14.medium,
                  overflow: TextOverflow.ellipsis,
                )),
                Gap(8.w),
                CircleAvatar(
                  backgroundColor: kSoftGrey,
                  radius: 2.r,
                ),
                Gap(8.w),
                Text(data.createdAt?.toLocalDateFormat ?? '',
                    style: theme.font.f14.medium),
              ],
            ),
            Gap(16.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
              decoration: BoxDecoration(
                  color: kInfoColor, borderRadius: BorderRadius.circular(6.r)),
              child:
                  Text(data.category?.name ?? '', style: theme.font.f12.white),
            ),
            Gap(12.h),
            Text(
              data.title ?? '',
              style: theme.font.f22.bold,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Gap(16.w),
            Text(data.createdAt?.toLocalDateFormat ?? '',
                style: theme.font.f14.copyWith(color: kGrey)),
          ],
        ),
      ),
    );
  }
}
