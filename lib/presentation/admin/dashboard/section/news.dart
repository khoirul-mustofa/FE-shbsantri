import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:santrihub/domain/core/components/button/primary_button.dart';
import 'package:santrihub/domain/core/components/card/card_image.dart';
import 'package:santrihub/domain/core/components/form/app_form.dart';
import 'package:santrihub/domain/model/category.dart';
import 'package:santrihub/domain/model/news.dart';
import 'package:santrihub/infrastructure/theme/color/colors.dart';
import 'package:santrihub/infrastructure/theme/font/fonts.dart';
import 'package:santrihub/infrastructure/theme/screen/screen_size.dart';
import 'package:santrihub/infrastructure/theme/style/style.dart';
import 'package:santrihub/infrastructure/theme/theme.dart';
import 'package:santrihub/presentation/admin/dashboard/controllers/dashboard.controller.dart';
import 'package:santrihub/presentation/admin/dashboard/widget/category_form.dart';
import 'package:santrihub/presentation/admin/dashboard/widget/list_category.dart';

import '../../../../domain/core/components/infiniti_page/infiniti_page.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../widget/item_news.dart';

class NewsSection extends StatelessWidget {
  const NewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (controller) {
      return Visibility(
        visible: controller.selectedMenu == 'News',
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: Container(
                height: getHeightScale(1.1),
                padding: EdgeInsets.only(right: 12.w),
                decoration: const BoxDecoration(
                  border: Border(right: BorderSide(color: kBorder)),
                ),
                child: ListView(
                  children: [
                    Gap(16.h),
                    RichText(
                        text: TextSpan(
                            text: 'Kategori',
                            style: theme.font.f16.semibold,
                            children: [
                          TextSpan(text: '*', style: theme.font.f16.red)
                        ])),
                    Gap(12.h),
                    SizedBox(
                      height: 44.h,
                      child: Row(children: [
                        Expanded(
                          child: Container(
                            height: 44.h,
                            decoration: BoxDecoration(
                                color: kWhiteColor,
                                borderRadius: theme.style.borderRadius.allSmall,
                                border: Border.all(color: kBorder)),
                            child: DropdownButton<CategoryModel>(
                                value: controller.selectedCategory,
                                underline: const SizedBox.shrink(),
                                icon: Icon(Icons.keyboard_arrow_down_rounded,
                                    color: kSoftGrey),
                                padding: theme.style.padding.horizontalSmall,
                                hint: Center(
                                  child: Text(
                                    'Pilih Kategori',
                                    style: theme.font.f16
                                        .copyWith(color: kSoftGrey),
                                  ),
                                ),
                                isExpanded: true,
                                items: controller.categories
                                    .map((e) => DropdownMenuItem<CategoryModel>(
                                        value: e,
                                        child: Text(
                                          e.name ?? '',
                                          style: theme.font.f18,
                                        )))
                                    .toList(),
                                onChanged: (value) =>
                                    controller.selectCategory(value!)),
                          ),
                        ),
                        Gap(16.w),
                        PrimaryButton(
                          text: 'Tambah Kategori',
                          onPressed: () {
                            Get.dialog(const CategoryForm());
                          },
                        ),
                        Gap(16.w),
                        PrimaryButton(
                            isDelete: true,
                            text: 'Hapus',
                            onPressed: () {
                              Get.dialog(const ListCategory());
                            })
                      ]),
                    ),
                    Gap(16.h),
                    RichText(
                        text: TextSpan(
                            text: 'Judul',
                            style: theme.font.f16.semibold,
                            children: [
                          TextSpan(text: '*', style: theme.font.f16.red)
                        ])),
                    Gap(12.h),
                    AppForm(
                      controller: controller.titleController,
                      hintText: 'Masukkan Judul',
                    ),
                    Gap(16.h),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                              text: TextSpan(
                                  text: 'Gambar',
                                  style: theme.font.f16.semibold,
                                  children: [
                                TextSpan(text: '*', style: theme.font.f16.red)
                              ])),
                        ]),
                    Gap(8.h),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => controller.pickImage(context),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Visibility(
                                visible: controller.imagesUrl.isEmpty,
                                child: Container(
                                  height: getHeightScale(4),
                                  width: getHeightScale(4),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          theme.style.borderRadius.allSmall,
                                      color: kSofterGrey),
                                  child: const Center(
                                    child: Icon(
                                      Icons.cloud_upload_rounded,
                                      color: kBorder,
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: controller.imagesUrl.isNotEmpty,
                                child: SizedBox(
                                    height: getHeightScale(4),
                                    width: getHeightScale(4),
                                    child: CardImage.rectangle(
                                      image: controller.imagesUrl.isNotEmpty
                                          ? controller.imagesUrl[0].url
                                          : '',
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Gap(16.h),
                    RichText(
                        text: TextSpan(
                            text: 'Kontent',
                            style: theme.font.f16.semibold,
                            children: [
                          TextSpan(text: '*', style: theme.font.f16.red)
                        ])),
                    Gap(12.h),
                    Container(
                      padding: theme.style.padding.allMedium,
                      decoration: BoxDecoration(
                          borderRadius: theme.style.borderRadius.allSmall,
                          border: Border.all(color: kBorder)),
                      child: QuillToolbar.simple(
                        configurations: QuillSimpleToolbarConfigurations(
                          controller: controller.htmlController,
                          sharedConfigurations: const QuillSharedConfigurations(
                              locale: Locale('id')),
                        ),
                      ),
                    ),
                    Gap(8.h),
                    Container(
                      height: getHeightScale(1.8),
                      padding: theme.style.padding.allMedium,
                      decoration: BoxDecoration(
                          borderRadius: theme.style.borderRadius.allSmall,
                          border: Border.all(color: kBorder)),
                      child: QuillEditor.basic(
                        configurations: QuillEditorConfigurations(
                          controller: controller.htmlController,
                          readOnly: false,
                          sharedConfigurations: const QuillSharedConfigurations(
                              locale: Locale('id')),
                        ),
                      ),
                    ),
                    Gap(38.h),
                    PrimaryButton(
                      isLoading: controller.isLoadingNews,
                      isExpanded: true,
                      text: 'Simpan Draf',
                      onPressed: () {
                        controller.createNews(context);

                        // var html = controller.htmlController.document
                        //     .toDelta()
                        //     .toString();
                        // print(html);

                        // controller.htmlViewController.document =
                        //     Document.fromJson(html);
                      },
                    ),
                    Gap(getHeightScale(10)),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 3,
                child: Container(
                  padding: theme.style.padding.allMedium.copyWith(top: 0),
                  height: getHeightScale(1.2),
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Daftar Berita',
                                    style: theme.font.f18.semibold),
                                GestureDetector(child: Container())
                              ],
                            ),
                            Gap(12.h),
                            AppForm(
                              controller: controller.searchController,
                              hintText: 'Cari berita',
                              onChanged: (value) =>
                                  controller.searchNews(value),
                            ),
                            Gap(12.h),
                          ],
                        ),
                      ),
                      PagedSliverList.separated(
                          pagingController: controller.pagingController,
                          builderDelegate: PagedChildBuilderDelegate<NewsModel>(
                            itemBuilder: (context, item, index) {
                              return ItemNews(
                                data: item,
                                publish: () {},
                                onEdit: () {},
                                onDelete: () => controller.confirmationDelete(
                                    context, item.id ?? 0),
                                toDetail: () => Get.toNamed(Routes.DETAIL_NEWS,
                                    arguments: item.id),
                              );
                            },
                            newPageProgressIndicatorBuilder:
                                InfinitiPage.progress,
                            firstPageProgressIndicatorBuilder:
                                InfinitiPage.progress,
                            noItemsFoundIndicatorBuilder: (_) =>
                                InfinitiPage.empty(_, 'Berita'),
                            firstPageErrorIndicatorBuilder: (_) {
                              return Center(
                                child: Text(controller.pagingController.error
                                    .toString()),
                              );
                            },
                          ),
                          separatorBuilder: (_, i) => Gap(12.h)),
                    ],
                  ),
                ))
          ],
        ),
      );
    });
  }
}
