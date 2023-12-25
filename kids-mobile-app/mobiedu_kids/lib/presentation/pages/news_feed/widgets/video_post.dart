import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  const VideoPost({
    super.key,
    required this.fileType,
    required this.filePath,
  });

  final String fileType;
  final String filePath;

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> {

  VideoPlayerController? videoPlayerController;

  final UniqueKey stickyKey = UniqueKey();
  bool isControllerReady = false;
  bool isPlaying = false;
  Completer videoPlayerInitializedCompleter = Completer();

  @override
  void initState() {
    super.initState();
    // initVideo();
  }

  @override
  Future<void> dispose() async {
    if (videoPlayerController != null) {
      await videoPlayerController?.dispose().then((_) {
        isControllerReady = false;
        videoPlayerController = null;
        videoPlayerInitializedCompleter = Completer();
      });
    }
    super.dispose();
  }

  initVideo() {
    if (widget.fileType == VideoFileType.network) {
      videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.filePath)
      );
    } else if (widget.fileType == VideoFileType.storage) {
      videoPlayerController = VideoPlayerController.file(
        File(widget.filePath)
      );
    }
    videoPlayerController?.initialize().then((value) async {
      videoPlayerInitializedCompleter.complete(true);
      setState(() {
        isControllerReady = true;
      });
      videoPlayerController?.setLooping(true);
    });
    // videoPlayerController?.addListener(() {
    //   if (videoPlayerController?.value.hasError ?? false) {
    //     print({'error', videoPlayerController?.value.errorDescription});
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: stickyKey,
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.7) {
          if (videoPlayerController == null) {
            initVideo();
          } 
        } else if (info.visibleFraction < 0.3) {
          setState(() {
            isControllerReady = false;
          });
          videoPlayerController?.pause();
          setState(() {
            isPlaying = false;
          });
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            videoPlayerController?.dispose().then((value) {
              setState(() {
                videoPlayerController = null;
                videoPlayerInitializedCompleter = Completer();
              });
            });
          });
        }
      },
      child: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && videoPlayerController != null && isControllerReady) {
            return GestureDetector(
              onTap: () async {
                setState(() {
                  if (videoPlayerController?.value.isPlaying ?? false) {
                    videoPlayerController?.pause();
                    setState(() {
                      isPlaying = false;
                    });
                  } else {
                    videoPlayerController?.play();
                    setState(() {
                      isPlaying = true;
                    });
                  }
                });
              },
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  AspectRatio(
                    // aspectRatio: 16 / 9,
                    aspectRatio: videoPlayerController!.value.size.width / (videoPlayerController!.value.size.height),
                    child: VideoPlayer(videoPlayerController!),
                  ),
                  !isPlaying
                    ? Icon(CupertinoIcons.play_arrow_solid, size: context.responsive(40.0), color: HexColor('FFFFFF'))
                    : Container()
                ],
              ),
            );
          }
          return AspectRatio(
            // aspectRatio: 16 / 9,
            aspectRatio: 1,
            child: Container(
              color: Colors.black,
              child: Center(
                child: (videoPlayerController?.value.hasError ?? false)
                  ? Padding(
                    padding: EdgeInsets.all(context.responsive(20.0)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.play_disabled, size: context.responsive(30.0), color: HexColor('FFFFFF')),
                        SizedBox(height: context.responsive(10.0)),
                        Text(
                          'Video này hiện không khả dụng',
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w500, color: HexColor('FFFFFF'))
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  )
                  : const CircularLoadingIndicator(),
              ),
            ),
          );
        },
        future: videoPlayerInitializedCompleter.future,
      ),
    );
  }
}