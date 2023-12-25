import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/app/config/app_constants.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/presentation/controllers/search/search_controller.dart'
    as search;

class SearchTypeItem extends StatelessWidget {
  SearchTypeItem({
    super.key,
    required this.searchType,
    required this.widthItem,
  });

  final String searchType;
  final double widthItem;

  final searchController = Get.find<search.SearchController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          searchController.changeSearchType(searchType);
        },
        child: Container(
          width: widthItem,
          padding: const EdgeInsets.all(3.0),
          child: Obx(() => Container(
                decoration: searchController.searchType.value == searchType
                    ? BoxDecoration(
                        color: HexColor('D9E9F2'),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7.0)),
                      )
                    : null,
                child: Center(
                  child: Text(
                      searchType == BookcaseType.publications
                          ? ('publication-store'.tr)
                          : ('document-store'.tr),
                      style: GoogleFonts.kantumruy(
                          textStyle: TextStyle(
                              fontSize: 14.0,
                              fontWeight: searchController.searchType.value ==
                                      searchType
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                              color: AppColors.primaryBlue))),
                ),
              )),
        ));
  }
}
