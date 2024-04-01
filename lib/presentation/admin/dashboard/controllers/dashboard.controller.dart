import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:santrihub/domain/core/components/snackbar/app_snackbar.dart';
import 'package:santrihub/domain/model/params/category.dart';
import 'package:santrihub/domain/model/params/detail_news.dart';
import 'package:santrihub/infrastructure/theme/color/colors.dart';
import 'package:santrihub/infrastructure/theme/font/fonts.dart';
import 'package:santrihub/infrastructure/theme/theme.dart';
import 'package:toastification/toastification.dart';

import '../../../../domain/core/components/dialog/confirmation_dialog.dart';
import '../../../../domain/core/interfaces/category_repository.dart';
import '../../../../domain/core/interfaces/news_repository.dart';
import '../../../../domain/model/category.dart';
import '../../../../domain/model/news.dart';
import '../../../../domain/model/params/news_body.dart';
import '../../../../domain/model/params/news_params.dart';
import '../../../../infrastructure/dal/daos/remote/upload_file_body.dart';
import 'dart:html' as html;
import 'dart:convert' show base64Encode;
import 'dart:ui' as ui;

class DashboardController extends GetxController {
  final NewsRepository newsRepository;
  final CategoryRepository categoryRepository;
  DashboardController(this.newsRepository, this.categoryRepository);
  QuillController htmlController = QuillController.basic();
  QuillController htmlViewController = QuillController.basic();
  TextEditingController categoryController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  late PagingController<int, NewsModel> pagingController;
  int _limit = 10;
  List<CategoryModel> categories = [];
  CategoryModel? selectedCategory;
  List<ImagePickerData> imagesUrl = [];
  bool isLoadingCategory = false;
  bool isLoadingNews = false;
  String? searchName;
  List<PlatformFile>? pathFile;

  Future<void> getCategories() async {
    selectedCategory = null;
    final result = await categoryRepository.getCategories();
    result.fold((error) {
      print(error);
    }, (data) {
      categories = data;
      update();
    });
  }

  Future<void> createCategory(BuildContext context) async {
    isLoadingCategory = true;
    update();
    var body = CategoryBody(name: categoryController.text);
    final result = await categoryRepository.createCategories(body);
    result.fold((error) {
      showTost('Gagal menambahkan kategori', false, context);
    }, (data) {
      log("HAPUSNYA : $data");
      showTost('Berhasil menambahkan kategori', true, context);
      getCategories();
    });
    Get.back();
    isLoadingCategory = false;
    update();
  }

  Future<void> createNews(BuildContext context) async {
    isLoadingNews = true;
    update();
    var json = jsonEncode(htmlController.document.toDelta().toJson());
    log(json);
    var body = NewsBody(
        title: titleController.text,
        content: json,
        categoryId: selectedCategory?.id ?? 0,
        userId: 1,
        image:
            "https://images.unsplash.com/photo-1707327956851-30a531b70cda?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D");

    final result = await newsRepository.createNews(body);
    result.fold((error) {
      isLoadingNews = false;
      update();
      showTost('Gagal menambahkan berita', false, context);
    }, (data) {
      titleController.clear();
      selectedCategory = null;
      showTost('Berhasil menambahkan berita', true, context);
      pagingController.refresh();
    });
    isLoadingNews = false;
    update();
  }

