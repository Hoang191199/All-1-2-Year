import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:mooc_app/app/config/app_common.dart';
import 'package:mooc_app/domain/entities/lesson.dart';
import 'package:mooc_app/presentation/controllers/course_lesson/course_lesson_controller.dart';

class CourseLessonHtml extends StatefulWidget {
  const CourseLessonHtml({
    super.key,
    required this.idCourse,
    required this.isRegisted,
    required this.lessonItem,
  });

  final int idCourse;
  final bool isRegisted;
  final Lesson? lessonItem;

  @override
  State<CourseLessonHtml> createState() => _CourseLessonHtmlState();
}

class _CourseLessonHtmlState extends State<CourseLessonHtml> {

  final courseLessonController = Get.find<CourseLessonController>();

  @override
  void dispose() async {
    super.dispose();

    if (widget.isRegisted) {
      await courseLessonController.completeLesson(widget.lessonItem?.id ?? 0, widget.idCourse, 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.lessonItem?.label ?? ''),
        trailing: GestureDetector(
          onTap: () {
            handlePressMenuLesson(context, widget.lessonItem?.documentFiles ?? []);
          },
          child: const Icon(CupertinoIcons.bars, size: 24.0, color: Colors.black),
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(top: (statusBarHeight + const CupertinoNavigationBar().preferredSize.height)),
        child: Html(
          data: widget.lessonItem?.data,
          style: {
            "body": Style(fontSize: FontSize(15.0)),
            "p": Style(fontSize: FontSize(15.0)),
            "span": Style(fontSize: FontSize(15.0)),
          },
        ),
      )
    );
  }
}