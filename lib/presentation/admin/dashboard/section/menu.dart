import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:santrihub/infrastructure/theme/color/colors.dart';
import 'package:santrihub/infrastructure/theme/screen/screen_size.dart';
import 'package:santrihub/infrastructure/theme/style/style.dart';
import 'package:santrihub/infrastructure/theme/theme.dart';
import 'package:santrihub/presentation/admin/dashboard/controllers/dashboard.controller.dart';
import 'package:santrihub/presentation/admin/dashboard/widget/menu_item.dart';

class MenuSection extends StatelessWidget {
  const MenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child: GetBuilder<DashboardController>(builder: (controller) {
          return Container(
            height: getHeightScale(1),
            color: kBorder.withOpacity(0.6),
            child: Column(
              children: [
                Container(
                  height: getHeightScale(8),
                ),
                Column(
                  children: List.generate(
                      controller.menus.length,
                      (index) => MenuItem(
                          title: controller.menus[index].name,
                          icon: controller.menus[index].icon,
                          selected: controller.selectedMenu ==
                              controller.menus[index].name,
                          onTap: () => controller.onMenuTap(index))),
                ),
              ],
            ),
          );
        }));
  }
}
