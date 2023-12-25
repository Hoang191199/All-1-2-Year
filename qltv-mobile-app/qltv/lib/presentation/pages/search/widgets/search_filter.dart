import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/config/app_constants.dart';
import 'package:qltv/presentation/controllers/search/search_controller.dart'
    as search;
import 'package:qltv/presentation/pages/search/widgets/search_focus_label_item.dart';

// ignore: must_be_immutable
class SearchFilter extends StatelessWidget {
  SearchFilter({
    super.key,
  });

  final searchController = Get.find<search.SearchController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // homeController.changeIndexModelFocus(index);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CupertinoSearchTextField(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
              placeholder:
                  searchController.searchType.value == BookcaseType.publications
                      ? 'search-in-publication'.tr
                      : 'search-in-document'.tr,
              placeholderStyle: GoogleFonts.kantumruy(
                  textStyle: const TextStyle(
                      color: Color(0xFF7B858B),
                      fontSize: 14,
                      fontWeight: FontWeight.w400)),
              autofocus: false,
              autocorrect: true,
              itemSize: 20,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white),
              onSuffixTap: () {
                searchController.searchInputController.text = "";
                FocusManager.instance.primaryFocus?.unfocus();
                if (searchController.searchInputController.text != '') {
                  if(searchController.labelFocus.value == 'title'){
                    searchController.fetchData('title');
                  }else{
                    searchController.fetchData(searchController.labelFocus.value);
                  }  
                } else {
                  searchController.fetchData('');
                }
              },
              controller: searchController.searchInputController,
              onSubmitted: (String value) {
                if (searchController.searchInputController.text != '') {
                  if(searchController.labelFocus.value == 'title'){
                    searchController.fetchData('title');
                  }else{
                    searchController.fetchData(searchController.labelFocus.value);
                  }
                } else {
                  searchController.fetchData('');
                }
              },
            ),
            searchController.searchInputController.text != ''
                ? const SizedBox(height: 14)
                : const SizedBox(),
            searchController.searchInputController.text != ''
                ? SizedBox(
                    height: 30.0,
                    child: ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 4.0),
                        scrollDirection: Axis.horizontal,
                        itemCount: searchController.searchType.value ==
                                BookcaseType.publications
                            ? labelDigitalPublicationsItem.length
                            : labelDocumentItem.length,
                        itemBuilder: (context, index) => SearchFocusLabelItem(
                              index: index,
                              name: searchController.searchType.value ==
                                      BookcaseType.publications
                                  ? labelDigitalPublicationsItem[index]
                                  : labelDocumentItem[index],
                            )),
                  )
                : const SizedBox()
          ],
        ));
  }

  List<String> labelDigitalPublicationsItem = [
    'title'.tr,
    'topic'.tr,
    'author'.tr,
    'type-publications'.tr,
    'subject'.tr,
    'publishing-company'.tr,
    'ISBN'
  ];
  List<String> labelDocumentItem = [
    'title'.tr,
    'topic'.tr,
    'author'.tr,
  ];
}
