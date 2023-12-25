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
import 'package:mobiedu_kids/domain/entities/news_feed/post_news_comment.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/home_page_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/news_feed_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/saved_posts_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_group_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_page_controller.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_avatar.dart';

class NewsFeedSectionItemComment extends StatelessWidget {
  NewsFeedSectionItemComment({
    super.key,
    required this.from,
    this.personName,
    this.postNews,
    required this.isPin,
  });

  final String from;
  final String? personName;
  final PostNews? postNews;
  final bool isPin;

  final store = Get.find<LocalStorageService>();
  final newsFeedController = Get.find<NewsFeedController>();
  final showPageController = Get.find<ShowPageController>();
  final showGroupController = Get.find<ShowGroupController>();
  final savedPostsController = Get.find<SavedPostsController>();

  @override
  Widget build(BuildContext context) {
    
    final homePageController = Get.find<HomePageController>(tag: personName);

    final postNewsComment = from == PostNewsFrom.newsFeedPage
      ? newsFeedController.postNewsCommentData.firstWhere((element) => element?.post_id == postNews?.post_id)
      : from == PostNewsFrom.schoolPage
        ? isPin 
          ? showPageController.pinnedPostCommentData.value
          : showPageController.postNewsCommentData.firstWhere((element) => element?.post_id == postNews?.post_id)
        : from == PostNewsFrom.classPage
          ? isPin 
            ? showGroupController.pinnedPostCommentData.value
            : showGroupController.postNewsCommentData.firstWhere((element) => element?.post_id == postNews?.post_id)
          : from == PostNewsFrom.personPage
            ? homePageController.postNewsCommentData.firstWhere((element) => element?.post_id == postNews?.post_id)
            : savedPostsController.postNewsCommentData.firstWhere((element) => element?.post_id == postNews?.post_id);

    Future<void> handlePressSendComment(String postId, PostNewsComment? postNewsComment) async {
      if (postNewsComment?.imagePicked != null) {
        Uint8List? file = await postNewsComment?.imagePicked?.readAsBytes();
        if (from == PostNewsFrom.newsFeedPage) {
          await newsFeedController.createCommentFromNewsFeed(postId, postNewsComment?.commentController.text ?? '', file);
        } else if (from == PostNewsFrom.schoolPage) {
          if (isPin) {
            await showPageController.createCommentFromPagePin(postId, postNewsComment?.commentController.text ?? '', file);
          } else {
            await showPageController.createCommentFromPage(postId, postNewsComment?.commentController.text ?? '', file);
          }
        } else if (from == PostNewsFrom.classPage) {
          if (isPin) {
            await showGroupController.createCommentFromGroupPin(postId, postNewsComment?.commentController.text ?? '', file);
          } else {
            await showGroupController.createCommentFromGroup(postId, postNewsComment?.commentController.text ?? '', file);
          }
        } else if (from == PostNewsFrom.personPage) {
          await homePageController.createCommentFromHome(postId, postNewsComment?.commentController.text ?? '', file);
        } else if (from == PostNewsFrom.savedPostPage) {
          await savedPostsController.createCommentFromSavedPost(postId, postNewsComment?.commentController.text ?? '', file);
        }
      } else if (postNewsComment?.commentController.text.isNotEmpty ?? false) {
        if (from == PostNewsFrom.newsFeedPage) {
          await newsFeedController.createCommentFromNewsFeed(postId, postNewsComment?.commentController.text ?? '', Uint8List(0));
        } else if (from == PostNewsFrom.schoolPage) {
          if (isPin) {
            await showPageController.createCommentFromPagePin(postId, postNewsComment?.commentController.text ?? '', Uint8List(0));
          } else {
            await showPageController.createCommentFromPage(postId, postNewsComment?.commentController.text ?? '', Uint8List(0));
          }
        } else if (from == PostNewsFrom.classPage) {
          if (isPin) {
            await showGroupController.createCommentFromGroupPin(postId, postNewsComment?.commentController.text ?? '', Uint8List(0));
          } else {
            await showGroupController.createCommentFromGroup(postId, postNewsComment?.commentController.text ?? '', Uint8List(0));
          }
        } else if (from == PostNewsFrom.personPage) {
          await homePageController.createCommentFromHome(postId, postNewsComment?.commentController.text ?? '', Uint8List(0));
        } else if (from == PostNewsFrom.savedPostPage) {
          await savedPostsController.createCommentFromSavedPost(postId, postNewsComment?.commentController.text ?? '', Uint8List(0));
        }
      }
    }
    
    Future<void> handlePressPickImage(String postId) async {
      if (from == PostNewsFrom.newsFeedPage) {
        await newsFeedController.pickImageNewsFeedFromGallery(postId);
      } else if (from == PostNewsFrom.schoolPage) {
        if (isPin) {
          await showPageController.pickImagePagePinFromGallery(postId);
        } else {
          await showPageController.pickImagePageFromGallery(postId);
        }
      } else if (from == PostNewsFrom.classPage) {
        if (isPin) {
          await showGroupController.pickImageGroupPinFromGallery(postId);
        } else {
          await showGroupController.pickImageGroupFromGallery(postId);
        }
      } else if (from == PostNewsFrom.personPage) {
        await homePageController.pickImageHomeFromGallery(postId);
      } else if (from == PostNewsFrom.savedPostPage) {
        await savedPostsController.pickImageSavedPostFromGallery(postId);
      }
    }
    
    Future<void> handlePressDeleteImagePicked(String postId) async {
      if (from == PostNewsFrom.newsFeedPage) {
        await newsFeedController.deleteImagePickedNewsFeedFromGallery(postId);
      } else if (from == PostNewsFrom.schoolPage) {
        if (isPin) {
          await showPageController.deleteImagePickedPagePinFromGallery(postId);
        } else {
          await showPageController.deleteImagePickedPageFromGallery(postId);
        }
      } else if (from == PostNewsFrom.classPage) {
        if (isPin) {
          await showGroupController.deleteImagePickedGroupPinFromGallery(postId);
        } else {
          await showGroupController.deleteImagePickedGroupFromGallery(postId);
        }
      } else if (from == PostNewsFrom.personPage) {
        await homePageController.deleteImagePickedHomeFromGallery(postId);
      } else if (from == PostNewsFrom.savedPostPage) {
        await savedPostsController.deleteImagePickedSavedPostFromGallery(postId);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(
          () => (from == PostNewsFrom.newsFeedPage 
            ? newsFeedController.isLoadingPickImage.value 
            : from == PostNewsFrom.schoolPage
              ? showPageController.isLoadingPickImage.value
              : from == PostNewsFrom.classPage
                ? showGroupController.isLoadingPickImage.value
                : from == PostNewsFrom.personPage
                  ? homePageController.isLoadingPickImage.value
                  : savedPostsController.isLoadingPickImage.value
          )
            ? Container()
            : (isPin 
              ? (from == PostNewsFrom.schoolPage 
                ? showPageController.pinnedPostCommentData.value?.imagePicked != null
                : showGroupController.pinnedPostCommentData.value?.imagePicked != null)
              : postNewsComment?.imagePicked != null
              )
                ? Padding(
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
                            isPin
                              ? from == PostNewsFrom.schoolPage
                                ? File(showPageController.pinnedPostCommentData.value?.imagePicked?.path ?? '')
                                : File(showGroupController.pinnedPostCommentData.value?.imagePicked?.path ?? '')
                              : File(postNewsComment?.imagePicked?.path ?? ''),
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
                            handlePressDeleteImagePicked(postNews?.post_id ?? '');
                          },
                        )
                      )
                    ],
                  ),
                )
                : Container()
        ),
        Row(
          children: [
            NewsFeedAvatar(imageNetwork: store.userFromStorage?.user_picture),
            SizedBox(width: context.responsive(7.0)),
            Expanded(
              child: TextField(
                controller: postNewsComment?.commentController,
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
                        handlePressPickImage(postNews?.post_id ?? '');
                      },
                      child: Icon(CupertinoIcons.photo, size: context.responsive(22.0), color: HexColor('FF9ACE')),
                    )
                    : null,
                  prefixIconConstraints: BoxConstraints(minWidth: context.responsive(40.0), maxHeight: context.responsive(38.0)),
                  suffixIcon: (postNews?.allow_comment ?? false)
                    ? InkWell(
                      onTap: () {
                        handlePressSendComment(
                          postNews?.post_id ?? '', 
                          isPin 
                            ? from == PostNewsFrom.schoolPage
                              ? showPageController.pinnedPostCommentData.value 
                              : showGroupController.pinnedPostCommentData.value 
                            : postNewsComment
                        );
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
                minLines: 1,
                maxLines: 5,
              )
            ),
          ],
        )
      ],
    );
  }
}