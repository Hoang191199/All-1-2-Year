import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/image_video_picked.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/home_page_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/news_feed_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/saved_posts_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_group_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_page_controller.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_avatar.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/video_post.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class CreateEditPostPage extends StatelessWidget {
  CreateEditPostPage({
    super.key,
    required this.from,
    this.personName,
    required this.type,
  });

  final String from;
  final String? personName;
  final String type;

  final store = Get.find<LocalStorageService>();
  final newsFeedController = Get.find<NewsFeedController>();
  final showPageController = Get.find<ShowPageController>();
  final showGroupController = Get.find<ShowGroupController>();
  final savedPostsController = Get.find<SavedPostsController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    final homePageController = Get.find<HomePageController>(tag: personName);

    Future<void> handlePressSubmit() async {
      if (from == PostNewsFrom.newsFeedPage) {
        if (type == 'edit') {
          await newsFeedController.editPostFromNewsFeed();
        }
      } else if (from == PostNewsFrom.schoolPage) {
        if (type == 'edit') {
          await showPageController.editPostFromPage();
        } else if (type == 'create') {
          if (showPageController.textCreateEditPostController.text.isNotEmpty || showPageController.listImageVideoCreatePost.isNotEmpty) {
            await showPageController.createPostFromPage();
          }
        }
      } else if (from == PostNewsFrom.classPage) {
        if (type == 'edit') {
          await showGroupController.editPostFromGroup();
        } else if (type == 'create') {
          if (showGroupController.textCreateEditPostController.text.isNotEmpty || showGroupController.listImageVideoCreatePost.isNotEmpty) {
            await showGroupController.createPostFromGroup();
          }
        }
      } else if (from == PostNewsFrom.personPage) {
        if (type == 'edit') {
          await homePageController.editPostFromHome();
        }
      } else if (from == PostNewsFrom.savedPostPage) {
        if (type == 'edit') {
          await savedPostsController.editPostFromHome();
        }
      }
    }

    return WillPopScope(
      onWillPop: onWillPop,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          backgroundColor: HexColor('FFFFFF'),
          body: Container(
            padding: EdgeInsets.only(top: statusBarHeight + context.responsive(10.0)),
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: context.responsive(12.0), 
                        left: context.responsive(28.0), 
                        right: context.responsive(28.0)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                handlePressCancel();
                              },
                              child: Text(
                                'Hủy',
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(fontSize: context.responsive(16.0), fontWeight: FontWeight.w700, color: HexColor('F67882'))
                                ),
                                textAlign: TextAlign.start,
                              ),
                            )
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Tạo bài viết',
                              style: GoogleFonts.raleway(
                                textStyle: TextStyle(fontSize: context.responsive(16.0), fontWeight: FontWeight.w700, color: HexColor('6F6F6F'))
                              ),
                              textAlign: TextAlign.center,
                            )
                          ),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                handlePressSubmit();
                              },
                              child: Text(
                                'Đăng',
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(fontSize: context.responsive(16.0), fontWeight: FontWeight.w700, color: HexColor('783199'))
                                ),
                                textAlign: TextAlign.end,
                              ),
                            )
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: context.responsive(20.0)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.responsive(28.0)),
                      child: Row(
                        children: [
                          NewsFeedAvatar(imageNetwork: store.userFromStorage?.user_picture),
                          SizedBox(width: context.responsive(8.0)),
                          Text(
                            store.userFromStorage?.user_fullname ?? '',
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w700, color: HexColor('464646'))
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: context.responsive(16.0)),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: context.responsive(28.0)),
                        child: Column(
                          children: [
                            TextField(
                              controller: from == PostNewsFrom.newsFeedPage 
                                ? newsFeedController.textCreateEditPostController 
                                : from == PostNewsFrom.schoolPage
                                  ? showPageController.textCreateEditPostController
                                  : from == PostNewsFrom.classPage
                                    ? showGroupController.textCreateEditPostController
                                    : from == PostNewsFrom.personPage
                                      ? homePageController.textCreateEditPostController
                                      : savedPostsController.textCreateEditPostController,
                              // autofocus: type == 'edit',
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: InputDecoration(
                                hintText: type == 'create' ? 'Nhập nội dung...' : '',
                                hintStyle: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    fontSize: context.responsive(14.0), 
                                    height: context.responsive(1.5), 
                                    fontWeight: FontWeight.w500, 
                                    color: HexColor('464646')
                                  )
                                ),
                                filled: true,
                                fillColor: HexColor('FFFFFF'),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 0, 
                                    style: BorderStyle.none,
                                  )
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.all(context.responsive(4.0)),
                              ),
                              cursorColor: HexColor('464646'),
                              style: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                  fontSize: context.responsive(14.0), 
                                  height: context.responsive(1.5), 
                                  fontWeight: FontWeight.w500, 
                                  color: HexColor('464646'), 
                                  decorationThickness: 0.0
                                )
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              minLines: 1,
                              maxLines: context.responsive(10),
                            ),
                            SizedBox(height: context.responsive(20.0)),
                            if (type == 'create')
                              Obx(
                                () => (from == PostNewsFrom.schoolPage
                                  ? showPageController.listImageVideoCreatePost.isNotEmpty
                                  : showGroupController.listImageVideoCreatePost.isNotEmpty
                                )
                                  ? SizedBox(
                                    width: widthScreen,
                                    height: context.responsive(160.0),
                                    child: ListView.separated(
                                      controller: from == PostNewsFrom.schoolPage
                                        ? showPageController.scrollCreatePostController
                                        : showGroupController.scrollCreatePostController,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                                      separatorBuilder: (context, index) => SizedBox(width: context.responsive(6.0)), 
                                      itemCount: from == PostNewsFrom.schoolPage
                                        ? showPageController.listImageVideoCreatePost.length
                                        : showGroupController.listImageVideoCreatePost.length,
                                      itemBuilder: (context, index) {
                                        final imageVideoItem = from == PostNewsFrom.schoolPage
                                          ? showPageController.listImageVideoCreatePost[index]
                                          : showGroupController.listImageVideoCreatePost[index];
                                        return Stack(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                0.0, 
                                                context.responsive(10.0), 
                                                context.responsive(10.0), 
                                                0.0
                                              ),
                                              child: imageVideoItem.type == 'image'
                                                ? Image.file(
                                                  from == PostNewsFrom.schoolPage
                                                    ? File(imageVideoItem.file.path)
                                                    : File(imageVideoItem.file.path),
                                                  width: context.responsive(140.0),
                                                  height: context.responsive(140.0),
                                                  fit: BoxFit.cover,
                                                )
                                                : Container(
                                                  width: context.responsive(140.0),
                                                  height: context.responsive(140.0),
                                                  decoration: const BoxDecoration(
                                                    color: Colors.black
                                                  ),
                                                  child: VideoPost(
                                                    fileType: VideoFileType.storage, 
                                                    filePath: imageVideoItem.file.path,
                                                  ),
                                                ),
                                            ),
                                            Positioned(
                                              top: 0.0,
                                              right: 0.0,
                                              child: InkWell(
                                                child: Icon(CupertinoIcons.xmark_circle_fill, size: context.responsive(24.0), color: Colors.black),
                                                onTap: () {
                                                  handlePressDeleteImageVideoItem(imageVideoItem);
                                                },
                                              )
                                            )
                                          ],
                                        );
                                      },
                                    ),
                                  )
                                  : Container()
                              ),
                          ],
                        ),
                      )
                    ),
                    if (type == 'create')
                      Container(
                        padding: EdgeInsets.symmetric(vertical: context.responsive(12.0), horizontal: context.responsive(28.0)),
                        decoration: BoxDecoration(
                          border: Border(top: BorderSide(color: HexColor('D8D8D8')))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Sử dụng thêm tính năng',
                              style: GoogleFonts.raleway(
                                textStyle: TextStyle(fontSize: context.responsive(16.0), fontWeight: FontWeight.w700, color: HexColor('6F6F6F'))
                              ),
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    handlePressPickImage();
                                  },
                                  child: Icon(CupertinoIcons.photo, size: context.responsive(28.0), color: HexColor('000000')),
                                ),
                                SizedBox(width: context.responsive(8.0)),
                                InkWell(
                                  onTap: () {
                                    handlePressPickVideo();
                                  },
                                  child: FaIcon(FontAwesomeIcons.video, size: context.responsive(28.0), color: HexColor('000000')),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                  ],
                ),
                Obx(
                  () => showPageController.isLoadingCreatePost.value || showGroupController.isLoadingCreatePost.value
                    ? Opacity(
                      opacity: 0.5,
                      child: Container(
                        width: widthScreen,
                        height: heightScreen,
                        color: HexColor('D8D8D8'),
                        child: const Center(
                          child: CircularLoadingIndicator(),
                        ),
                      ),
                    )
                    : Container()
                )
              ],
            ),
          ),
        ),
      ), 
    );
  }

  Future<bool> onWillPop() async {
    if (from == PostNewsFrom.schoolPage) {
      showPageController.clearCreatePost();
    } else if (from == PostNewsFrom.classPage) {
      showGroupController.clearCreatePost();
    }
    return true;
  }
  
  void handlePressCancel() {
    FocusManager.instance.primaryFocus?.unfocus();
    Get.back();
    if (from == PostNewsFrom.schoolPage) {
      showPageController.clearCreatePost();
    } else if (from == PostNewsFrom.classPage) {
      showGroupController.clearCreatePost();
    }
  }

  Future<void> handlePressPickImage() async {
    if (from == PostNewsFrom.schoolPage) {
      await showPageController.pickImageCreatePostFromGallery();
    } else if (from == PostNewsFrom.classPage) {
      await showGroupController.pickImageCreatePostFromGallery();
    }
  }

  Future<void> handlePressPickVideo() async {
    if (from == PostNewsFrom.schoolPage) {
      await showPageController.pickVideoCreatePostFromGallery();
    } else if (from == PostNewsFrom.classPage) {
      await showGroupController.pickVideoCreatePostFromGallery();
    }
  }

  Future<void> handlePressDeleteImageVideoItem(ImageVideoPicked imageVideoItem) async {
    if (from == PostNewsFrom.schoolPage) {
      await showPageController.deleteImageVideoItem(imageVideoItem);
    } else if (from == PostNewsFrom.classPage) {
      await showGroupController.deleteImageVideoItem(imageVideoItem);
    }
  }
}