  Future<void> getNews(int pageKey) async {
    try {
      _limit += 5;
      var param = NewsParams(page: pageKey, limit: _limit, search: searchName);
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

  void confirmationDelete(BuildContext context, int id) {
    Get.back();
    ConfirmationDialog.show(
        title: 'Hapus',
        message: 'Apakah anda yakin ingin menghapus berita?',
        onTapText: 'hapus',
        onPressed: () => deleteNews(context, id));
  }

  Future<void> deleteCategory(BuildContext context, int id) async {
    final result = await categoryRepository.deleteCategories(id);
    result.fold((error) {
      showTost('Gagal menghapus kategori', false, context);
    }, (data) {
      showTost('Berhasil menghapus kategori', true, context);
      getCategories();
    });
  }

  Future<void> deleteNews(BuildContext context, int id) async {
    Get.back();
    var param = DetailNewsParam(id: id);
    final result = await newsRepository.deleteNews(param);
    result.fold((error) {
      showTost('Gagal menghapus berita', false, context);
    }, (data) {
      showTost('Berhasil menghapus berita', true, context);
      pagingController.refresh();
    });
  }

  String selectedMenu = "Dashboard";
  List<MenuItemData> menus = [
    MenuItemData(name: 'Dashboard', icon: Icons.home),
    MenuItemData(name: 'News', icon: Icons.newspaper_rounded),
  ];

  void searchNews(String value) {
    searchName = value;
    pagingController.refresh();
  }

  void onMenuTap(int index) {
    selectedMenu = menus[index].name;
    update();
  }

  void selectCategory(CategoryModel category) {
    selectedCategory = category;
    update();
  }

  Uint8List webImage = Uint8List(8);

  void pickImage(BuildContext context) async {
    try {
      Uint8List? byteFromPicker = await ImagePickerWeb.getImageAsBytes();
      if (byteFromPicker != null) {
        webImage = byteFromPicker;
        final body =
            UploadImageBody(pathFile!.first.name, pathFile!.first.bytes!);
        log(body.toJson().toString());
        uploadImage(body, context);
      }
    } catch (e) {}
    // try {
    //   pathFile = (await FilePicker.platform.pickFiles(
    //           type: FileType.custom,
    //           allowMultiple: false,
    //           onFileLoading: (FilePickerStatus status) => print(status),
    //           allowedExtensions: ['png', 'jpg', 'jpeg']))
    //       ?.files;
    // } on PlatformException catch (e) {
    //   print("Unsupported operation$e");
    // } catch (e) {
    //   print(e.toString());
    // }

    // if (pathFile != null) {
    //   final body =
    //       UploadImageBody(pathFile!.first.name, pathFile!.first.bytes!);
    //   log(body.toJson().toString());
    //   uploadImage(body, context);
    // }
    // if (kIsWeb) {
    //   final html.FileUploadInputElement input = html.FileUploadInputElement();
    //   input.accept = 'image/*'; // Set accepted file types
    //   input.multiple =
    //       false; // Set to true if you want to allow selecting multiple files
    //   input.click(); // Simulate a click on the input element
    //   await input.onChange.first; // Wait for the file to be selected

    //   if (input.files != null && input.files!.isNotEmpty) {
    //     final file = input.files![0];
    //     final reader = html.FileReader();
    //     reader.readAsArrayBuffer(file);
    //     await reader.onLoad.first;

    //     final List<int> fileBytes = reader.result as List<int>;

    //     // Now you have the fileBytes, you can proceed with uploading
    //     final body = UploadImageBody(file.name, fileBytes);
    //     log(body.toJson().toString());
    //     uploadImage(body, context);
    //   }
    // } else {
    //   // Handle image picking for mobile platforms
    // }
  }

  Future<void> uploadImage(UploadImageBody body, BuildContext context) async {
    try {
      final result = await newsRepository.uploadImage(body);
      result.fold(
        (error) => showTost(error.message, false, context),
        (data) {
          imagesUrl.add(ImagePickerData(url: data, name: body.fileName));
          update();
          showTost('Berhasil menambahkan gambar', true, context);
        },
      );
    } catch (e) {
      print('Error uploading image: $e');
      // Handle error
    }
  }

  void setDataEdit() {}

  void showTost(String message, bool isSuccess, BuildContext context) {
    toastification.show(
      type: isSuccess ? ToastificationType.success : ToastificationType.error,
      style: ToastificationStyle.fillColored,
      context: context,
      icon: Icon(
        isSuccess ? Icons.check_circle : Icons.error,
        color: kWhiteColor,
      ),
      title: Text(message, style: theme.font.f16.white),
      autoCloseDuration: const Duration(seconds: 5),
    );
  }

  @override
  void onInit() {
    getCategories();
    pagingController = PagingController(firstPageKey: 1);
    pagingController.addPageRequestListener((pageKey) {
      getNews(pageKey);
    });

    super.onInit();
  }
}

class MenuItemData {
  String name;
  IconData icon;
  MenuItemData({required this.name, required this.icon});
}

class ImagePickerData {
  String url;
  String name;
  ImagePickerData({required this.url, required this.name});
}
