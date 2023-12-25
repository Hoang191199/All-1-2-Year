import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/app/config/app_common.dart';
import 'package:mooc_app/domain/entities/lesson.dart';
import 'package:mooc_app/presentation/controllers/course_lesson/course_lesson_controller.dart';
import 'package:mooc_app/presentation/widgets/circular_loading_indicator.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CourseLessonPdf extends StatefulWidget {
  const CourseLessonPdf({
    super.key,
    required this.idCourse,
    required this.isRegisted,
    required this.lessonItem,
  });

  final int idCourse;
  final bool isRegisted;
  final Lesson? lessonItem;

  @override
  State<CourseLessonPdf> createState() => _CourseLessonPdfState();
}

class _CourseLessonPdfState extends State<CourseLessonPdf> {

  var loadingPercentage = 0;
  final courseLessonController = Get.find<CourseLessonController>();

  late WebViewController webViewController;

  @override
  void initState() {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
      ))
      ..loadRequest(Uri.parse('https://cdn.mobiedu.vn/mobiedu/pdfjs/web/viewer.html?file=${widget.lessonItem?.data}'));
    
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();

    if (widget.isRegisted) {
      await courseLessonController.completeLesson(widget.lessonItem?.id ?? 0, widget.idCourse, 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.lessonItem?.label ?? ''),
        trailing: GestureDetector(
          onTap: () {
            handlePressMenuLesson(context, widget.lessonItem?.documentFiles ?? []);
          },
          child: const Icon(CupertinoIcons.bars, size: 24.0, color: Colors.black),
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(top: (statusBarHeight + const CupertinoNavigationBar().preferredSize.height), bottom: bottomPadding),
        child: 
          // SfPdfViewer.network(lessonItem?.data ?? ''),
          Stack(
            children: [
              WebViewWidget(
                controller: webViewController
              ),
              loadingPercentage < 100 
                ? const Center(
                  child: CircularLoadingIndicator(),
                )
                : Container()
            ],
          ),
      )
    );
  }
}