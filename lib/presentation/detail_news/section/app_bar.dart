import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:santrihub/infrastructure/theme/color/colors.dart';
import 'package:santrihub/infrastructure/theme/font/fonts.dart';
import 'package:santrihub/infrastructure/theme/theme.dart';
import 'package:santrihub/presentation/detail_news/controllers/detail_news.controller.dart';

import '../../../infrastructure/theme/screen/screen_size.dart';

class AppBarDetailNews extends StatelessWidget implements PreferredSizeWidget {
  const AppBarDetailNews({Key? key, required this.isMobile}) : super(key: key);
  final bool isMobile;
  @override
  Widget build(BuildContext context) {
    // return isMobile ? _mobileScreen() : _webScreen();
    return GetBuilder<DetailNewsController>(builder: (controller) {
      if (isMobile) {
        return _webScreen(controller);
      } else {
        return _webScreen(controller);
      }
    });
  }

  AppBar _webScreen(DetailNewsController controller) {
    return AppBar(
      backgroundColor: kWhiteColor,
      surfaceTintColor: kPrimaryColor,
      title: SizedBox(
          width: getWidthScale(1.3),
          child: Text('SanHub', style: theme.font.f22.primary.semibold)),
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
