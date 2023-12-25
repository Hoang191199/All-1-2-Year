import 'package:flutter/material.dart';
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

class PostDetailDeleteComment extends StatelessWidget {
  PostDetailDeleteComment({
    super.key,
    required this.from,
    required this.commentId,
    required this.postId,
    this.personName,
  });

  final String from;
  final String commentId;
  final String postId;
  final String? personName;

  final newsFeedController = Get.find<NewsFeedController>();
  final showPageController = Get.find<ShowPageController>();
  final showGroupController = Get.find<ShowGroupController>();
  final savedPostsController = Get.find<SavedPostsController>();

  @override
  Widget build(BuildContext context) {
  
    final homePageController = Get.find<HomePageController>(tag: personName);

    Future<void> handlePressSubmitDelete(BuildContext context) async {
      Navigator.pop(context, 'OK');
      if (from == PostNewsFrom.newsFeedPage) {
        await newsFeedController.postActionDeleteCommentFromPostDetail(commentId, postId);
      } else if (from == PostNewsFrom.schoolPage) {
        await showPageController.postActionDeleteCommentFromPostDetail(commentId, postId);
      } else if (from == PostNewsFrom.classPage) {
        await showGroupController.postActionDeleteCommentFromPostDetail(commentId, postId);
      } else if (from == PostNewsFrom.personPage) {
        await homePageController.postActionDeleteCommentFromPostDetail(commentId, postId);
      } else if (from == PostNewsFrom.savedPostPage) {
        await savedPostsController.postActionDeleteCommentFromPostDetail(commentId, postId);
      }
    }

    return AlertDialog(
      title: Text(
        'Thông báo', 
        style: GoogleFonts.raleway(
          textStyle: TextStyle(fontSize: context.responsive(22.0), fontWeight: FontWeight.w700, color: HexColor('783199'))
        )
      ),
      content: Text(
        'Bạn chắc chắn muốn xóa bình luận này?', 
        style: GoogleFonts.raleway(
          textStyle: TextStyle(fontSize: context.responsive(16.0), fontWeight: FontWeight.w500, color: HexColor('464646'))
        )
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          style: TextButton.styleFrom(
            textStyle: TextStyle(color: HexColor('464646'))),
          child: Text(
            'Không'.toUpperCase(), 
            style: GoogleFonts.raleway(
              textStyle: TextStyle(fontSize: context.responsive(16.0), fontWeight: FontWeight.w500, color: HexColor('464646'))
            )
          ),
        ),
        TextButton(
          onPressed: () {
            handlePressSubmitDelete(context);
          },
          style: TextButton.styleFrom(
            textStyle: TextStyle(color: HexColor('464646'))
          ),
          child: Text(
            'Có'.toUpperCase(), 
            style: GoogleFonts.raleway(
              textStyle: TextStyle(fontSize: context.responsive(16.0), fontWeight: FontWeight.w500, color: HexColor('464646'))
            )
          ),
        )
      ],
    );
  }
}