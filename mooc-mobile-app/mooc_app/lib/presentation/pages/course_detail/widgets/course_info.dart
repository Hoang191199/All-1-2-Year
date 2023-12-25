import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mooc_app/domain/entities/course.dart';

class CourseInfo extends StatelessWidget {
  const CourseInfo({
    super.key,
    this.courseInfo,
  });

  final Course? courseInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container(
        //   margin: const EdgeInsets.only(top: 20.0),
        //   child: Row(
        //     children: const [
        //       Icon(CupertinoIcons.time, color: Colors.black, size: 16.0),
        //       SizedBox(width: 10.0),
        //       Text('Thời lượng:', style: TextStyle(fontSize: 14.0, color: Colors.black)),
        //       SizedBox(width: 8.0),
        //       Text('00 giờ 00 phút', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold))
        //     ],
        //   )
        // ),
        Container(
          margin: const EdgeInsets.only(top: 20.0),
          child: Row(
            children: [
              const Icon(CupertinoIcons.play_circle, color: Colors.black, size: 16.0),
              const SizedBox(width: 10.0),
              const Text('Giáo trình:', style: TextStyle(fontSize: 14.0, color: Colors.black)),
              const SizedBox(width: 8.0),
              Text(
                '${courseInfo?.number_lesson ?? 0} bài giảng', 
                style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)
              )
            ],
          )
        ),
        Container(
          margin: const EdgeInsets.only(top: 10.0),
          child: Row(
            children: const [
              Icon(CupertinoIcons.timer, color: Colors.black, size: 16.0),
              SizedBox(width: 10.0),
              Text('Sở hữu trọn đời', style: TextStyle(fontSize: 14.0, color: Colors.black))
            ],
          )
        ),
        Container(
          margin: const EdgeInsets.only(top: 10.0),
          child: Row(
            children: const [
              Icon(CupertinoIcons.rosette, color: Colors.black, size: 16.0),
              SizedBox(width: 10.0),
              Text('Cấp chứng nhận hoàn thành', style: TextStyle(fontSize: 14.0, color: Colors.black))
            ],
          )
        ),
        Container(
          margin: const EdgeInsets.only(top: 10.0),
          child: Row(
            children: [
              const Icon(CupertinoIcons.percent, color: Colors.black, size: 16.0),
              const SizedBox(width: 10.0),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 14.0, color: Colors.black),
                  children: [
                    TextSpan(text: 'Giảm thêm '),
                    TextSpan(text: '20k', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ' khi thanh toán online')
                  ]
                )
              )
            ],
          )
        ),
      ],
    );
  }
}