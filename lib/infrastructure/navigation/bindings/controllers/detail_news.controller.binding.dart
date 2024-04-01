import 'package:get/get.dart';
import 'package:santrihub/infrastructure/dal/daos/repository/news_repository_impl.dart';

import '../../../../presentation/detail_news/controllers/detail_news.controller.dart';

class DetailNewsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailNewsController>(
      () => DetailNewsController(NewsRepositoryImpl()),
    );
  }
}
