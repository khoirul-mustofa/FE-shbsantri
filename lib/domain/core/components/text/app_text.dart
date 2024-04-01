import 'package:flutter/material.dart';
import 'package:santrihub/infrastructure/theme/color/colors.dart';
import 'package:santrihub/infrastructure/theme/screen/screen_size.dart';
import 'package:santrihub/infrastructure/theme/theme.dart';

class AppText extends StatefulWidget {
  const AppText({
    super.key,
    required this.text,
    this.activeColor = kBlackColor,
    this.hoverColor = kPrimaryColor,
    this.isHover = false,
    this.fontSize = 12,
  });

  final String text;
  final Color activeColor;
  final Color hoverColor;
  final bool isHover;
  final double fontSize;

  @override
  State<AppText> createState() => _AppTextState();
}

class _AppTextState extends State<AppText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: theme.font.f12.copyWith(
          color: widget.isHover ? widget.hoverColor : widget.activeColor,
          fontSize: (widget.fontSize - 1).wr),
    );
  }
}
