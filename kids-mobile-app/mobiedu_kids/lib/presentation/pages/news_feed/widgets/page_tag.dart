import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/home_page_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/news_feed_search_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/photo_video_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/saved_posts_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_group_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_page_controller.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/class_about_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/friend_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/person_about_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/photo_albums_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/saved_post_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/school_about_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/school_contact_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/school_review_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/video_page.dart';

class PageTag extends StatelessWidget {
  PageTag({
    super.key,
    required this.from,
    required this.name,
  });

  final String from;
  final String name;

  final tagsSchool = ['introduce', 'contact', 'rate', 'image', 'video'];
  final tagsClass = ['introduce', 'image', 'video', 'report'];
  final tagsPerson = ['introduce', 'saved_post', 'image', 'video', 'friend'];

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    final tags = from == PostNewsFrom.schoolPage 
      ? tagsSchool 
      : from == PostNewsFrom.classPage 
        ? tagsClass
        : tagsPerson; 

    return Container(
      width: widthScreen,
      height: context.responsive(30.0),
      padding: EdgeInsets.symmetric(horizontal: context.responsive(22.0)),
      child: Center(
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          separatorBuilder: (context, index) => SizedBox(width: context.responsive(8.0)), 
          itemCount: tags.length,
          itemBuilder: (context, index) {
            return tagItem(context, tags[index]);
          }, 
        ),
      ),
    );
  }

  Widget tagItem(BuildContext context, String tag) {
    var tagName = '';
    switch (tag) {
      case 'introduce':
        tagName = 'Giới thiệu';
        break;
      case 'contact':
        tagName = 'Liên hệ';
        break;
      case 'saved_post':
        tagName = 'Bài viết đã lưu';
        break;
      case 'rate':
        tagName = 'Đánh giá';
        break;
      case 'image':
        tagName = 'Ảnh';
        break;
      case 'video':
        tagName = 'Videos';
        break;
      case 'report':
        tagName = 'Báo cáo';
        break;
      case 'friend':
        tagName = 'Bạn bè';
        break;
      default:
        break;
    }
    return GestureDetector(
      onTap: () {
        handlePressTagItem(tag);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: context.responsive(6.0), horizontal: context.responsive(10.0)),
        decoration: BoxDecoration(
          color: HexColor('FF9ACE'),
          borderRadius: BorderRadius.all(Radius.circular(context.responsive(20.0)))
        ),
        child: Text(
          tagName,
          style: GoogleFonts.raleway(
            textStyle: TextStyle(
              fontSize: context.responsive(14.0), 
              height: context.responsive(1.28), 
              fontWeight: FontWeight.w700, 
              color: HexColor('FFFFFF')
            )
          ),
        ),
      ),
    );
  }
  
  void handlePressTagItem(String tag) {
    switch (tag) {
      case 'introduce':
        if (from == PostNewsFrom.schoolPage) {
          Get.to(
            () => SchoolAboutPage(pageName: name),
            duration: const Duration(milliseconds: 400),
            transition: Transition.rightToLeft
          );
        } else if (from == PostNewsFrom.classPage) {
          Get.to(
            () => ClassAboutPage(className: name),
            duration: const Duration(milliseconds: 400),
            transition: Transition.rightToLeft
          );
        } else if (from == PostNewsFrom.personPage) {
          Get.to(
            () => PersonAboutPage(personName: name),
            duration: const Duration(milliseconds: 400),
            transition: Transition.rightToLeft
          );
        }
        break;
      case 'contact':
        Get.to(
          () => SchoolContactPage(),
          duration: const Duration(milliseconds: 400),
          transition: Transition.rightToLeft
        );
        break;
      case 'saved_post':
        SavedPostsBinding().dependencies();
        Get.to(
          () => SavedPostPage(),
          duration: const Duration(milliseconds: 400),
          transition: Transition.rightToLeft
        );
        break;
      case 'rate':
        Get.to(
          () => SchoolReviewPage(pageName: name),
          duration: const Duration(milliseconds: 400),
          transition: Transition.rightToLeft
        );
        break;
      case 'image':
        PhotoVideoBinding().dependencies();
        if (from == PostNewsFrom.schoolPage) {
          final showPageController = Get.find<ShowPageController>();
          Get.to(
            () => PhotoAlbumsPage(
              typeOwner: TypeGetPhoto.page,
              id: showPageController.infoPageData.value?.school_id,
              name: name
            ),
            duration: const Duration(milliseconds: 400),
            transition: Transition.rightToLeft
          );
        } else if (from == PostNewsFrom.classPage) {
          final showGroupController = Get.find<ShowGroupController>();
          Get.to(
            () => PhotoAlbumsPage(
              typeOwner: TypeGetPhoto.group,
              id: showGroupController.infoGroupData.value?.group_id,
              name: name
            ),
            duration: const Duration(milliseconds: 400),
            transition: Transition.rightToLeft
          );
        } else if (from == PostNewsFrom.personPage) {
          final homePageController = Get.find<HomePageController>(tag: name);
          if ((homePageController.profileData.value?.is_admin ?? false) || (homePageController.profileData.value?.we_friends ?? false)) {
            Get.to(
              () => PhotoAlbumsPage(
                typeOwner: TypeGetPhoto.user,
                id: homePageController.profileData.value?.user_id,
                name: name
              ),
              duration: const Duration(milliseconds: 400),
              transition: Transition.rightToLeft
            );
          } else {
            showSnackbar(SnackbarType.error, 'Thông báo', 'Bạn không có quyền truy cập!');
          }
        }
        break;
      case 'video':
        PhotoVideoBinding().dependencies();
        if (from == PostNewsFrom.schoolPage) {
          final showPageController = Get.find<ShowPageController>();
          Get.to(
            () => VideoPage(
              typeOwner: TypeGetPhoto.page,
              id: showPageController.infoPageData.value?.school_id ?? ''
            ),
            duration: const Duration(milliseconds: 400),
            transition: Transition.rightToLeft
          );
        } else if (from == PostNewsFrom.classPage) {
          final showGroupController = Get.find<ShowGroupController>();
          Get.to(
            () => VideoPage(
              typeOwner: TypeGetPhoto.group,
              id: showGroupController.infoGroupData.value?.group_id ?? ''
            ),
            duration: const Duration(milliseconds: 400),
            transition: Transition.rightToLeft
          );
        } else if (from == PostNewsFrom.personPage) {
          final homePageController = Get.find<HomePageController>(tag: name);
          Get.to(
            () => VideoPage(
              typeOwner: TypeGetPhoto.user,
              id: homePageController.profileData.value?.user_id ?? ''
            ),
            duration: const Duration(milliseconds: 400),
            transition: Transition.rightToLeft
          );
        }
        break;
      case 'report':
        final showGroupController = Get.find<ShowGroupController>();
        showGroupController.reportGroup(showGroupController.infoGroupData.value?.group_id ?? '');
        break;
      case 'friend':
        final homePageController = Get.find<HomePageController>(tag: name);
        if ((homePageController.profileData.value?.is_admin ?? false) || (homePageController.profileData.value?.we_friends ?? false)) {
          NewsFeedSearchBinding().dependencies();
          Get.to(
            () => FriendPage(
              personName: name,
            ),
            duration: const Duration(milliseconds: 400),
            transition: Transition.rightToLeft
          );
        } else {
          showSnackbar(SnackbarType.error, 'Thông báo', 'Bạn không có quyền truy cập!');
        }
        break;
      default:
        break;
    }
  }
}