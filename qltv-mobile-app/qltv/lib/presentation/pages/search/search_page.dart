import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/app/config/app_constants.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/presentation/controllers/search/search_controller.dart'
    as search;
import 'package:qltv/presentation/pages/search/widgets/data_null.dart';
import 'package:qltv/presentation/pages/search/widgets/search_filter.dart';
import 'package:qltv/presentation/pages/search/widgets/search_list_view_item.dart';
import 'package:qltv/presentation/pages/search/widgets/search_type_item.dart';
import 'package:qltv/presentation/pages/search/widgets/search_grid_view_item.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final searchController = Get.find<search.SearchController>();
   ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    void scrollListener() {
      if (scrollController.position.extentAfter < 200) {
        searchController.loadMore();
      }
    }

    return GetX(
        init: searchController,
        initState: (state) async {
          searchController.fetchData('');
          scrollController.addListener(scrollListener);
        },
        didUpdateWidget: (old, newState) {
          scrollController.addListener(scrollListener);
        },
        dispose: (state) {
          scrollController.removeListener(scrollListener);
        },
        builder: (_) {
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              backgroundColor: AppColors.background,
              resizeToAvoidBottomInset: false,
              body: Container(
                padding: EdgeInsets.only(top: statusBarHeight + 25.0),
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/background.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: searchController.isLoading.value
                    ? Container(
                        width: widthScreen - 28.0 - 28.0,
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
                    : Container(
                        margin: const EdgeInsets.only(left: 28.0, right: 28.0),
                        width: widthScreen - 28.0 - 28.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                "search".tr,
                                style: GoogleFonts.kantumruy(
                                    textStyle: const TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black)),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              height: 36.0,
                              decoration: BoxDecoration(
                                color: HexColor('FFFDFD'),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SearchTypeItem(
                                      searchType: BookcaseType.publications,
                                      widthItem:
                                          (widthScreen - 28.0 - 28.0) / 2),
                                  SearchTypeItem(
                                      searchType: BookcaseType.document,
                                      widthItem:
                                          (widthScreen - 28.0 - 28.0) / 2),
                                ],
                              ),
                            ),
                            const SizedBox(height: 14),
                            (searchController.searchData.isEmpty &&
                                    (searchController
                                            .searchInputController.text ==
                                        ""))
                                ? Expanded(
                                    child: SingleChildScrollView(
                                    physics: const ClampingScrollPhysics(),
                                    child: SearchDataNull(
                                        title: "search-no-data".tr),
                                  ))
                                : Expanded(
                                    child: Column(
                                      children: [
                                        (searchController.searchData.isEmpty &&
                                                (searchController
                                                        .searchInputController
                                                        .text ==
                                                    ""))
                                            ? const SizedBox()
                                            : SearchFilter(),
                                        (searchController.searchData.isEmpty &&
                                                (searchController
                                                        .searchInputController
                                                        .text ==
                                                    ""))
                                            ? const SizedBox()
                                            : const SizedBox(height: 14),
                                        (searchController.searchData.isNotEmpty)
                                            ? Expanded(
                                                child: searchController
                                                            .searchInputController
                                                            .text ==
                                                        ''
                                                    ? GridView.count(
                                                        controller:
                                                            scrollController,
                                                        crossAxisCount: 3,
                                                        padding: EdgeInsets.only(
                                                            top: 20.0,
                                                            bottom: bottomPadding +
                                                                50.0),
                                                        mainAxisSpacing: 10.0,
                                                        shrinkWrap: true,
                                                        childAspectRatio: (widthScreen - 56) /
                                                            (heightScreen -
                                                                66 -
                                                                kBottomNavigationBarHeight -
                                                                statusBarHeight -
                                                                bottomPadding),
                                                        physics:
                                                            const AlwaysScrollableScrollPhysics(),
                                                        children: List.generate(
                                                            searchController
                                                                .searchData
                                                                .length,
                                                            (index) => Center(
                                                                  child: SearchGridViewItem(
                                                                      item: searchController
                                                                              .searchData[
                                                                          index]),
                                                                )))
                                                    : ListView.separated(
                                                        physics:
                                                            const ClampingScrollPhysics(),
                                                        padding: EdgeInsets.only(
                                                            left: 10.0,
                                                            right: 10.0,
                                                            bottom:
                                                                bottomPadding +
                                                                    60.0),
                                                        itemCount: searchController.searchData.length,
                                                        controller: scrollController,
                                                        separatorBuilder: (context, index) => const SizedBox(height: 10.0),
                                                        itemBuilder: (context, index) => SearchListViewItem(item: searchController.searchData[index])))
                                            : Expanded(
                                                child: SingleChildScrollView(
                                                physics:
                                                    const ClampingScrollPhysics(),
                                                child: SearchDataNull(
                                                    title: "search-no-data".tr),
                                              )),
                                        searchController.isLoadMore == true
                                            ? const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 35.0),
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : const SizedBox()
                                      ],
                                    ),
                                  )
                          ],
                        ),
                      ),
              ),
            ),
          );
        });
  }
}
