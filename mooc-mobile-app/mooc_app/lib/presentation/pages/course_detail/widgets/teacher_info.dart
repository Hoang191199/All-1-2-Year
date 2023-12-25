
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mooc_app/domain/entities/teacher.dart';

class TeacherInfo extends StatelessWidget {
  const TeacherInfo({
    super.key,
    this.teacherInfo
  });

  final Teacher? teacherInfo;

  @override
  Widget build(BuildContext context) {
    return teacherInfo == null 
      ? Container() 
      : Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30.0),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text('Thông tin giảng viên', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black)),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 2.0),
            child: const Divider(color: Colors.black26, thickness: 1.0),
          ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 6.0),
                child: teacherInfo?.avatar == null || (teacherInfo?.avatar?.isEmpty ?? false)
                  ? const CircleAvatar(
                    radius: 40.0,
                    backgroundColor: Colors.grey,
                  )
                  : CachedNetworkImage(
                    imageUrl: teacherInfo?.avatar ?? '',
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      radius: 40.0,
                      backgroundImage: imageProvider,
                    ),
                    progressIndicatorBuilder: (context, url, downloadProgress) => const SizedBox(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: Text(
                  teacherInfo?.name ?? '',
                  style: const TextStyle(fontSize: 16.0, color: Colors.black)
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 6.0),
            child: Html(
              data: teacherInfo?.description ?? '',
              style: {
                "body": Style(fontSize: FontSize(15.0)),
                "p": Style(fontSize: FontSize(15.0)),
                "span": Style(fontSize: FontSize(15.0)),
              },
            ),
          )
        ],
      );
  }
}