import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:santrihub/domain/core/components/card/card_image.dart';
import 'package:santrihub/domain/core/utils/extension/date_format.dart';
import 'package:santrihub/domain/model/news.dart';
import 'package:santrihub/infrastructure/theme/color/colors.dart';
import 'package:santrihub/infrastructure/theme/font/fonts.dart';
import 'package:santrihub/infrastructure/theme/theme.dart';

class ItemNews extends StatelessWidget {
  const ItemNews({super.key, required this.data, this.onTap});

  final NewsModel data;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                        color: kInfoColor,
                        borderRadius: BorderRadius.circular(8.r)),
                    child: Text(data.category?.name ?? '',
                        style: theme.font.f16.white),
                  ),
                  Gap(12.h),
                  Text(
                    data.title ?? '',
                    style: theme.font.f18.semibold,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(16.h),
                  Text(
                    data.createdAt?.toLocalDateFormat ?? '',
                    style: theme.font.f18.copyWith(color: kGrey),
                  ),
                ])),
            Gap(20.w),
            SizedBox(
              height: 142.r,
              width: 142.r,
              child: CardImage.rectangle(
                image: data.image,
              ),
            )
          ],
        ),
      ),
    );
  }
}
