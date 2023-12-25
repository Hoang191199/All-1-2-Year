import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class CourseYoutubePlayerIframe extends StatefulWidget {
  const CourseYoutubePlayerIframe({
    super.key,
    required this.youtubeUrl,
  });

  final String youtubeUrl;

  @override
  State<CourseYoutubePlayerIframe> createState() => _CourseYoutubePlayerIframeState();
}

class _CourseYoutubePlayerIframeState extends State<CourseYoutubePlayerIframe> {

  late YoutubePlayerController youtubePlayerController;

  @override
  void initState() {
    super.initState();

    var id = YoutubePlayerController.convertUrlToId(widget.youtubeUrl) as String;

    youtubePlayerController = YoutubePlayerController.fromVideoId(
      videoId: id,
      autoPlay: true,
      params: const YoutubePlayerParams(
        showControls: true,
        mute: false,
        showFullscreenButton: false,
        loop: false,
      ),
    );
  }

  // @override
  // void dispose() {
    
  //   youtubePlayerController.close();

  //   super.dispose();
  // }
  
  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;

    return Container(
      padding: MediaQuery.of(context).orientation == Orientation.landscape ? const EdgeInsets.only(top: 40.0): null,
      height: MediaQuery.of(context).orientation == Orientation.landscape ? heightScreen - 20.0: null,
      child: YoutubePlayerScaffold(
        controller: youtubePlayerController,
        backgroundColor: Colors.black,
        // enableFullScreenOnVerticalDrag: false,
        aspectRatio: 16 / 9,
        builder: (context, player) {
          return player;
        },
      ),
    );
  }
}