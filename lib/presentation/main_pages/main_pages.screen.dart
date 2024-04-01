import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:santrihub/domain/core/components/loading/page_loading.dart';
import 'package:santrihub/infrastructure/theme/style/style.dart';
import 'package:santrihub/infrastructure/theme/theme.dart';
import 'package:santrihub/presentation/main_pages/section/last_news.dart';

import '../../infrastructure/theme/screen/screen_size.dart';
import 'controllers/main_pages.controller.dart';
import 'section/app_bar.dart';
import 'section/first_news.dart';

class MainPagesScreen extends GetView<MainPagesController> {
  const MainPagesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constrain) {
      bool isMobile = constrain.maxWidth < 600;
      return Obx(() {
        if (controller.isLoading.value) {
          return const PageLoading();
        } else {
          return Scaffold(
              appBar: AppBarMainPage(
                isMobile: isMobile,
              ),
              body: isMobile ? _mainMobileScreen() : _mainWebScreen());
        }
      });
    });
  }

  Widget _mainWebScreen() {
    return Center(
      child: SizedBox(
        width: getWidthScale(1.2),
        child: ListView(
          padding: theme.style.padding.allLarge,
          children: const [
            FirstNews(
              isMobile: false,
              index: 0,
            ),
            LastNews(
              isMobile: false,
              index: 0,
            )
          ],
        ),
      ),
    );
  }

  Widget _mainMobileScreen() {
    return GetBuilder<MainPagesController>(builder: (controller) {
      return TabBarView(
          controller: controller.tabController,
          children: List.generate(
              controller.categories.length,
              (index) => SizedBox(
                    height: getHeightScale(1),
                    child: Column(
                      children: [
                        FirstNews(isMobile: true, index: index),
                        LastNews(isMobile: true, index: index)
                      ],
                    ),
                  )));
    });
  }
}
