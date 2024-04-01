import 'dart:convert';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:santrihub/domain/core/components/snackbar/app_snackbar.dart';
import 'package:santrihub/domain/core/interfaces/news_repository.dart';
import 'package:santrihub/domain/model/news.dart';
import 'package:santrihub/domain/model/params/detail_news.dart';

import '../../../domain/model/params/news_params.dart';

class DetailNewsController extends GetxController {
  final NewsRepository newsRepository;

  DetailNewsController(this.newsRepository);
  bool isLoading = false;
  NewsModel? detailNews;
  QuillController htmlViewController = QuillController.basic();
  List<NewsModel> news = [];

  Future<void> getNewsById(int id) async {
    isLoading = true;
    update();
    var param = DetailNewsParam(id: id);
    final result = await newsRepository.getNewsById(param);
    result.fold((error) {}, (data) {
      detailNews = data;
      final json = jsonDecode(detailNews?.content ?? '');
      htmlViewController.document = Document.fromJson(json);
      update();
    });
    isLoading = false;
    update();
  }

  Future<void> getNews() async {
    var param = NewsParams(page: 1, limit: 6);
    final result = await newsRepository.getNews(param);
    result.fold((error) {
      AppSnackbar.show(message: error.message);
    }, (data) {
      news = data;
      update();
    });
  }

  @override
  void onInit() {
    getNewsById(Get.arguments).whenComplete(() {
      getNews();
    });
    super.onInit();
  }
}
