import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mooc_app/app/config/app_common.dart';
import 'package:mooc_app/domain/entities/lesson.dart';
import 'package:mooc_app/presentation/controllers/cart/cart_binding.dart';
import 'package:mooc_app/presentation/controllers/course_detail/course_detail_binding.dart';
import 'package:mooc_app/presentation/controllers/course_detail/course_review_binding.dart';
import 'package:mooc_app/presentation/controllers/course_lesson/course_lesson_controller.dart';
import 'package:mooc_app/presentation/controllers/register_course/add_free_course_binding.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class CourseLessonYoutubePlayerIframe extends StatefulWidget {
  const CourseLessonYoutubePlayerIframe({
    super.key,
    required this.idCourse,
    required this.isRegisted,
    required this.lessonItem,
  });

  final int idCourse;
  final bool isRegisted;
  final Lesson? lessonItem;

  @override
  State<CourseLessonYoutubePlayerIframe> createState() => _CourseLessonYoutubePlayerIframeState();
}

class _CourseLessonYoutubePlayerIframeState extends State<CourseLessonYoutubePlayerIframe> {

  late YoutubePlayerController youtubePlayerController;
  // var isDisposed = false;

  final courseLessonController = Get.find<CourseLessonController>();

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);

    // if (isDisposed) {
    //   return;
    // }

    var id = YoutubePlayerController.convertUrlToId(widget.lessonItem?.data ?? '') as String;

    youtubePlayerController = YoutubePlayerController.fromVideoId(
      videoId: id,
      autoPlay: true,
      params: const YoutubePlayerParams(
        showControls: true,
        mute: false,
        showFullscreenButton: true,
        loop: false,
      ),
    );
  }

  // @override
  // void dispose() async {

  //   if (widget.isRegisted) {
  //     final duration = await youtubePlayerController.duration;
  //     final currentTime = await youtubePlayerController.currentTime;
  //     final viewPercent = (currentTime * 100 / duration).floor();
  //     await courseLessonController.completeLesson(widget.lessonItem?.id ?? 0, widget.idCourse, viewPercent);
  //   }

  //   youtubePlayerController.close();

  //   isDisposed = true;
  //   super.dispose();
  // }
  
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double heightScreen = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: onWillPop,
      child: CupertinoPageScaffold(
        navigationBar: MediaQuery.of(context).orientation == Orientation.landscape 
          ? null 
          : CupertinoNavigationBar(
            middle: Text(widget.lessonItem?.label ?? ''),
            trailing: GestureDetector(
              onTap: () {
                youtubePlayerController.pauseVideo();
                handlePressMenuLesson(context, widget.lessonItem?.documentFiles ?? []);
              },
              child: const Icon(CupertinoIcons.bars, size: 24.0, color: Colors.black),
            ),
          ),
        backgroundColor: Colors.black,
        child: Container(
          padding: MediaQuery.of(context).orientation == Orientation.landscape 
            ? null 
            : EdgeInsets.only(top: (statusBarHeight + const CupertinoNavigationBar().preferredSize.height)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).orientation == Orientation.landscape ? heightScreen : null,
                  child: YoutubePlayerScaffold(
                    controller: youtubePlayerController,
                    backgroundColor: Colors.black,
                    // enableFullScreenOnVerticalDrag: false,
                    aspectRatio: 16 / 9,
                    builder: (context, player) {
                      return player;
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ), 
    );
  }

  Future<bool> onWillPop() async {
    CourseDetailBinding().dependencies();
    CartBinding().dependencies();
    AddFreeCourseBinding().dependencies();
    CourseReviewBinding().dependencies();
    if (widget.isRegisted) {
      final duration = await youtubePlayerController.duration;
      final currentTime = await youtubePlayerController.currentTime;
      final viewPercent = (currentTime * 100 / duration).floor();
      await courseLessonController.completeLesson(widget.lessonItem?.id ?? 0, widget.idCourse, viewPercent);
    }
    return true;
  }
}