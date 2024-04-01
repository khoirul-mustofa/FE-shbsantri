// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:santrihub/domain/core/interfaces/category_repository.dart';
import 'package:santrihub/domain/core/interfaces/news_repository.dart';
import 'package:santrihub/domain/model/category.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:santrihub/domain/model/news.dart';
import 'package:santrihub/domain/model/params/news_params.dart';

import '../../../domain/core/components/snackbar/app_snackbar.dart';

class MainPagesController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final NewsRepository newsRepository;
  final CategoryRepository categoryRepository;
  MainPagesController(this.newsRepository, this.categoryRepository);
  late TabController tabController;

  List<CategoryModel> categories = [];
  late PagingController<int, NewsModel> pagingController;
  List<NewsModel> news = [];
  int _limit = 10;
  var isLoading = false.obs;
  var currentIndexTab = 0.obs;
  var loadingOnChangeTab = false.obs;
  CategoryModel? selectedCategory;

  Future<void> getCategories() async {
    isLoading.value = true;
    final result = await categoryRepository.getCategories();
    result.fold((error) {
      print(error);
    }, (data) {
      categories = data;
      update();
    });
    isLoading.value = false;
  }

  Future<void> getNews() async {
    var param = NewsParams(page: 1, limit: 4, categoryId: selectedCategory?.id);
    final result = await newsRepository.getNews(param);
    result.fold((error) {
      AppSnackbar.show(message: error.message);
    }, (data) {
      news = data;
      update();
    });
  }

  Future<void> getNewse(int pageKey) async {
    try {
      _limit += 5;
      var param = NewsParams(
          page: pageKey, limit: _limit, categoryId: selectedCategory?.id);
      final response = await newsRepository.getNews(param);
      response.fold((error) => null, (data) {
        final isLastPage = data.length < _limit;

        if (isLastPage) {
          pagingController.appendLastPage(data);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(data, nextPageKey);
        }
      });
    } catch (error) {
      pagingController.error = error;
    }
  }

  setNewsByCategory(int? index) {
    selectedCategory = categories[index ?? 0];
    currentIndexTab.value = index ?? 0;
    // pagingController.itemList?.clear();
    // getNewse(1);
    getNews();
    Future.delayed(1.seconds, () {
      loadingOnChangeTab(false);
    });
  }

  @override
  void onInit() {
    getCategories();
    tabController = TabController(length: categories.length, vsync: this);
    pagingController = PagingController(firstPageKey: 1);
    getNews();
    // pagingController.addPageRequestListener((pageKey) {
    //   getNews(pageKey);
    // });

    tabController.addListener(() {
      currentIndexTab.value = tabController.index;
      loadingOnChangeTab(true);
      if (!tabController.indexIsChanging) {
        setNewsByCategory(tabController.index);
      }
    });
    super.onInit();
  }
}
