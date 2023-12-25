import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mooc_app/domain/entities/course.dart';
import 'package:mooc_app/presentation/pages/course_detail/widgets/course_video_better_player.dart';
import 'package:mooc_app/presentation/pages/course_detail/widgets/course_youtube_player_iframe.dart';

class CourseDetailImageVideo extends StatelessWidget {
  const CourseDetailImageVideo({
    super.key,
    this.courseInfo
  });

  final Course? courseInfo;

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    
    return 
      courseInfo?.video_url?.isEmpty ?? false
        ? courseInfo?.image_url?.isEmpty ?? false
          ? Image.asset(
            'assets/images/banner_home_1.png',
            width: widthScreen,
            height: 220.0,
            fit: BoxFit.cover,
          )
          : CachedNetworkImage(
            imageUrl: courseInfo?.image_url ?? '',
            width: widthScreen,
            height: 220.0,
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, downloadProgress) => const SizedBox(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          )
        : courseInfo?.video_url?.startsWith('https://www.youtube.com/') ?? false
          ? CourseYoutubePlayerIframe(youtubeUrl: courseInfo?.video_url ?? '')
          : CourseVideoBetterPlayer(
            videoUrl: courseInfo?.video_url ?? "",
            // videoUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
            imageUrl: courseInfo?.image_url ?? "",
          )
    ;
  }
}