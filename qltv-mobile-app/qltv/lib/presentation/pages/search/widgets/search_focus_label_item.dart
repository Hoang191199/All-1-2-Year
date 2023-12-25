import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/presentation/controllers/search/search_controller.dart'
    as search;

class SearchFocusLabelItem extends StatelessWidget {
  SearchFocusLabelItem({
    super.key,
    required this.index,
    required this.name,
  });

  final int index;
  final String name;

  final searchController = Get.find<search.SearchController>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        searchController.changeIndexLabelFocus(index);
        changeLabelFocus(index);
      },
      child: Obx(() => Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: searchController.indexLabelFocus.value == index
                      ? HexColor('004390')
                      : Colors.black.withOpacity(0),
                  width: 3.0, // Adjust the width as needed
                ),
              ),
            ),
            child: Center(
              child: Text(name,
                  style: GoogleFonts.kantumruy(
                      textStyle: TextStyle(
                          fontSize: 14.0,
                          height: 1.4,
                          fontWeight: FontWeight.w400,
                          color: searchController.indexLabelFocus.value == index
                              ? AppColors.primaryBlue
                              : HexColor('7B858B')))),
            ),
          )),
    );
  }

  changeLabelFocus(int index) {
    switch (index) {
      case 0:
        return searchController.labelFocus.value = "title";
      case 1:
        return searchController.labelFocus.value = "chude";
      case 2:
        return searchController.labelFocus.value = "author";
      case 3:
        return searchController.labelFocus.value = "model";
      case 4:
        return searchController.labelFocus.value = "subject";
      case 5:
        return searchController.labelFocus.value = "publication_year";
      case 6:
        return searchController.labelFocus.value = "isbn";
      default:
        return searchController.labelFocus.value = "title";
    }
  }
}
