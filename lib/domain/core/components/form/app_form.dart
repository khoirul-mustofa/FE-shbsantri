import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:santrihub/infrastructure/theme/font/fonts.dart';

import '../../../../infrastructure/theme/color/colors.dart';
import '../../../../infrastructure/theme/screen/screen_size.dart';
import '../../../../infrastructure/theme/theme.dart';

enum AppFormType { normal, withLabel }

class AppForm extends StatelessWidget {
  const AppForm({
    super.key,
    required this.controller,
    this.label,
    this.icon,
    this.isError = false,
    this.hintText,
    this.isTextSmall = false,
    this.textAlign,
    this.type = AppFormType.normal,
    this.textArea = false,
    this.keyboardType,
    this.focusNode,
    this.inputFormatters,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
  });

  final TextEditingController controller;
  final String? label;
  final String? icon;
  final bool isError;
  final bool isTextSmall;
  final String? hintText;
  final TextAlign? textAlign;
  final AppFormType type;
  final bool textArea;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final Function(String)? onFieldSubmitted;
  @override
  Widget build(BuildContext context) {
    return type == AppFormType.normal
        ? _buildNormalForm(theme)
        : _buildWithLabel(theme);
  }

  Widget _buildNormalForm(AppTheme theme) {
    return SizedBox(
      height: textArea ? 70.h : 44.h,
      width: getWidthScale(1),
      child: TextFormField(
          focusNode: focusNode,
          controller: controller,
          cursorColor: kPrimaryColor,
          style: isTextSmall ? theme.font.f12.black : theme.font.f14.black,
          maxLines: textArea ? 5 : 1,
          textAlign: textAlign ?? TextAlign.left,
          onChanged: onChanged,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          onEditingComplete: onEditingComplete,
          onFieldSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: isTextSmall
                ? theme.font.f12.copyWith(color: kSoftGrey)
                : theme.font.f14.copyWith(color: kSoftGrey),
            filled: true,
            fillColor: kWhiteColor,
            border: border,
            enabledBorder: border,
            focusedBorder: border,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.w),
          )),
    );
  }

  Widget _buildWithLabel(AppTheme theme) {
    return SizedBox(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label ?? 'Label', style: theme.font.f14.black),
        Gap(8.h),
        _buildNormalForm(theme)
      ]),
    );
  }

  OutlineInputBorder get border {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: kSofterGrey));
  }
}
