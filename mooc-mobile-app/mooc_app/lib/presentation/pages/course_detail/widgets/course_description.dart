import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mooc_app/domain/entities/course.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CourseDescription extends StatelessWidget {
  const CourseDescription({
    super.key,
    this.courseInfo,
  });

  final Course? courseInfo;

  @override
  Widget build(BuildContext context) {
    return (courseInfo?.description == null || (courseInfo?.description?.isEmpty ?? false)) ? Container() : Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 30.0),
          child:  Align(
            alignment: Alignment.centerLeft,
            child: Text(AppLocalizations.of(context)!.introCourse, 
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black)),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 2.0),
          child: const Divider(color: Colors.black26, thickness: 1.0),
        ),
        Container(
          margin: const EdgeInsets.only(top: 6.0),
          child: Html(
            data: courseInfo?.description,
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