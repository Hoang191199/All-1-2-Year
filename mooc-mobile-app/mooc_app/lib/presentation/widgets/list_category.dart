import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/category.dart';
import '../controllers/course_list/course_list_binding.dart';
import '../pages/course_list/course_list_page.dart';

class ListCategory extends StatelessWidget {
  const ListCategory({super.key, this.length, this.cate});

  final int? length;
  final List<Category>? cate;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(top: 0),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: length ?? 0,
      itemBuilder: (context, index) {
        return GestureDetector(
            onLongPress: () {
              if (cate?[index].children!.isNotEmpty ?? false) {
                List<int> items =
                    List.generate(cate?[index].children!.length ?? 0, (i) => i);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                        title: const Text('Chọn danh mục con'),
                        children: [
                          for (var i in items)
                            SimpleDialogOption(
                                child:
                                    Text('${cate?[index].children?[i].label}'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  CourseListBinding().dependencies();
                                  Get.to(() => CourseListPage(
                                        navigationBarTitle:
                                            '${cate?[index].children?[i].label}',
                                        category:
                                            '${cate?[index].children?[i].key}',
                                        keyword: '',
                                      ));
                                })
                        ]);
                  },
                );
              }
            },
            onTap: () {
              CourseListBinding().dependencies();
              Get.to(() => CourseListPage(
                    navigationBarTitle: '${cate?[index].label}',
                    category: '${cate?[index].key}',
                    keyword: '',
                  ));
            },
            child: CupertinoButton(
              pressedOpacity: 0.65,
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: SizedBox(
                            height: 28,
                            width: 28,
                            child: Icon(
                              CupertinoIcons.paperclip,
                              color: Colors.black,
                            )),
                      ),
                      Text(
                        "${cate?[index].label}",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  // const Icon(
                  //   CupertinoIcons.chevron_right,
                  //   color: Colors.grey,
                  // ),
                ],
              ),
              onPressed: () {
                CourseListBinding().dependencies();
                Get.to(() => CourseListPage(
                      navigationBarTitle: '${cate?[index].label}',
                      category: '${cate?[index].key}',
                      keyword: '',
                    ));
              },
            )
            // )
            );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          thickness: 0.5,
        );
      },
    );
  }
}
