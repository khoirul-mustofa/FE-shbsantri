import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/detail_news.controller.dart';
import 'section/app_bar.dart';
import 'section/web_screen.dart';

class DetailNewsScreen extends GetView<DetailNewsController> {
  const DetailNewsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrain) {
      bool isMobile = constrain.maxWidth < 600;
      return Scaffold(
          appBar: AppBarDetailNews(
            isMobile: isMobile,
          ),
          body: isMobile ? const WebScreen() : const WebScreen());
    });
  }
}
