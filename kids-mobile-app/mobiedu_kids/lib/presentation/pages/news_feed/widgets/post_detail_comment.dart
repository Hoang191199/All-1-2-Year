import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/post_news.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/home_page_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/news_feed_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/saved_posts_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_group_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_page_controller.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_avatar.dart';

class PostDetailComment extends StatelessWidget {
  PostDetailComment({
    super.key,
    required this.from,
    this.postNews,
    this.personName,
  });

  final String from;
  final PostNews? postNews;
  final String? personName;

  final store = Get.find<LocalStorageService>();
  final newsFeedController = Get.find<NewsFeedController>();
  final showPageController = Get.find<ShowPageController>();
  final showGroupController = Get.find<ShowGroupController>();
  final savedPostsController = Get.find<SavedPostsController>();

  @override
  Widget build(BuildContext context) {
  
    final homePageController = Get.find<HomePageController>(tag: personName);

    Future<void> handlePressSendComment(String postId) async {
      if (from == PostNewsFrom.newsFeedPage) {
        if (newsFeedController.imagePicked.value != null) {
          Uint8List? file = await newsFeedController.imagePicked.value?.readAsBytes();
          await newsFeedController.createCommentFromDetailPost(postId, newsFeedController.commentController.text, file);
        } else if (newsFeedController.commentController.text.isNotEmpty) {
          await newsFeedController.createCommentFromDetailPost(postId, newsFeedController.commentController.text, Uint8List(0));
        }
      } else if (from == PostNewsFrom.schoolPage) {
        if (showPageController.imagePicked.value != null) {
          Uint8List? file = await showPageController.imagePicked.value?.readAsBytes();
          await showPageController.createCommentFromDetailPost(postId, showPageController.commentController.text, file);
        } else if (showPageController.commentController.text.isNotEmpty) {
          await showPageController.createCommentFromDetailPost(postId, showPageController.commentController.text, Uint8List(0));
        }
      } else if (from == PostNewsFrom.classPage) {
        if (showGroupController.imagePicked.value != null) {
          Uint8List? file = await showGroupController.imagePicked.value?.readAsBytes();
          await showGroupController.createCommentFromDetailPost(postId, showGroupController.commentController.text, file);
        } else if (showGroupController.commentController.text.isNotEmpty) {
          await showGroupController.createCommentFromDetailPost(postId, showGroupController.commentController.text, Uint8List(0));
        }
      } else if (from == PostNewsFrom.personPage) {
        if (homePageController.imagePicked.value != null) {
          Uint8List? file = await homePageController.imagePicked.value?.readAsBytes();
          await homePageController.createCommentFromDetailPost(postId, homePageController.commentController.text, file);
        } else if (homePageController.commentController.text.isNotEmpty) {
          await homePageController.createCommentFromDetailPost(postId, homePageController.commentController.text, Uint8List(0));
        }
      } else if (from == PostNewsFrom.savedPostPage) {
        if (savedPostsController.imagePicked.value != null) {
          Uint8List? file = await savedPostsController.imagePicked.value?.readAsBytes();
          await savedPostsController.createCommentFromDetailPost(postId, savedPostsController.commentController.text, file);
        } else if (homePageController.commentController.text.isNotEmpty) {
          await savedPostsController.createCommentFromDetailPost(postId, savedPostsController.commentController.text, Uint8List(0));
        }
      }
    }
    
    Future<void> handlePressPickImage() async {
      if (from == PostNewsFrom.newsFeedPage) {
        await newsFeedController.pickImagePostDetailFromGallery();
      } else if (from == PostNewsFrom.schoolPage) {
        await showPageController.pickImagePostDetailFromGallery();
      } else if (from == PostNewsFrom.classPage) {
        await showGroupController.pickImagePostDetailFromGallery();
      } else if (from == PostNewsFrom.personPage) {
        await homePageController.pickImagePostDetailFromGallery();
      } else if (from == PostNewsFrom.savedPostPage) {
        await savedPostsController.pickImagePostDetailFromGallery();
      }
    }
    
    void handlePressDeleteImagePicked() {
      if (from == PostNewsFrom.newsFeedPage) {
        newsFeedController.imagePicked.value = null;
      } else if (from == PostNewsFrom.schoolPage) {
        showPageController.imagePicked.value = null;
      } else if (from == PostNewsFrom.classPage) {
        showGroupController.imagePicked.value = null;
      } else if (from == PostNewsFrom.personPage) {
        homePageController.imagePicked.value = null;
      } else if (from == PostNewsFrom.savedPostPage) {
        savedPostsController.imagePicked.value = null;
      }
    }
    
    void handlePressCancelReply() {
      if (from == PostNewsFrom.newsFeedPage) {
        newsFeedController.postCommentReply.value = null;
        newsFeedController.imagePicked.value = null;
        newsFeedController.commentController.text = '';
      } else if (from == PostNewsFrom.schoolPage) {
        showPageController.postCommentReply.value = null;
        showPageController.imagePicked.value = null;
        showPageController.commentController.text = '';
      } else if (from == PostNewsFrom.classPage) {
        showGroupController.postCommentReply.value = null;
        showGroupController.imagePicked.value = null;
        showGroupController.commentController.text = '';
      } else if (from == PostNewsFrom.personPage) {
        homePageController.postCommentReply.value = null;
        homePageController.imagePicked.value = null;
        homePageController.commentController.text = '';
      } else if (from == PostNewsFrom.savedPostPage) {
        savedPostsController.postCommentReply.value = null;
        savedPostsController.imagePicked.value = null;
        savedPostsController.commentController.text = '';
      }
      FocusManager.instance.primaryFocus?.unfocus();
    }

    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (from == PostNewsFrom.newsFeedPage
            ? (newsFeedController.postCommentReply.value != null)
            : from == PostNewsFrom.schoolPage
              ? (showPageController.postCommentReply.value != null)
              : from == PostNewsFrom.classPage
                ? (showGroupController.postCommentReply.value != null)
                : from == PostNewsFrom.personPage
                  ? (homePageController.postCommentReply.value != null)
                  : (savedPostsController.postCommentReply.value != null)
          )
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: context.responsive(45.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Trả lời ',
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(fontSize: context.responsive(12.0), fontWeight: FontWeight.w500, color: HexColor('464646'))
                          ),
                          children: [
                            TextSpan(
                              text: from == PostNewsFrom.newsFeedPage
                                ? '${newsFeedController.postCommentReply.value?.author_name}'
                                : from == PostNewsFrom.schoolPage
                                  ? '${showPageController.postCommentReply.value?.author_name}'
                                  : from == PostNewsFrom.classPage
                                    ? '${showGroupController.postCommentReply.value?.author_name}'
                                    : from == PostNewsFrom.personPage
                                      ? '${homePageController.postCommentReply.value?.author_name}'
                                      : '${savedPostsController.postCommentReply.value?.author_name}',
                              style: GoogleFonts.raleway(
                                textStyle: TextStyle(fontSize: context.responsive(12.0), fontWeight: FontWeight.w700, color: HexColor('464646'))
                              ),
                            )
                          ]
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          handlePressCancelReply();
                        },
                        child: Text(
                          'Hủy',
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(fontSize: context.responsive(12.0), fontWeight: FontWeight.w500, color: HexColor('464646'), decoration: TextDecoration.underline)
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: context.responsive(10.0)),
              ],
            ),
          if (from == PostNewsFrom.newsFeedPage
            ? (newsFeedController.imagePicked.value != null)
            : from == PostNewsFrom.schoolPage
              ? (showPageController.imagePicked.value != null)
              : from == PostNewsFrom.classPage
                ? (showGroupController.imagePicked.value != null)
                : from == PostNewsFrom.personPage
                  ? (homePageController.imagePicked.value != null)
                  : (savedPostsController.imagePicked.value != null)
          )
            Padding(
              padding: EdgeInsets.only(left: context.responsive(45.0)),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      context.responsive(8.0), 
                      context.responsive(10.0), 
                      context.responsive(10.0), 
                      context.responsive(10.0)
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(context.responsive(10.0))),
                      child: Image.file(
                        from == PostNewsFrom.newsFeedPage
                          ? File(newsFeedController.imagePicked.value?.path ?? '')
                          : from == PostNewsFrom.schoolPage
                            ? File(showPageController.imagePicked.value?.path ?? '')
                            : from == PostNewsFrom.classPage
                              ? File(showGroupController.imagePicked.value?.path ?? '')
                              : from == PostNewsFrom.personPage
                                ? File(homePageController.imagePicked.value?.path ?? '')
                                : File(savedPostsController.imagePicked.value?.path ?? ''),
                        width: context.responsive(100.0),
                        height: context.responsive(120.0),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0.0,
                    right: 0.0,
                    child: InkWell(
                      child: Icon(CupertinoIcons.xmark_circle_fill, size: context.responsive(24.0), color: Colors.black),
                      onTap: () {
                        handlePressDeleteImagePicked();
                      },
                    )
                  )
                ],
              ),
            ),
          Row(
            children: [
              NewsFeedAvatar(imageNetwork: store.userFromStorage?.user_picture),
              SizedBox(width: context.responsive(7.0)),
              Expanded(
                child: TextField(
                  controller: from == PostNewsFrom.newsFeedPage 
                    ? newsFeedController.commentController
                    : from == PostNewsFrom.schoolPage
                      ? showPageController.commentController
                      : from == PostNewsFrom.classPage
                        ? showGroupController.commentController
                        : from == PostNewsFrom.personPage
                          ? homePageController.commentController
                          : savedPostsController.commentController,
                  focusNode: from == PostNewsFrom.newsFeedPage
                    ? newsFeedController.focusComment
                    : from == PostNewsFrom.schoolPage
                      ? showPageController.focusComment
                      : from == PostNewsFrom.classPage
                        ? showGroupController.focusComment
                        : from == PostNewsFrom.personPage
                          ? homePageController.focusComment
                          : savedPostsController.focusComment,
                  enableSuggestions: false,
                  autocorrect: false,
                  readOnly: !(postNews?.allow_comment ?? false),
                  decoration: InputDecoration(
                    hintText: (postNews?.allow_comment ?? false) ? 'Viết bình luận...' : 'Bạn không có quyền bình luận',
                    hintStyle: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        fontSize: context.responsive(14.0), 
                        height: context.responsive(1.3), 
                        fontWeight: FontWeight.w500, 
                        color: HexColor('464646')
                      )
                    ),
                    filled: true,
                    fillColor: HexColor('D8D8D8'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(context.responsive(20.0)),
                      borderSide: const BorderSide(
                        width: 0, 
                        style: BorderStyle.none,
                      )
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: context.responsive(10.0), horizontal: context.responsive(16.0)),
                    prefixIcon: (postNews?.allow_comment ?? false)
                      ? InkWell(
                        onTap: () {
                          handlePressPickImage();
                        },
                        child: Icon(CupertinoIcons.photo, size: context.responsive(22.0), color: HexColor('FF9ACE')),
                      )
                      : null,
                    prefixIconConstraints: BoxConstraints(minWidth: context.responsive(40.0), maxHeight: context.responsive(38.0)),
                    suffixIcon: (postNews?.allow_comment ?? false)
                      ? InkWell(
                        onTap: () {
                          handlePressSendComment(postNews?.post_id ?? '');
                        },
                        child: Icon(CupertinoIcons.paperplane, size: context.responsive(22.0), color: HexColor('FF9ACE')),
                      )
                      : null,
                    suffixIconConstraints: BoxConstraints(minWidth: context.responsive(40.0), maxHeight: context.responsive(38.0))
                  ),
                  cursorColor: HexColor('464646'),
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      fontSize: context.responsive(14.0), 
                      height: context.responsive(1.3), 
                      fontWeight: FontWeight.w500, 
                      color: HexColor('464646'), 
                      decorationThickness: 0.0
                    )
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  minLines: context.responsive(1),
                  maxLines: context.responsive(5),
                )
              ),
            ],
          )
        ],
      )
    );
  }
}