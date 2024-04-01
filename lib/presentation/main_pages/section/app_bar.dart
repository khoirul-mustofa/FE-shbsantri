import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:santrihub/domain/core/components/text/hover_builder.dart';
import 'package:santrihub/infrastructure/theme/color/colors.dart';
import 'package:santrihub/infrastructure/theme/font/fonts.dart';
import 'package:santrihub/infrastructure/theme/screen/screen_size.dart';
import 'package:santrihub/infrastructure/theme/theme.dart';
import 'package:santrihub/presentation/main_pages/controllers/main_pages.controller.dart';

class AppBarMainPage extends StatelessWidget implements PreferredSizeWidget {
  const AppBarMainPage({Key? key, required this.isMobile}) : super(key: key);
  final bool isMobile;
  @override
  Widget build(BuildContext context) {
    // return isMobile ? _mobileScreen() : _webScreen();
    return GetBuilder<MainPagesController>(builder: (controller) {
      if (isMobile) {
        return _mobileScreen(controller);
      } else {
        return _webScreen(controller);
      }
    });
  }

  AppBar _webScreen(MainPagesController controller) {
    return AppBar(
      backgroundColor: kWhiteColor,
      surfaceTintColor: kPrimaryColor,
      title: SizedBox(
        width: getWidthScale(1.3),
        child: Row(
          children: [
            Text('SanHub', style: theme.font.f22.primary.semibold),
            Gap(22.w),
            Container(
              height: 22.h,
              width: 1,
              color: kSoftGrey,
            ),
            Gap(22.w),
            SizedBox(
              height: kToolbarHeight,
              width: getWidthScale(1.6),
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    return Center(
                      child: GestureDetector(
                        onTap: () => controller
                            .setNewsByCategory(controller.categories[index].id),
                        child: HoverBuilder(builder: (isHovered) {
                          return Text(controller.categories[index].name ?? '',
                              style: theme.font.f20.copyWith(
                                  color:
                                      isHovered ? kPrimaryColor : kBlackColor));
                        }),
                      ),
                    );
                  },
                  separatorBuilder: (_, i) => Gap(32.w),
                  itemCount: controller.categories.length),
            ),
          ],
        ),
      ),
      automaticallyImplyLeading: false,
    );
  }

  Widget _mobileScreen(MainPagesController controller) {
    return AppBar(
      backgroundColor: kWhiteColor,
      surfaceTintColor: kPrimaryColor,
      title: Text('SanHub',
          style: theme.font.f28.primary.semibold.copyWith(fontSize: 65.wr)),
      automaticallyImplyLeading: false,
      centerTitle: false,
      bottom: TabBar(
          controller: controller.tabController,
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          labelStyle: theme.font.f28.primary.copyWith(fontSize: 45.wr),
          tabs: controller.categories.map((e) => Tab(text: e.name)).toList()),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(isMobile ? (kToolbarHeight + 32) : kToolbarHeight);
}
