import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/domain/entities/course.dart';
import 'package:mooc_app/presentation/controllers/course_list/course_list_binding.dart';
import 'package:mooc_app/presentation/pages/course_list/course_list_page.dart';
import 'package:mooc_app/presentation/widgets/course_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CourseHomeList extends StatelessWidget {
  const CourseHomeList({
    super.key,
    required this.title,
    // this.collectionHomeItem,
    required this.coursesRecommend,
  });

  final String title;
  // final Collection? collectionHomeItem;
  final List<Course> coursesRecommend;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 36.0),
        padding: const EdgeInsets.only(left: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  GestureDetector(
                    onTap: () {
                      CourseListBinding().dependencies();
                      Get.to(() => CourseListPage(
                            navigationBarTitle: title,
                            category: '',
                            keyword: '',
                          ));
                    },
                    child: Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(AppLocalizations.of(context)!.show_more,
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.grey[600])),
                            const SizedBox(width: 2.0),
                            const Icon(
                              CupertinoIcons.forward,
                              size: 16.0,
                              color: Colors.black87,
                            )
                          ],
                        )),
                  )
                ],
              ),
            ),
            SizedBox(
                height: 230.0,
                child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 14.0),
                    padding: const EdgeInsets.only(right: 10.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: coursesRecommend.length,
                    itemBuilder: (context, index) =>
                        CourseItem(courseItem: coursesRecommend[index])))
          ],
        ));
  }
}
