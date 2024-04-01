import 'package:get/get.dart';
import 'package:santrihub/infrastructure/dal/daos/repository/category_repository_impl.dart';
import 'package:santrihub/infrastructure/dal/daos/repository/news_repository_impl.dart';

import '../../../../presentation/admin/dashboard/controllers/dashboard.controller.dart';

class DashboardControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(NewsRepositoryImpl(), CategoryRepositoryImpl()),
    );
  }
}
