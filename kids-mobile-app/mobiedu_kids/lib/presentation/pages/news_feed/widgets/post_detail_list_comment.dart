import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/post_comment.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/home_page_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/news_feed_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/saved_posts_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_group_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_page_controller.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/post_detail_list_comment_item.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class PostDetailListComment extends StatelessWidget {
  PostDetailListComment({
    super.key,
    required this.from,
    required this.listPostComment,
    this.personName,
  });

  final String from;
  final List<PostComment> listPostComment;
  final String? personName;

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
        separatorBuilder: (context, index) => SizedBox(height: context.responsive(20.0)),
        itemCount: (from == PostNewsFrom.newsFeedPage 
          ? newsFeedController.isLoadMorePost.value 
          : from == PostNewsFrom.schoolPage
            ? showPageController.isLoadMorePost.value
            : from == PostNewsFrom.classPage
              ? showGroupController.isLoadMorePost.value
              : from == PostNewsFrom.personPage
                ? homePageController.isLoadMorePost.value
                : savedPostsController.isLoadMorePost.value
        ) 
          ? listPostComment.length + 1 
          : listPostComment.length,
        itemBuilder: (context, index) {
          if (index < listPostComment.length) {
            final postComment = listPostComment[index];
            return PostDetailListCommentItem(
              from: from,
              postComment: postComment,
              personName: personName,
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
