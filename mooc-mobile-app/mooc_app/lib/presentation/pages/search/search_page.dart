import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mooc_app/presentation/controllers/category/category_controller.dart';
import 'package:mooc_app/presentation/controllers/course_list/course_list_controller.dart';
import '../../controllers/text_main_controller.dart';
import '../../widgets/course_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../widgets/list_category.dart';

class SearchPage extends StatelessWidget {
  // static String routeName = "/search";
  const SearchPage({super.key});
  @override
  Widget build(BuildContext context) {
    final cate = Get.find<CategoryController>();
    final course = Get.find<CourseListController>();
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    double paddingbottom = MediaQuery.of(context).padding.bottom;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    final text = Get.put(TextMainController());
    // List<int> items = List.generate(
    //       cate.categoryResponse.value?.items.length ?? 0, (i) => i);
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              automaticallyImplyLeading: false,
              middle: CupertinoSearchTextField(
                placeholder: AppLocalizations.of(context)!.search,
                autofocus: false,
                autocorrect: true,
                onSuffixTap: () {
                  text.searchpagefield.text = "";
                  FocusManager.instance.primaryFocus?.unfocus();
                  course.fetchkwData(text.searchpagefield.text);
                },
                onChanged: (value) {
                  if (value == "") {
                    text.searchpagefield.text = "";
                    course.fetchkwData(text.searchpagefield.text);
                  }
                },
                controller: text.searchpagefield,
                onSubmitted: (String value) {
                  course.fetchkwData(value);
                },
              ),
            ),
            child: Obx(() => text.searchpagefield.text != ""
                ? course.isLoading.value == true
                    ? Container(
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : (course.courseskwData.value.length != null &&
                            course.courseskwData.value.isNotEmpty)
                        ? Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              child: GridView.count(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16.0,
                                mainAxisSpacing: 16.0,
                                shrinkWrap: true,
                                childAspectRatio: widthScreen / 500.0,
                                children: List.generate(
                                    course.courseskwData.value.length,
                                    (index) => Center(
                                          child: CourseItem(
                                            widthItem: widthScreen / 2,
                                            courseItem: course
                                                .courseskwData.value[index],
                                          ),
                                        )),
                              ),
                            ))
                        //   );
                        : Padding(
                            padding: EdgeInsets.only(
                                top: const CupertinoNavigationBar()
                                        .preferredSize
                                        .height +
                                    statusBarHeight +
                                    10),
                            child: SingleChildScrollView(
                                physics: const ClampingScrollPhysics(),
                                child: Column(children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 20.0, left: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            AppLocalizations.of(context)!
                                                .noCourse,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                  ),
                                ])))
                : Padding(
                    padding: EdgeInsets.only(
                        top: const CupertinoNavigationBar()
                                .preferredSize
                                .height +
                            statusBarHeight +
                            10,
                        bottom: paddingbottom + 10),
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            margin:
                                const EdgeInsets.only(bottom: 20.0, left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    AppLocalizations.of(context)!
                                        .categoryCourse,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                          ListCategory(
                            length: cate.categoryResponse.value?.items?.length,
                            cate: cate.categoryResponse.value?.items,
                          )
                        ],
                      ),
                    )))));
  }
}
