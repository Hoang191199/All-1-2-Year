import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:mooc_app/presentation/controllers/blog/blog_detail_controller.dart';

class BlogDetailPage extends StatelessWidget {
  BlogDetailPage({required this.slug});
  String slug;
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    final fetch = Get.find<BlogDetailController>();
    fetch.fetchData(slug);
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            middle: Obx(() => fetch.isInitialized.value
                ? Container(
                    width: widthScreen / 2,
                    child: Center(
                      child: Text(fetch.fetch.value!.title),
                    ),
                  )
                : Container(
                    width: widthScreen / 2,
                    child: const Center(
                      child: Text("Đang tải blog"),
                    ),
                  ))),
        child: Obx(() => fetch.isInitialized.value
            ? Padding(
                padding: const EdgeInsets.only(left: 5, right: 5
                    // top: CupertinoNavigationBar().preferredSize.height
                    ),
                child:
                    ListView(physics: const ClampingScrollPhysics(), children: [
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text("Tác giả ${fetch.fetch.value!.creatorName}"),
                    ),
                  ),
                  Container(
                    child: Html(
                      data: "${fetch.fetch.value!.htmlContent}",
                    ),
                  ),
                  // Container(
                  //   child: Text(
                  //     "${fetch.fetch.value!. ?? ""}",
                  //   ),
                  // ),
                ]))
            : Container(
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )));
  }
}
