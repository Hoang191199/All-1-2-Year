import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/domain/entities/category.dart';
import 'package:mooc_app/presentation/controllers/course_list/course_list_binding.dart';
import 'package:mooc_app/presentation/pages/course_list/course_list_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryHomeList extends StatelessWidget {
  const CategoryHomeList({
    Key? key,
    required this.listCategory,
  }) : super(key: key);

  final List<Category> listCategory;

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        children: [
          Text(AppLocalizations.of(context)!.title_category_home,
              style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black)),
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: Text(AppLocalizations.of(context)!.title_category_home_2,
                style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
          ),
          GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 20.0,
            mainAxisSpacing: 20.0,
            shrinkWrap: true,
            childAspectRatio: widthScreen / (120.0 * 3),
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(
                listCategory.length,
                (index) => Center(
                        child: GestureDetector(
                      onLongPress: () {
                        if (listCategory[index].children!.isNotEmpty) {
                          List<int> items = List.generate(
                              listCategory[index].children!.length, (i) => i);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SimpleDialog(
                                  title: const Text('Chọn danh mục con'),
                                  children: [
                                    for (var i in items)
                                      SimpleDialogOption(
                                          child: Text(
                                              '${listCategory[index].children?[i].label}'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            CourseListBinding().dependencies();
                                            Get.to(() => CourseListPage(
                                                  navigationBarTitle:
                                                      '${listCategory[index].children?[i].label}',
                                                  category:
                                                      '${listCategory[index].children?[i].key}',
                                                  keyword: '',
                                                ));
                                          })
                                  ]);
                            },
                          );
                        }
                      },
                      onTap: () {
                        handlePressCategoryItem(index);
                      },
                      child: Container(
                        width: widthScreen / 3,
                        decoration: BoxDecoration(
                            color: Colors.grey[350],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(2.0))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(CupertinoIcons.book_fill,
                                color: Colors.black),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 10.0, top: 4.0, right: 10.0),
                              child: Text(listCategory[index].label,
                                  style: const TextStyle(
                                      fontSize: 12.0, color: Colors.black),
                                  textAlign: TextAlign.center),
                            )
                          ],
                        ),
                      ),
                    ))),
          ),
        ],
      ),
    );
  }

  void handlePressCategoryItem(int index) {
    CourseListBinding().dependencies();
    Get.to(() => CourseListPage(
          navigationBarTitle: listCategory[index].label,
          category: listCategory[index].key,
          keyword: '',
        ));
  }
}
