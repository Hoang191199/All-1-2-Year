import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/app/config/app_constants.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/presentation/controllers/bookcase/bookcase_controller.dart';
import 'package:qltv/presentation/pages/bookcase/widgets/bookcase_lastseen.dart';
import 'package:qltv/presentation/pages/bookcase/widgets/bookcase_search_sort_filter.dart';
import 'package:qltv/presentation/pages/bookcase/widgets/bookcase_type_item.dart';
import 'package:qltv/presentation/pages/bookcase/widgets/bookcase_view.dart';
import 'package:qltv/presentation/pages/bookcase/widgets/no_bookcase_data.dart';
import 'package:qltv/presentation/widgets/circular_loading_indicator.dart';
import 'package:qltv/presentation/widgets/search_no_data.dart';

class BookcasePage extends StatelessWidget {
  BookcasePage({super.key});

  final bookcaseController = Get.find<BookcaseController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    return GetX(
      init: bookcaseController,
      initState: (state) async {},
      builder: (_) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            backgroundColor: AppColors.background,
            resizeToAvoidBottomInset: false,
            body: Container(
              padding: EdgeInsets.only(top: statusBarHeight + 25.0, bottom: kBottomNavigationBarHeight + bottomPadding),
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'bookcase'.tr,
                      style: GoogleFonts.kantumruy(
                        textStyle: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: Colors.black)
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 14.0, left: 28.0, right: 28.0),
                    width: widthScreen - 28.0 - 28.0,
                    height: 36.0,
                    decoration: BoxDecoration(
                      color: HexColor('FFFDFD'),
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BookcaseTypeItem(bookcaseType: BookcaseType.digital_publications, widthItem: (widthScreen - 28.0 - 28.0) / 2),
                        BookcaseTypeItem(bookcaseType: BookcaseType.document, widthItem: (widthScreen - 28.0 - 28.0) / 2),
                      ],
                    ),
                  ),
                  Expanded(
                    child: bookcaseController.isLoading.value || bookcaseController.isLoadingLastseen.value
                    ? SizedBox(
                      height: heightScreen - statusBarHeight - 25.0 - 33.0 - 14.0 - 36.0 - kBottomNavigationBarHeight - bottomPadding,
                      child: const Center(
                        child: CircularLoadingIndicator(),
                      ),
                    )
                    : bookcaseController.bookcaseFilterType.length == 3
                      ? bookcaseController.bookcasesData.isEmpty
                        ? bookcaseController.searchInputController.text.isEmpty
                          ? const SearchNoData()
                          : Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 10.0, left: 28.0, right: 28.0, bottom: 10.0),
                                child: BookcaseSearchSortFilter(),
                              ),
                              const Expanded(
                                child: SingleChildScrollView(
                                  child: NoBookcaseData(),
                                )
                              )
                            ],
                          )
                        : Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 10.0, left: 28.0, right: 28.0, bottom: 10.0),
                              child: BookcaseSearchSortFilter(),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 28.0),
                              child: BookcaseLastseen(),
                            ),
                            Expanded(
                              child: BookcaseView(),
                            )
                          ],
                        )
                      : Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10.0, left: 28.0, right: 28.0, bottom: 10.0),
                            child: BookcaseSearchSortFilter(),
                          ),
                          bookcaseController.bookcaseFilterType.length == 1 && bookcaseController.bookcaseFilterType[0] == BookcaseFilterType.notRead
                            ? Container()
                            : Container(
                              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 28.0),
                              child: BookcaseLastseen(),
                            ),
                          bookcaseController.bookcasesData.isEmpty
                            ? const SearchNoData()
                            : Expanded(
                              child: BookcaseView(),
                            )
                        ],
                        ),
                      )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}