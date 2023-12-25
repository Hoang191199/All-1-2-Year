import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/app/config/app_colors.dart';
import 'package:mooc_app/domain/entities/lesson.dart';
import 'package:mooc_app/presentation/controllers/course_lesson/course_lesson_binding.dart';
import 'package:mooc_app/presentation/pages/course_detail/course_lesson_detail_page.dart';

class CourseLesson extends StatelessWidget {
  const CourseLesson({
    super.key,
    required this.isRegisted,
    required this.idCourse,
    this.listLesson,
  });

  final bool isRegisted;
  final int idCourse;
  final List<Lesson>? listLesson;

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.only(top: 10.0),
      itemCount: listLesson?.length ?? 0,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              width: widthScreen,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: index == 0 ? const BorderRadius.only(
                  topLeft: Radius.circular(6.0), topRight: Radius.circular(6.0)
                ) : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      listLesson?[index].label ?? '',
                      style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black)
                    ),
                  ),
                  listLesson?[index].children?.isNotEmpty ?? false
                    ? SizedBox(
                      width: 100.0,
                      child: Text(
                        '${listLesson?[index].children?.length} bài',
                        style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: Colors.black),
                        textAlign: TextAlign.end
                      ),
                    )
                    : const SizedBox(width: 80.0),
                ],
              ),
            ),
            listLesson?[index].children?.isNotEmpty ?? false
              ? ListView.separated(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                itemCount: listLesson?[index].children?.length ?? 0,
                shrinkWrap: true,
                separatorBuilder: (context, indexChild) => const Divider(color: Colors.black12, thickness: 1.0),
                itemBuilder: (context, indexChild) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            listLesson?[index].children?[indexChild].label ?? '', 
                            style: const TextStyle(fontSize: 14.0, color: Colors.black)
                          ),
                        ),
                        isRegisted 
                          ? learnButton(context, 'Vào học', listLesson?[index].children?[indexChild])
                          : listLesson?[index].children?[indexChild].isTrial ?? false
                            ? learnButton(context, 'Học thử', listLesson?[index].children?[indexChild])
                            : const SizedBox(width: 80.0),
                      ],
                    ),
                  ),
                ) 
              )
              : Container(),
          ],
        );
      },
    );
  }

  Widget learnButton(BuildContext context, String textButton, Lesson? lessonItem) {
    return GestureDetector( 
      onTap: () {
        handlePressLearn(context, lessonItem);
      },
      child: SizedBox(
        width: 80.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue,
                borderRadius: const BorderRadius.all(Radius.circular(50.0)),
              ),
              child: Text(textButton, style: const TextStyle(fontSize: 12.0, color: Colors.white), textAlign: TextAlign.end),
            )
          ],
        ),
      ) 
    );
  }
  
  Future<void> handlePressLearn(BuildContext context, Lesson? lessonItem) async {
    CourseLessonBinding().dependencies();
    Get.to(() => CourseLessonDetailPage(idCourse: idCourse, isRegisted: isRegisted, lessonItem: lessonItem));
  }
}