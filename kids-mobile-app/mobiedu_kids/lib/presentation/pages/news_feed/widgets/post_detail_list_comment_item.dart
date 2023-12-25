import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/post_comment.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/home_page_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/home_page_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/news_feed_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/saved_posts_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_group_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_page_controller.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/person_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/item_image_rect.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_avatar.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/post_detail_delete_comment.dart';

class PostDetailListCommentItem extends StatelessWidget {
  PostDetailListCommentItem({
    super.key,
    required this.from,
    this.postComment,
    this.personName,
  });

  final String from;
  final PostComment? postComment;
  final String? personName;

  final store = Get.find<LocalStorageService>();
  final newsFeedController = Get.find<NewsFeedController>();
  final showPageController = Get.find<ShowPageController>();
  final showGroupController = Get.find<ShowGroupController>();
  final savedPostsController = Get.find<SavedPostsController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    final homePageController = Get.find<HomePageController>(tag: personName);

    Future<void> handlePressLikeComment(bool? iLike, String? commentId) async {
      final action = (iLike ?? false) ? ActionPostNews.unLikeComment : ActionPostNews.likeComment;
      if (from == PostNewsFrom.newsFeedPage) {
        await newsFeedController.postActionLikeCommentFromPostDetail(action, commentId ?? '');
      } else if (from == PostNewsFrom.schoolPage) {
        await showPageController.postActionLikeCommentFromPostDetail(action, commentId ?? '');
      } else if (from == PostNewsFrom.classPage) {
        await showGroupController.postActionLikeCommentFromPostDetail(action, commentId ?? '');
      } else if (from == PostNewsFrom.personPage) {
        await homePageController.postActionLikeCommentFromPostDetail(action, commentId ?? '');
      } else if (from == PostNewsFrom.savedPostPage) {
        await savedPostsController.postActionLikeCommentFromPostDetail(action, commentId ?? '');
      }
    }

    void handlePressReply(PostComment? postComment) {
      if (from == PostNewsFrom.newsFeedPage) {
        newsFeedController.postCommentReply.value = postComment;
        newsFeedController.focusComment.requestFocus();
      } else if (from == PostNewsFrom.schoolPage) {
        showPageController.postCommentReply.value = postComment;
        showPageController.focusComment.requestFocus();
      } else if (from == PostNewsFrom.classPage) {
        showGroupController.postCommentReply.value = postComment;
        showGroupController.focusComment.requestFocus();
      } else if (from == PostNewsFrom.personPage) {
        homePageController.postCommentReply.value = postComment;
        homePageController.focusComment.requestFocus();
      } else if (from == PostNewsFrom.savedPostPage) {
        savedPostsController.postCommentReply.value = postComment;
        savedPostsController.focusComment.requestFocus();
      }
    }

    return Container(
      padding: EdgeInsets.only(left: postComment?.level == '2' ? context.responsive(44.0) : 0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NewsFeedAvatar(
                imageNetwork: postComment?.author_picture ?? '',
                radius: postComment?.level == '2' ? context.responsive(12.0) : context.responsive(19.0),
              ),
              SizedBox(width: context.responsive(8.0)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: context.responsive(4.0), horizontal: context.responsive(11.0)),
                    decoration: BoxDecoration(
                      color: HexColor('D8D8D8'),
                      borderRadius: BorderRadius.all(Radius.circular(context.responsive(10.0)))
                    ),
                    constraints: BoxConstraints(
                      maxWidth: postComment?.level == '1' 
                        ? (widthScreen - context.responsive(126.0)) 
                        : (widthScreen - context.responsive(156.0))
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            handlePressUser(postComment?.user_name ?? '', postComment?.user_fullname ?? '');
                          },
                          child: Text(
                            postComment?.author_name ?? '',
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w700, color: HexColor('464646'))
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: context.responsive(4.0)),
                        Text(
                          postComment?.text ?? '',
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w500, color: HexColor('464646'))
                          ),
                        ),
                        if (postComment?.image != null && (postComment?.image?.isNotEmpty ?? false))
                          Column(
                            children: [
                              SizedBox(height: context.responsive(4.0)),
                              ItemImageRect(
                                imageUrl: postComment?.image ?? '', 
                                width: context.responsive(100.0), 
                                height: context.responsive(120.0)
                              ),
                              SizedBox(height: context.responsive(4.0)),
                            ],
                          )
                      ],
                    ),
                  ),
                  SizedBox(height: context.responsive(6.0)),
                  Row(
                    children: [
                      SizedBox(width: context.responsive(4.0)),
                      Text(
                        notiTime(postComment?.time ?? '0'),
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(fontSize: context.responsive(12.0), fontWeight: FontWeight.w500, color: HexColor('6F6F6F'))
                        ),
                      ),
                      SizedBox(width: context.responsive(16.0)),
                      InkWell(
                        onTap: () {
                          handlePressLikeComment(postComment?.i_like, postComment?.comment_id);
                        },
                        child: Text(
                          'Thích',
                          style: GoogleFonts.raleway(
                            textStyle: postComment?.i_like ?? false
                              ? TextStyle(fontSize: context.responsive(12.0), fontWeight: FontWeight.w700, color: HexColor('F67882'))
                              : TextStyle(fontSize: context.responsive(12.0), fontWeight: FontWeight.w500, color: HexColor('6F6F6F'))
                          ),
                        ),
                      ),
                      SizedBox(width: context.responsive(16.0)),
                      if (postComment?.level == '1')
                        InkWell(
                          onTap: () {
                            handlePressReply(postComment);
                          },
                          child: Text(
                            'Trả lời',
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(fontSize: context.responsive(12.0), fontWeight: FontWeight.w500, color: HexColor('6F6F6F'))
                            ),
                          ),
                        ),
                    ],
                  )
                ],
              )
            ],
          ),
          if (store.userFromStorage?.user_id == postComment?.author_id)
            Row(
              children: [
                SizedBox(width: context.responsive(6.0)),
                InkWell(
                  child: Padding(
                    padding: EdgeInsets.all(context.responsive(8.0)),
                    child: Icon(CupertinoIcons.xmark, size: context.responsive(18.0), color: HexColor('6F6F6F'))
                  ),
                  onTap: () {
                    handlePressDeleteComment(context, postComment?.comment_id ?? '', postComment?.node_id ?? '');
                  },
                ),
              ],
            )
        ],
      ),
    );
  }

  void handlePressDeleteComment(BuildContext context, String commentId, String postId) {
    showDialog(
      context: context, 
      builder: (context) {
        return PostDetailDeleteComment(
          from: from,
          commentId: commentId,
          postId: postId,
          personName: personName,
        );
      },
    );
  }
  
  void handlePressUser(String userName, String userFullName) {
    HomePageBinding(userName).dependencies();
    Get.to(
      () => PersonPage(
        personName: userName,
        personFullName: userFullName,
      ),
      duration: const Duration(milliseconds: 400),
      transition: Transition.rightToLeft
    );
  }
}