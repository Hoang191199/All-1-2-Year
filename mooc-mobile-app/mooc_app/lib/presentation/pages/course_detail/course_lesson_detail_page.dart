import 'package:flutter/cupertino.dart';
import 'package:mooc_app/app/config/app_constants.dart';
import 'package:mooc_app/domain/entities/lesson.dart';
import 'package:mooc_app/presentation/pages/course_detail/widgets/course_lesson_audio.dart';
import 'package:mooc_app/presentation/pages/course_detail/widgets/course_lesson_exam.dart';
import 'package:mooc_app/presentation/pages/course_detail/widgets/course_lesson_html.dart';
import 'package:mooc_app/presentation/pages/course_detail/widgets/course_lesson_office.dart';
import 'package:mooc_app/presentation/pages/course_detail/widgets/course_lesson_pdf.dart';
import 'package:mooc_app/presentation/pages/course_detail/widgets/course_lesson_video_better_player.dart';
import 'package:mooc_app/presentation/pages/course_detail/widgets/course_lesson_youtube_player_iframe.dart';

class CourseLessonDetailPage extends StatelessWidget {
  const CourseLessonDetailPage({
    super.key,
    required this.idCourse,
    required this.isRegisted,
    required this.lessonItem,
  });

  final int idCourse;
  final bool isRegisted;
  final Lesson? lessonItem;

  @override
  Widget build(BuildContext context) {
    return lessonItem?.type?.toLowerCase() == LessonType.video.toLowerCase() 
      ? CourseLessonVideoBetterPlayer(idCourse: idCourse, isRegisted: isRegisted, lessonItem: lessonItem) 
      : lessonItem?.type?.toLowerCase() == LessonType.youtube.toLowerCase()
        ? CourseLessonYoutubePlayerIframe(idCourse: idCourse, isRegisted: isRegisted, lessonItem: lessonItem)
        : lessonItem?.type?.toLowerCase() == LessonType.audio.toLowerCase()
          ? CourseLessonAudio(idCourse: idCourse, isRegisted: isRegisted, lessonItem: lessonItem)
          : lessonItem?.type?.toLowerCase() == LessonType.pdf.toLowerCase()
            ? CourseLessonPdf(idCourse: idCourse, isRegisted: isRegisted, lessonItem: lessonItem)
            : lessonItem?.type?.toLowerCase() == LessonType.msOffice.toLowerCase()
              ? CourseLessonOffice(idCourse: idCourse, isRegisted: isRegisted, lessonItem: lessonItem)
              : lessonItem?.type?.toLowerCase() == LessonType.exam.toLowerCase()
                ? CourseLessonExam(idCourse: idCourse, isRegisted: isRegisted, lessonItem: lessonItem)
                : CourseLessonHtml(idCourse: idCourse, isRegisted: isRegisted, lessonItem: lessonItem)
    ;
  }
}