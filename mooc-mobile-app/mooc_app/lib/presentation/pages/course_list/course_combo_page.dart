import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/app/config/app_common.dart';
import 'package:mooc_app/presentation/controllers/course_list/course_combo_controller.dart';
import 'package:mooc_app/presentation/controllers/text_main_controller.dart';
import 'package:mooc_app/presentation/widgets/circular_loading_indicator.dart';
import 'package:mooc_app/presentation/widgets/course_combo_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CourseComboPage extends StatelessWidget {
  CourseComboPage({
    Key? key,
    required this.navigationBarTitle,
    required this.category,
  }) : super(key: key);

  final String navigationBarTitle;
  final String category;
  final courseComboController = Get.find<CourseComboController>();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    final text = Get.put(TextMainController());

    return WillPopScope(
      onWillPop: onWillPop,
      child: GetX(
      init: courseComboController,
      initState: (state) {
        courseComboController.fetchData();
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
            child: CupertinoPageScaffold(
                resizeToAvoidBottomInset: false,
                navigationBar: CupertinoNavigationBar(
                  middle: Text(AppLocalizations.of(context)!.courseCombo),
                ),
                child: courseComboController.isLoading.value
                    ? Container(
                        color: Colors.white,
                        child: const Center(
                          child: CircularLoadingIndicator(),
                        ),
                      )
                    : courseComboController.coursesData.isNotEmpty
                        ? Container(
                            margin: EdgeInsets.only(top: (statusBarHeight + const CupertinoNavigationBar().preferredSize.height)),
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            height: heightScreen,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: CupertinoSearchTextField(
                                  placeholder: AppLocalizations.of(context)!.search,
                                  autofocus: false,
                                  autocorrect: true,
                                  itemSize: 40,
                                  onSuffixTap: () {
                                    text.searchpagefield.text = "";
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    courseComboController.fetchSearchData(text.searchpagefield.text);
                                  },
                                  onChanged: (value) {
                                    if (value == "") {
                                        text.searchpagefield.text = "";
                                        courseComboController.fetchSearchData(text.searchpagefield.text);
                                      }
                                    },
                                    controller: text.searchpagefield,
                                    onSubmitted: (String value) {
                                      courseComboController.fetchSearchData(value);
                                    },
                                  ),
                                ),
                                  Expanded(
                                    child: GridView.count(
                                      controller: scrollController,
                                      crossAxisCount: 1,
                                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                                      crossAxisSpacing: 16.0,
                                      mainAxisSpacing: 16.0,
                                      shrinkWrap: true,
                                      childAspectRatio: widthScreen / 100.0,
                                      physics:const AlwaysScrollableScrollPhysics(),
                                      children: List.generate(courseComboController.coursesData.length,
                                          (index) => Center(
                                                child: CourseComboItem(
                                                  widthItem: widthScreen,
                                                  courseItem: courseComboController.coursesData[index],
                                                  showDiscount: true,
                                                ),
                                              )),
                                    ),
                                  )
                                ],
                              ))
                          : Container(
                              padding: EdgeInsets.only(top: (statusBarHeight + const CupertinoNavigationBar().preferredSize.height)),
                              child:  Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: CupertinoSearchTextField(
                                      placeholder: AppLocalizations.of(context)!.search,
                                      autofocus: false,
                                      autocorrect: true,
                                      itemSize: 40,
                                      onSuffixTap: () {
                                        text.searchpagefield.text = "";
                                        FocusManager.instance.primaryFocus?.unfocus();
                                        courseComboController.fetchSearchData(text.searchpagefield.text);
                                      },
                                      onChanged: (value) {
                                        if (value == "") {
                                          text.searchpagefield.text = "";
                                          courseComboController.fetchSearchData(text.searchpagefield.text);
                                        }
                                      },
                                      controller: text.searchpagefield,
                                      onSubmitted: (String value) {
                                        courseComboController.fetchSearchData(value);
                                        },
                                    ),
                                  ),
                                  Expanded(child: Text(AppLocalizations.of(context)!.noCourse,
                                      style: const TextStyle(color: Colors.black54)
                                      ))
                                ],)
                              )));
        },
      ), 
    );
  }

  Future<bool> onWillPop() async {
    reloadHomeWhenBackFromOther();
    return true;
  }

  void scrollListener() {
    if (scrollController.position.extentAfter < 500) {
      courseComboController.loadMore();
    }
  }
}
