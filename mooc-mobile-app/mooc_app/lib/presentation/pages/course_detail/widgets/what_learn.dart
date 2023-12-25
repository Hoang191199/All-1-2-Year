import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mooc_app/domain/entities/course.dart';

class WhatLearn extends StatelessWidget {
  const WhatLearn({
    super.key,
    this.courseInfo,
  });

  final Course? courseInfo;

  @override
  Widget build(BuildContext context) {
    return (courseInfo?.learn_what == null || (courseInfo?.learn_what?.isEmpty ?? false)) ? Container() : Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20.0),
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Text('Bạn sẽ học được gì', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black)),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 2.0),
          child: const Divider(color: Colors.black26, thickness: 1.0),
        ),
        Container(
          margin: const EdgeInsets.only(top: 6.0),
          child: Html(
            data: courseInfo?.learn_what,
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