import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/post_news.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/home_page_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/news_feed_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/saved_posts_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_group_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_page_controller.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/news_feed_post_detail_page.dart';

class NewsFeedSectionItemLikeCommentView extends StatelessWidget {
  NewsFeedSectionItemLikeCommentView({
    super.key,
    required this.from,
    this.personName,
    this.postNews,
  });

  final String from;
  final String? personName;
  final PostNews? postNews;

  final newsFeedController = Get.find<NewsFeedController>();
  final showPageController = Get.find<ShowPageController>();
  final showGroupController = Get.find<ShowGroupController>();
  final savedPostsController = Get.find<SavedPostsController>();

  @override
  Widget build(BuildContext context) {
    
    final homePageController = Get.find<HomePageController>(tag: personName);

    Future<void> handlePressLike(bool? iLike, String? postId) async {
      final action = (iLike ?? false) ? ActionPostNews.unLikePost : ActionPostNews.likePost;
      if (from == PostNewsFrom.newsFeedPage) {
        await newsFeedController.postActionLikePostFromNewsFeed(action, postId ?? '');
      } else if (from == PostNewsFrom.schoolPage) {
        await showPageController.postActionLikePostFromSchool(action, postId ?? '');
      } else if (from == PostNewsFrom.classPage) {
        await showGroupController.postActionLikePostFromClass(action, postId ?? '');
      } else if (from == PostNewsFrom.personPage) {
        await homePageController.postActionLikePostFromHome(action, postId ?? '');
      } else if (from == PostNewsFrom.savedPostPage) {
        await savedPostsController.postActionLikePostFromSavedPost(action, postId ?? '');
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            handlePressLike(postNews?.i_like, postNews?.post_id);
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              0.0, 
              context.responsive(18.0), 
              context.responsive(40.0), 
              context.responsive(18.0)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                postNews?.i_like ?? false
                  ? Icon(CupertinoIcons.heart_fill, size: context.responsive(22.0), color: HexColor('F67882'))
                  : Icon(CupertinoIcons.heart, size: context.responsive(22.0), color: HexColor('6F6F6F')),
                SizedBox(width: context.responsive(8.0)),
                Text(
                  '${postNews?.likes ?? 0}',
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w500, color: HexColor('6F6F6F'))
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            handlePressComments(postNews);
          },
          child: Text(
            '${postNews?.comments ?? 0} Bình luận',
            style: GoogleFonts.raleway(
              textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w500, color: HexColor('6F6F6F'))
            ),
          ),
        )
      ],
    );
  }
  
  void handlePressComments(PostNews? postNews) {
    Get.to(
      () => NewsFeedPostDetailPage(
        from: from,
        postId: postNews?.post_id ?? '',
        showComment: true,
      ),
      duration: const Duration(milliseconds: 400),
      transition: Transition.rightToLeft
    );
  }
}