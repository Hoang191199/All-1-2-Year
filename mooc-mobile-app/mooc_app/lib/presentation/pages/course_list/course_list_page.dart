import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/app/config/app_common.dart';
import 'package:mooc_app/presentation/controllers/course_list/course_list_controller.dart';
import 'package:mooc_app/presentation/widgets/circular_loading_indicator.dart';
import 'package:mooc_app/presentation/widgets/course_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CourseListPage extends StatelessWidget {
  CourseListPage({
    Key? key,
    required this.navigationBarTitle,
    required this.category,
    required this.keyword,
  }) : super(key: key);

  final String navigationBarTitle;
  final String category;
  final String keyword;

  final courseListController = Get.find<CourseListController>();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    print({'keyword', keyword});

    return WillPopScope(
      onWillPop: onWillPop,
      child: GetX(
        init: courseListController,
        initState: (state) {
          if (keyword != '') {
            courseListController.fetchkwData(keyword);
          } else {
            courseListController.fetchData(category);
          }
          scrollController.addListener(scrollListener);
        },
        didUpdateWidget: (old, newState) {
          scrollController.addListener(scrollListener);
        },
        dispose: (state) {
          scrollController.removeListener(scrollListener);
        },
        builder: (_) {
          return keyword != ''
              ? CupertinoPageScaffold(
                  navigationBar: CupertinoNavigationBar(
                    middle: Text(navigationBarTitle),
                  ),
                  child: courseListController.isLoading.value
                      ? Container(
                          color: Colors.white,
                          child: const Center(
                            child: CircularLoadingIndicator(),
                          ),
                        )
                      : courseListController.courseskwData.isNotEmpty
                          ? Container(
                              padding: const EdgeInsets.all(10.0),
                              height: heightScreen,
                              child: GridView.count(
                                controller: scrollController,
                                crossAxisCount: 2,
                                crossAxisSpacing: 16.0,
                                mainAxisSpacing: 16.0,
                                shrinkWrap: true,
                                childAspectRatio: widthScreen / 500.0,
                                physics: const AlwaysScrollableScrollPhysics(),
                                children: List.generate(
                                    courseListController.courseskwData.length,
                                    (index) => Center(
                                          child: CourseItem(
                                            widthItem: widthScreen / 2,
                                            courseItem: courseListController
                                                .courseskwData[index],
                                            showDiscount: true,
                                          ),
                                        )),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.only(
                                  top: (statusBarHeight +
                                      const CupertinoNavigationBar()
                                          .preferredSize
                                          .height)),
                              child: Center(
                                child: Text(
                                    AppLocalizations.of(context)!.noCourse,
                                    style:
                                        const TextStyle(color: Colors.black54)),
                              )))
              : CupertinoPageScaffold(
                  navigationBar: CupertinoNavigationBar(
                    middle: Text(navigationBarTitle),
                  ),
                  child: courseListController.isLoading.value
                      ? Container(
                          color: Colors.white,
                          child: const Center(
                            child: CircularLoadingIndicator(),
                          ),
                        )
                      : courseListController.coursesData.isNotEmpty
                          ? Container(
                              padding: EdgeInsets.only(
                                  top: (statusBarHeight +
                                      const CupertinoNavigationBar()
                                          .preferredSize
                                          .height),
                                  left: 10.0,
                                  right: 10.0),
                              height: heightScreen,
                              child: GridView.count(
                                controller: scrollController,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                crossAxisCount: 2,
                                crossAxisSpacing: 16.0,
                                mainAxisSpacing: 16.0,
                                shrinkWrap: true,
                                childAspectRatio: widthScreen / 500.0,
                                physics: const AlwaysScrollableScrollPhysics(),
                                children: List.generate(
                                    courseListController.coursesData.length,
                                    (index) => Center(
                                          child: CourseItem(
                                            widthItem: widthScreen / 2,
                                            courseItem: courseListController
                                                .coursesData[index],
                                            showDiscount: true,
                                          ),
                                        )),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.only(
                                  top: (statusBarHeight +
                                      const CupertinoNavigationBar()
                                          .preferredSize
                                          .height)),
                              child: Center(
                                child: Text(
                                    AppLocalizations.of(context)!.noCourse,
                                    style:
                                        const TextStyle(color: Colors.black54)),
                              )));
        },
      ),
    );
  }

  Future<bool> onWillPop() async {
    reloadHomeWhenBackFromOther();
    return true;
  }

  Future<void> scrollListener() async {
    if (scrollController.position.extentAfter < 500) {
      await courseListController.loadMore(category);
    }
  }
}
