import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/post_news.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/home_page_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/news_feed_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/saved_posts_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_group_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_page_controller.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_section_item.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class NewsFeedSection extends StatelessWidget {
  NewsFeedSection({
    super.key,
    required this.from,
    this.personName,
    required this.listPostNews,
  });

  final String from;
  final String? personName;
  final List<PostNews> listPostNews;

  final newsFeedController = Get.find<NewsFeedController>();
  final showPageController = Get.find<ShowPageController>();
  final showGroupController = Get.find<ShowGroupController>();
  final savedPostsController = Get.find<SavedPostsController>();

  @override
  Widget build(BuildContext context) {

    final homePageController = Get.find<HomePageController>(tag: personName);

    return Obx(
      () => ListView.separated(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.only(top: 0.0, bottom: context.responsive(50.0)),
        shrinkWrap: true,
        separatorBuilder: (context, index) => SizedBox(height: context.responsive(16.0)),
        itemCount: (from == PostNewsFrom.newsFeedPage 
          ? newsFeedController.isLoadMore.value 
          : from == PostNewsFrom.schoolPage
            ? showPageController.isLoadMore.value
            : from == PostNewsFrom.schoolPage
              ? showGroupController.isLoadMore.value
              : from == PostNewsFrom.personPage
                ? homePageController.isLoadMore.value
                : savedPostsController.isLoadMore.value
        ) ? listPostNews.length + 1 : listPostNews.length,
        itemBuilder: (context, index) {
          if (index < listPostNews.length) {
            final postNews = listPostNews[index];
            return NewsFeedSectionItem(
              from: from,
              personName: personName,
              postNews: postNews,
              isShare: false,
              isPin: false,
            );
          } else {
            return const Center(
              child: CircularLoadingIndicator(),
            );
          }
        },
      )
    );
  }
}