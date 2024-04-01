import 'package:get/get.dart';
import 'package:santrihub/infrastructure/dal/daos/repository/category_repository_impl.dart';
import 'package:santrihub/infrastructure/dal/daos/repository/news_repository_impl.dart';

import '../../../../presentation/main_pages/controllers/main_pages.controller.dart';

class MainPagesControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainPagesController>(
      () => MainPagesController(NewsRepositoryImpl(), CategoryRepositoryImpl()),
    );
  }
}
