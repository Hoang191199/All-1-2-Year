import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:mooc_app/app/config/app_colors.dart';
import 'package:mooc_app/presentation/controllers/blog/blog_controller.dart';

import '../../widgets/blog_item.dart';

class BlogListPage extends StatelessWidget {
  BlogListPage({
    Key? key,
  }) : super(key: key);

  final blogController = Get.find<BlogController>();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    return GetX(
      init: blogController,
      initState: (state) {
        scrollController.addListener(scrollListener);
      },
      didUpdateWidget: (old, newState) {
        scrollController.addListener(scrollListener);
      },
      dispose: (state) {
        scrollController.removeListener(scrollListener);
      },
      builder: (_) {
        return CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(
              middle: Text(""),
            ),
            child: blogController.isLoading.value
                ? Container(
                    color: Colors.white,
                    child: Center(
                      child: defaultTargetPlatform == TargetPlatform.iOS
                          ? const CupertinoActivityIndicator()
                          : SizedBox(
                              width: 20.0,
                              height: 20.0,
                              child: CircularProgressIndicator(
                                  color: AppColors.primaryBlue,
                                  strokeWidth: 2.0),
                            ),
                    ),
                  )
                : blogController.fetch.value!.isNotEmpty
                    ? Container(
                        padding: const EdgeInsets.all(10.0),
                        height: heightScreen,
                        child: GridView.count(
                          controller: scrollController,
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          shrinkWrap: true,
                          childAspectRatio: widthScreen / 500.0,
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: List.generate(
                              blogController.fetch.value!.length,
                              (index) => Center(
                                    child: BlogItem(
                                      widthItem: widthScreen / 2,
                                      blogItem:
                                          blogController.fetch.value![index],
                                    ),
                                  )),
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.only(top: 80.0),
                        child: const Center(
                          child: Text('Không tìm thấy bài viết!',
                              style: TextStyle(color: Colors.black54)),
                        )));
      },
    );
  }

  void scrollListener() {
    if (scrollController.position.extentAfter < 500) {}
  }
}
