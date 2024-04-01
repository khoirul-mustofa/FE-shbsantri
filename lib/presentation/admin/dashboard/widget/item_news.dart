import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:santrihub/domain/core/components/button/primary_button.dart';
import 'package:santrihub/domain/core/components/text/hover_builder.dart';
import 'package:santrihub/infrastructure/navigation/routes.dart';
import 'package:santrihub/infrastructure/theme/color/colors.dart';
import 'package:santrihub/infrastructure/theme/font/fonts.dart';
import 'package:santrihub/infrastructure/theme/style/style.dart';

import '../../../../domain/core/components/card/card_image.dart';
import '../../../../domain/model/news.dart';
import '../../../../infrastructure/theme/theme.dart';

class ItemNews extends StatelessWidget {
  const ItemNews(
      {super.key,
      required this.data,
      this.publish,
      this.onEdit,
      this.onDelete,
      this.toDetail});
  final NewsModel data;
  final Function()? publish;
  final Function()? onEdit;
  final Function()? onDelete;
  final Function()? toDetail;

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(builder: (isHovered) {
      return Container(
        padding: theme.style.padding.allSmall,
        decoration: BoxDecoration(
            color: isHovered ? kBorder.withOpacity(0.5) : Colors.transparent,
            borderRadius: theme.style.borderRadius.allSmall),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardImage.rectangle(
              size: 120.r,
              image: data.image,
            ),
            Gap(12.w),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data.title ?? '',
                      style: theme.font.f14,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gap(12.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          data.category?.name ?? '',
                          style: theme.font.f12.red,
                        ),
                        const Spacer(),
                        Visibility(
                            visible: data.isPublish == false,
                            child: PrimaryButton(
                              isPublish: true,
                              size: PrimaryButtonSize.small,
                              text: 'Publish',
                              onPressed: publish,
                            )),
                        Visibility(
                            visible: data.isPublish == null,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: onEdit,
                                  child: Container(
                                    height: 32.r,
                                    width: 32.r,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                        color: kPrimaryColor),
                                    child: Icon(Icons.edit,
                                        size: 16.r, color: kWhiteColor),
                                  ),
                                ),
                                Gap(8.w),
                                GestureDetector(
                                  onTap: onDelete,
                                  child: Container(
                                    height: 32.r,
                                    width: 32.r,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                        color: kPrimaryColor),
                                    child: Icon(Icons.delete,
                                        size: 16.r, color: kWhiteColor),
                                  ),
                                )
                              ],
                            )),
                        Gap(12.w),
                        GestureDetector(
                          onTap: toDetail,
                          child: Container(
                            height: 32.r,
                            width: 32.r,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.r),
                                color: kPrimaryColor),
                            child: Icon(Icons.remove_red_eye_outlined,
                                size: 16.r, color: kWhiteColor),
                          ),
                        )
                      ],
                    ),
                  ]),
            )
          ],
        ),
      );
    });
  }
}
