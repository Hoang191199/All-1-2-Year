import 'package:better_player/better_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CourseVideoBetterPlayer extends StatefulWidget {
  const CourseVideoBetterPlayer({
    super.key,
    required this.videoUrl,
    required this.imageUrl,
  });

  final String videoUrl;
  final String imageUrl;

  @override
  State<CourseVideoBetterPlayer> createState() => _CourseVideoBetterPlayerState();
}

class _CourseVideoBetterPlayerState extends State<CourseVideoBetterPlayer> {

  late BetterPlayerController betterPlayerController;

  @override
  void initState() {
    super.initState();
    initVideoBetterPlayer();
  }

  initVideoBetterPlayer() {
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        widget.videoUrl
    );
    betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(
        controlsConfiguration: const BetterPlayerControlsConfiguration(
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
        autoPlay: false,
        placeholder: CachedNetworkImage(
          imageUrl: widget.imageUrl,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover
              ),
            ),
          ),
          progressIndicatorBuilder: (context, url, downloadProgress) => const SizedBox(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        showPlaceholderUntilPlay: true,
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
  void dispose() {
    
    betterPlayerController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: BetterPlayer(
        controller: betterPlayerController
      ),
    );
  }
}
