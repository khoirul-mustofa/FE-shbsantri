import 'package:flutter/material.dart';
import 'package:santrihub/infrastructure/theme/color/colors.dart';
import 'package:santrihub/infrastructure/theme/screen/screen_size.dart';

class PageLoading extends StatelessWidget {
  const PageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getHeightScale(1),
      width: getWidthScale(1),
      color: kWhiteColor,
      child:
          const Center(child: CircularProgressIndicator(color: kPrimaryColor)),
    );
  }
}
