import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mooc_app/app/config/app_common.dart';
import 'package:mooc_app/domain/entities/lesson.dart';
import 'package:mooc_app/presentation/controllers/course_lesson/course_lesson_controller.dart';

class CourseLessonVideoBetterPlayer extends StatefulWidget {
  const CourseLessonVideoBetterPlayer({
    super.key,
    required this.idCourse,
    required this.isRegisted,
    required this.lessonItem,
  });

  final int idCourse;
  final bool isRegisted;
  final Lesson? lessonItem;

  @override
  State<CourseLessonVideoBetterPlayer> createState() => _CourseLessonVideoBetterPlayerState();
}

class _CourseLessonVideoBetterPlayerState extends State<CourseLessonVideoBetterPlayer> {

  late BetterPlayerController betterPlayerController;

  final courseLessonController = Get.find<CourseLessonController>();

  @override
  void initState() {
    super.initState();
    initVideoBetterPlayer();
  }

  initVideoBetterPlayer() {
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        widget.lessonItem?.data ?? ''
    );
    betterPlayerController = BetterPlayerController(
      const BetterPlayerConfiguration(
        controlsConfiguration: BetterPlayerControlsConfiguration(
          playIcon: CupertinoIcons.play_arrow,
          pauseIcon: CupertinoIcons.pause,
          fullscreenEnableIcon: CupertinoIcons.fullscreen,
          fullscreenDisableIcon: CupertinoIcons.fullscreen_exit,
          muteIcon: CupertinoIcons.speaker_1,
          unMuteIcon: CupertinoIcons.speaker_slash,
          skipBackIcon: CupertinoIcons.gobackward_10,
          skipForwardIcon: CupertinoIcons.goforward_10,
          overflowMenuIcon: CupertinoIcons.ellipsis_vertical,
          playbackSpeedIcon: CupertinoIcons.time,
          subtitlesIcon: CupertinoIcons.captions_bubble,
          qualitiesIcon: CupertinoIcons.slider_horizontal_3,
          audioTracksIcon: CupertinoIcons.music_note,
          controlBarColor: Colors.black45,
          playerTheme: BetterPlayerTheme.cupertino,
        ),
        autoPlay: true,
        // autoDispose: false,
        deviceOrientationsOnFullScreen: [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ],
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]
      ),
      betterPlayerDataSource: betterPlayerDataSource,
    );
  }

  @override
  void dispose() async {
    super.dispose();

    if (widget.isRegisted) {
      final duration = betterPlayerController.videoPlayerController?.value.duration;
      final position = await betterPlayerController.videoPlayerController?.position;
      final viewPercent = ((position?.inMilliseconds ?? 0) * 100 / (duration?.inMilliseconds ?? 0)).floor();

      await courseLessonController.completeLesson(widget.lessonItem?.id ?? 0, widget.idCourse, viewPercent);
    }

    betterPlayerController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.lessonItem?.label ?? ''),
        trailing: GestureDetector(
          onTap: () {
            betterPlayerController.pause();
            handlePressMenuLesson(context, widget.lessonItem?.documentFiles ?? []);
          },
          child: const Icon(CupertinoIcons.bars, size: 24.0, color: Colors.black),
        ),
      ),
      backgroundColor: Colors.black,
      child: Container(
        padding: EdgeInsets.only(top: (statusBarHeight + const CupertinoNavigationBar().preferredSize.height)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: BetterPlayer(
                  controller: betterPlayerController
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
