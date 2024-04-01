import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:santrihub/infrastructure/theme/color/colors.dart';
import 'package:santrihub/presentation/admin/dashboard/section/content_menu.dart';
import 'package:santrihub/presentation/admin/dashboard/section/menu.dart';

import 'controllers/dashboard.controller.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kWhiteColor,
      // appBar: AppBarDashboard(),
      body: Row(children: [MenuSection(), ContentMenuSection()]),
    );
  }
}
