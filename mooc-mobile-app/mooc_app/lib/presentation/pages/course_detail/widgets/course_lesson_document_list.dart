import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/domain/entities/document_file.dart';
import 'package:mooc_app/presentation/pages/course_detail/widgets/course_lesson_document_detail.dart';

class CourseLessonDocumentList extends StatelessWidget {
  const CourseLessonDocumentList({
    super.key,
    required this.documentFiles,
  });

  final List<DocumentFile> documentFiles;

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Tài liệu bài học'),
      ),
      child: Container(
        padding: EdgeInsets.only(top: (statusBarHeight + const CupertinoNavigationBar().preferredSize.height)),
        child: documentFiles.isEmpty 
          ? const Center(
            child: Text('Không có tài liệu bài học!'),
          )
          : ListView.builder(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            itemCount: documentFiles.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.to(() => CourseLessonDocumentDetail(documentFile: documentFiles[index]));
                },
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: const BorderRadius.all(Radius.circular(5.0))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(documentFiles[index].name ?? '', style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400, color: Colors.black)),
                      const SizedBox(height: 10.0),
                      Text(documentFiles[index].type ?? '', style: const TextStyle(fontSize: 12.0, color: Colors.black))
                    ],
                  ),
                ),
              );
            }
          ),
      ),
    );
  }
}