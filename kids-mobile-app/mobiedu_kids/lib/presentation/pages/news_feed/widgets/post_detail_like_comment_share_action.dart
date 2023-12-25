import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/home_page_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/news_feed_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/saved_posts_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_group_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_page_controller.dart';

class PostDetailLikeCommentShareAction extends StatelessWidget {
  PostDetailLikeCommentShareAction({
    super.key,
    required this.from,
    this.personName,
  });

  final String from;
  final String? personName;

  final newsFeedController = Get.find<NewsFeedController>();
  final showPageController = Get.find<ShowPageController>();
  final showGroupController = Get.find<ShowGroupController>();
  final savedPostsController = Get.find<SavedPostsController>();

  @override
  Widget build(BuildContext context) {
    
    final homePageController = Get.find<HomePageController>(tag: personName);

    Future<void> handlePressLike() async {
      var action = '';
      if (from == PostNewsFrom.newsFeedPage) {
        action = (newsFeedController.postDetailData.value?.i_like ?? false) ? ActionPostNews.unLikePost : ActionPostNews.likePost;
        await newsFeedController.postActionLikePostFromPostDetail(action, newsFeedController.postDetailData.value?.post_id ?? '');
      } else if (from == PostNewsFrom.schoolPage) {
        action = (showPageController.postDetailData.value?.i_like ?? false) ? ActionPostNews.unLikePost : ActionPostNews.likePost;
        await showPageController.postActionLikePostFromPostDetail(action, showPageController.postDetailData.value?.post_id ?? '');
      } else if (from == PostNewsFrom.classPage) {
        action = (showGroupController.postDetailData.value?.i_like ?? false) ? ActionPostNews.unLikePost : ActionPostNews.likePost;
        await showGroupController.postActionLikePostFromPostDetail(action, showGroupController.postDetailData.value?.post_id ?? '');
      } else if (from == PostNewsFrom.personPage) {
        action = (homePageController.postDetailData.value?.i_like ?? false) ? ActionPostNews.unLikePost : ActionPostNews.likePost;
        await homePageController.postActionLikePostFromPostDetail(action, homePageController.postDetailData.value?.post_id ?? '');
      } else if (from == PostNewsFrom.savedPostPage) {
        action = (savedPostsController.postDetailData.value?.i_like ?? false) ? ActionPostNews.unLikePost : ActionPostNews.likePost;
        await savedPostsController.postActionLikePostFromPostDetail(action, savedPostsController.postDetailData.value?.post_id ?? '');
      }
    }

    Future<void> handlePressShareItem(BuildContext context, String type) async {
      if (type == 'kid') {
        Navigator.pop(context, 'OK');
        if (from == PostNewsFrom.newsFeedPage) {
          await newsFeedController.postActionShareKid(newsFeedController.postDetailData.value?.post_id ?? '');
        } else if (from == PostNewsFrom.schoolPage) {
          await showPageController.postActionShareKid(showPageController.postDetailData.value?.post_id ?? '');
        } else if (from == PostNewsFrom.classPage) {
          await showGroupController.postActionShareKid(showGroupController.postDetailData.value?.post_id ?? '');
        } else if (from == PostNewsFrom.personPage) {
          await homePageController.postActionShareKid(homePageController.postDetailData.value?.post_id ?? '');
        } else if (from == PostNewsFrom.savedPostPage) {
          await savedPostsController.postActionShareKid(savedPostsController.postDetailData.value?.post_id ?? '');
        }
      }
    }

    Widget shareItem(BuildContext context, String type) {
      return InkWell(
        onTap: () {
          handlePressShareItem(context, type);
        },
        child: Row(
          children: [
            type == 'facebook'
              ? FaIcon(FontAwesomeIcons.facebookF, size: context.responsive(22.0))
              : FaIcon(FontAwesomeIcons.k, size: context.responsive(22.0)),
            SizedBox(width: context.responsive(16.0)),
            Text(
              type == 'facebook' ? 'Chia sẻ Facebook' : 'Chia sẻ trên Kids',
              style: GoogleFonts.raleway(
                textStyle: TextStyle(fontSize: context.responsive(16.0), fontWeight: FontWeight.w500, color: HexColor('464646'))
              )
            )
          ],
        ),
      );
    }

    void handlePressShare(BuildContext context) {
      showDialog(
        context: context, 
        builder: (context) {
          return Dialog(
            backgroundColor: HexColor('FFFFFF'),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: context.responsive(20.0), horizontal: context.responsive(30.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  shareItem(context, 'facebook'),
                  SizedBox(height: context.responsive(30.0)),
                  shareItem(context, 'kid'),
                ],
              ),
            ),
          );
        },
      );
    }

    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              handlePressLike();
            },
            child: Row(
              children: [
                (from == PostNewsFrom.newsFeedPage
                  ? (newsFeedController.postDetailData.value?.i_like ?? false)
                  : from == PostNewsFrom.schoolPage
                    ? (showPageController.postDetailData.value?.i_like ?? false)
                    : from == PostNewsFrom.classPage
                      ? (showGroupController.postDetailData.value?.i_like ?? false)
                      : from == PostNewsFrom.personPage
                        ? (homePageController.postDetailData.value?.i_like ?? false)
                        : (savedPostsController.postDetailData.value?.i_like ?? false)
                )
                  ? Icon(CupertinoIcons.heart_fill, size: context.responsive(22.0), color: HexColor('F67882'))
                  : Icon(CupertinoIcons.heart, size: context.responsive(22.0), color: HexColor('6F6F6F')),
                SizedBox(width: context.responsive(8.0)),
                Text(
                  'Thích',
                  style: GoogleFonts.raleway(
                    textStyle: (from == PostNewsFrom.newsFeedPage
                      ? (newsFeedController.postDetailData.value?.i_like ?? false)
                      : from == PostNewsFrom.schoolPage
                        ? (showPageController.postDetailData.value?.i_like ?? false)
                        : from == PostNewsFrom.classPage
                          ? (showGroupController.postDetailData.value?.i_like ?? false)
                          : from == PostNewsFrom.personPage
                            ? (homePageController.postDetailData.value?.i_like ?? false)
                            : (savedPostsController.postDetailData.value?.i_like ?? false)
                    )
                      ? TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w700, color: HexColor('F67882'))
                      : TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w500, color: HexColor('6F6F6F'))
                  ),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {
              if (from == PostNewsFrom.newsFeedPage) {
                newsFeedController.focusComment.requestFocus();
              } else if (from == PostNewsFrom.schoolPage) {
                showPageController.focusComment.requestFocus();
              } else if (from == PostNewsFrom.classPage) {
                showGroupController.focusComment.requestFocus();
              } else if (from == PostNewsFrom.personPage) {
                homePageController.focusComment.requestFocus();
              } else if (from == PostNewsFrom.savedPostPage) {
                savedPostsController.focusComment.requestFocus();
              }
            },
            child: Row(
              children: [
                Icon(CupertinoIcons.bubble_left, size: context.responsive(22.0), color: HexColor('6F6F6F')),
                SizedBox(width: context.responsive(8.0)),
                Text(
                  'Bình luận',
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w500, color: HexColor('6F6F6F'))
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {
              handlePressShare(context);
            },
            child: Row(
              children: [
                Icon(Icons.share_outlined, size: context.responsive(22.0), color: HexColor('6F6F6F')),
                SizedBox(width: context.responsive(8.0)),
                Text(
                  'Chia sẻ',
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w500, color: HexColor('6F6F6F'))
                  ),
                  textAlign: TextAlign.end,
                )
              ],
            ),
          )
        ],
      )
    );
  }
}