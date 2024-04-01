import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:santrihub/infrastructure/theme/color/colors.dart';
import 'package:santrihub/infrastructure/theme/font/fonts.dart';
import 'package:santrihub/infrastructure/theme/style/style.dart';
import 'package:santrihub/infrastructure/theme/theme.dart';

class MenuItem extends StatefulWidget {
  const MenuItem(
      {super.key,
      this.onTap,
      required this.title,
      required this.icon,
      this.selected = false});

  final Function()? onTap;
  final String title;
  final IconData icon;
  final bool selected;

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 56.h,
        padding: theme.style.padding.horizontalMedium,
        decoration: BoxDecoration(
            color: widget.selected ? kBorder : Colors.transparent,
            border: widget.selected
                ? const Border(
                    right: BorderSide(color: kPrimaryColor, width: 2))
                : null),
        child: Row(
          children: [
            Icon(
              widget.icon,
              color: widget.selected
                  ? kPrimaryColor
                  : kBlackColor.withOpacity(0.4),
              size: 28.r,
            ),
            Gap(12.w),
            Expanded(
              child: Text(widget.title,
                  style: theme.font.f18.black.semibold.copyWith(
                      color: widget.selected
                          ? kBlackColor
                          : kBlackColor.withOpacity(0.4))),
            ),
          ],
        ),
      ),
    );
  }
}
