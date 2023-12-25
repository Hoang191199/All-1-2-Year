import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/app/config/app_common.dart';
import 'package:mooc_app/domain/entities/lesson.dart';
import 'package:mooc_app/presentation/controllers/course_lesson/course_lesson_controller.dart';

class CourseLessonAudio extends StatefulWidget {
  const CourseLessonAudio({
    super.key,
    required this.idCourse,
    required this.isRegisted,
    required this.lessonItem,
  });

  final int idCourse;
  final bool isRegisted;
  final Lesson? lessonItem;

  @override
  State<CourseLessonAudio> createState() => _CourseLessonAudioState();
}

class _CourseLessonAudioState extends State<CourseLessonAudio> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  final courseLessonController = Get.find<CourseLessonController>();

  @override
  void initState() {
    super.initState();

    setAudio();

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  Future setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.stop);
    String url = widget.lessonItem?.data ?? '';
    await audioPlayer.setSourceUrl(url);
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() async {
    super.dispose();

    if (widget.isRegisted) {
      await courseLessonController.completeLesson(widget.lessonItem?.id ?? 0, widget.idCourse, 0);
    }

    audioPlayer.dispose();
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
      backgroundColor: Colors.black,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          padding: EdgeInsets.only(top: (statusBarHeight + const CupertinoNavigationBar().preferredSize.height)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SliderTheme(
                  data: const SliderThemeData(
                    thumbColor: Colors.white,
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: Colors.white54,
                  ),
                  child: Slider(
                    min: 0,
                    max: duration.inSeconds.toDouble(),
                    value: position.inSeconds.toDouble(),
                    onChanged: (value) async {
                      final position = Duration(seconds: value.toInt());
                      await audioPlayer.seek(position);
                      // await audioPlayer.resume();
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(formatTime(position), style: const TextStyle(color: Colors.white)),
                    Text(formatTime(duration - position), style: const TextStyle(color: Colors.white))
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (isPlaying) {
                    await audioPlayer.pause();
                  } else {
                    String url = widget.lessonItem?.data ?? '';
                    await audioPlayer.play(UrlSource(url));
                  }
                },
                child: isPlaying 
                  ? const Icon(CupertinoIcons.pause_fill, size: 48, color: Colors.white) 
                  : const Icon(CupertinoIcons.play_arrow_solid, size: 48, color: Colors.white),
              ),
            ],
          ),
        ),
      )
    );
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds
    ].join(':');
  }
}