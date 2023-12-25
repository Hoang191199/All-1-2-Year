import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mooc_app/domain/entities/course_combo.dart';

class CourseComboDetailImageVideo extends StatelessWidget {
  const CourseComboDetailImageVideo({super.key, this.courseInfo});

  final CourseCombo? courseInfo;

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    return courseInfo?.thumbnailFileUrl == null ||
            (courseInfo?.thumbnailFileUrl?.isEmpty ?? false)
        ? Image.asset(
            'assets/images/banner_home_1.png',
            width: widthScreen,
            height: 220.0,
            fit: BoxFit.cover,
          )
        : CachedNetworkImage(
            imageUrl: courseInfo?.thumbnailFileUrl ?? '',
            width: widthScreen,
            height: 220.0,
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                const SizedBox(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          );
  }
}
