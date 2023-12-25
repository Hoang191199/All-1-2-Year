import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/saved_posts_controller.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_section.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/page_tag_top.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class SavedPostPage extends StatelessWidget {
  SavedPostPage({super.key});

  final savedPostsController = Get.find<SavedPostsController>();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return GetX(
      init: savedPostsController,
      initState: (state) async {
        savedPostsController.getSavedPost();
        scrollController.addListener(scrollListener);
      },
      didUpdateWidget: (old, newState) {
        scrollController.addListener(scrollListener);
      },
      dispose: (state) {
        scrollController.removeListener(scrollListener);
      },
      builder: (_) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            backgroundColor: HexColor('FFFFFF'),
            body: savedPostsController.isLoadingSavedPost.value && !savedPostsController.isRefresh.value
              ? const Center(
                child: CircularLoadingIndicator(),
              )
              : Container(
                padding: EdgeInsets.only(top: statusBarHeight + context.responsive(10.0)),
                child: RefreshIndicator(
                  color: AppColors.pink,
                  onRefresh: () async {
                    savedPostsController.refreshSavedPost();
                  },
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        controller: scrollController,
                        physics: const ClampingScrollPhysics(),
                        child: Column(
                          children: [
                            const PageTagTop(tagName: 'Bài viết đã lưu'),
                            SizedBox(height: context.responsive(14.0)),
                            NewsFeedSection(
                              from: PostNewsFrom.savedPostPage,
                              listPostNews: savedPostsController.savedPostData
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
          ),
        );
      }
    );
  }

  void scrollListener() {
    if (savedPostsController.canLoadMoreSavedPost.value) {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        savedPostsController.loadMoreSavedPost();
      }
    }
  }
}