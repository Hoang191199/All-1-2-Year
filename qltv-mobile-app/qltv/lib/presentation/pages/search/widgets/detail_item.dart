import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/app/config/app_constants.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/domain/entities/publication.dart';
import 'package:qltv/domain/entities/search.dart';
import 'package:qltv/presentation/controllers/home/home_controller.dart';
import 'package:qltv/presentation/controllers/search/search_controller.dart'
    as search;
import 'package:qltv/presentation/pages/search/widgets/button_add_book.dart';
import 'package:qltv/presentation/pages/search/widgets/info_archives_detail_item.dart';
import 'package:qltv/presentation/pages/search/widgets/info_bookcase_detail_item.dart';
import 'package:qltv/presentation/pages/search/widgets/rating_detail_item.dart';
import 'package:qltv/presentation/pages/search/widgets/search_image.dart';

// ignore: must_be_immutable
class DetailItem extends StatelessWidget {
  DetailItem({
    super.key,
    this.itemDetail,
    this.publicationDetail,
  });

  Search? itemDetail;
  Publication? publicationDetail;

  final searchController = Get.find<search.SearchController>();
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    return GetX(
        init: itemDetail == null ? homeController : searchController,
        initState: (state) {
          if (itemDetail == null) {
            homeController.fetchPublicationDetail(publicationDetail?.id ?? 0);
          }
        },
        builder: (_) {
          return homeController.isLoadingDetail.value
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/background.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Scaffold(
                  backgroundColor: AppColors.background,
                  resizeToAvoidBottomInset: false,
                  body: Container(
                    padding: EdgeInsets.only(
                        top: statusBarHeight + 25.0,
                        bottom: bottomPadding + 20),
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/background.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: (SizedBox(
                        width: widthScreen - 28.0 - 28.0,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 14.0, left: 28.0, right: 28.0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SearchImage(
                                            widthImage: 150.0,
                                            heightImage: 200.0,
                                            isShowDigital: false,
                                            isShowInfo: true,
                                            imageUrl: itemDetail != null
                                                ? (itemDetail?.image_url ??
                                                    itemDetail?.image)
                                                : homeController
                                                    .responseDetail
                                                    .value
                                                    ?.data
                                                    ?.metadata
                                                    ?.image_url,
                                          ),
                                        ]),
                                  ),
                                  Positioned(
                                    left: 14,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.chevron_left_sharp,
                                        size: 34,
                                        color: Color(0xFF7B858B),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 28.0, right: 28.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          itemDetail != null
                                              ? (itemDetail?.authors ?? '')
                                              : (homeController.responseDetail
                                                      .value?.data?.authors ??
                                                  ''),
                                          style: GoogleFonts.kantumruy(
                                              textStyle: TextStyle(
                                                  fontSize: 14,
                                                  height: 1.6,
                                                  fontWeight: FontWeight.w400,
                                                  color: HexColor('333333'))),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          itemDetail != null
                                              ? '${itemDetail?.title}'
                                              : '${homeController.responseDetail.value?.data?.title}',
                                          style: GoogleFonts.kantumruy(
                                              textStyle: TextStyle(
                                                  fontSize: 16,
                                                  height: 1.6,
                                                  fontWeight: FontWeight.w700,
                                                  color: HexColor('333333'))),
                                        ),
                                        const SizedBox(height: 32),
                                        itemDetail != null
                                            ? RatingWidget(
                                                itemDetail: itemDetail)
                                            : RatingWidget(
                                                publicationDetail:
                                                    homeController
                                                        .responseDetail
                                                        .value
                                                        ?.data),
                                        const SizedBox(height: 24),
                                        searchController.searchType.value !=
                                                BookcaseType.document
                                            ? (itemDetail != null
                                                ? InfoBookcaseWidget(
                                                    itemDetail: itemDetail)
                                                : InfoBookcaseWidget(
                                                    publicationDetail:
                                                        homeController
                                                            .responseDetail
                                                            .value
                                                            ?.data))
                                            : InfoArchivesWidget(
                                                itemDetail: itemDetail)
                                      ]),
                                ),
                              ),
                              searchController.searchType.value !=
                                          BookcaseType.document ||
                                      homeController.responseDetail.value?.data
                                              ?.type !=
                                          BookcaseType.document
                                  ? Container(
                                      height: 60,
                                      margin: const EdgeInsets.only(
                                          left: 28.0, right: 28.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color.fromARGB(
                                                    100, 232, 239, 243)
                                                .withOpacity(0.7),
                                            spreadRadius: 10,
                                            blurRadius: 4,
                                            offset: const Offset(0, -10),
                                          ),
                                        ],
                                      ),
                                      child: ButtonAddBook(
                                          type: itemDetail != null
                                              ? itemDetail?.object_type
                                              : homeController.responseDetail
                                                  .value?.data?.type,
                                          idItem: itemDetail != null
                                              ? (itemDetail?.id ?? 0)
                                              : (homeController.responseDetail
                                                      .value?.data?.id ??
                                                  0),
                                          remain: itemDetail != null
                                              ? (itemDetail?.remain ?? 0)
                                              : (homeController.responseDetail
                                                      .value?.data?.remain ??
                                                  0)))
                                  : const SizedBox()
                            ]))),
                  ),
                );
        });
  }
}
