import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/app/config/app_constants.dart';
import 'package:mooc_app/presentation/controllers/active_course/active_course_binding.dart';
import 'package:mooc_app/presentation/controllers/course_list/course_combo_binding.dart';
import 'package:mooc_app/presentation/controllers/course_list/course_list_binding.dart';
import 'package:mooc_app/presentation/pages/active_course/active_course_page.dart';
import 'package:mooc_app/presentation/pages/course_list/course_combo_page.dart';
import 'package:mooc_app/presentation/pages/course_list/course_list_page.dart';

class FeatureItem extends StatelessWidget {
  const FeatureItem(
      {super.key,
      required this.icon,
      required this.title,
      required this.type,
      required this.color});

  final Icon icon;
  final String title;
  final String type;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (type == Feature.featureActive) {
            ActiveCourseBinding().dependencies();
            Get.to(() => ActiveCoursePage());
          } else if (type == Feature.featureCombo) {
            CourseComboBinding().dependencies();
            Get.to(() => CourseComboPage(
                  navigationBarTitle: title,
                  category: type,
                ));
          } else {
            CourseListBinding().dependencies();
            Get.to(() => CourseListPage(
                  navigationBarTitle: title,
                  category: type,
                  keyword: '',
                ));
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.all(Radius.circular(16.0))),
              child: icon,
            ),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: Text(title,
                  style: const TextStyle(fontSize: 15.0, color: Colors.black)),
            )
          ],
        ));
  }
}
