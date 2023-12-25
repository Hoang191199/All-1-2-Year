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
import 'package:mobiedu_kids/presentation/pages/news_feed/create_edit_post_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_delete.dart';
import 'package:mobiedu_kids/presentation/widgets/horizontal_divider_no_padding.dart';

void showNewsFeedSectionItemAction(BuildContext context, String from, String? personName, PostNews? postNews) {
  double widthScreen = MediaQuery.of(context).size.width;

  final store = Get.find<LocalStorageService>();
  final newsFeedController = Get.find<NewsFeedController>();
  final showPageController = Get.find<ShowPageController>();
  final showGroupController = Get.find<ShowGroupController>();
  final homePageController = Get.find<HomePageController>(tag: personName);
  final savedPostsController = Get.find<SavedPostsController>();

  Future<void> handlePressNewsFeedAction(String action) async {
    Navigator.pop(context, 'OK');
    switch (action) {
      case 'delete':
        showDialog(
          context: context, 
          builder: (context) {
            return NewsFeedDelete(
              from: from,
              postId: postNews?.post_id ?? '',
              personName: personName,
            );
          },
        );
        break;
      case 'follow':
        if (from == PostNewsFrom.newsFeedPage) {
          await newsFeedController.friendsConnectFollow(postNews?.author_id ?? '', ActionFriendsConnect.follow);
        } else if (from == PostNewsFrom.schoolPage) {
          await showPageController.friendsConnectFollow(postNews?.author_id ?? '', ActionFriendsConnect.follow);
        } else if (from == PostNewsFrom.classPage) {
          await showGroupController.friendsConnectFollow(postNews?.author_id ?? '', ActionFriendsConnect.follow);
        } else if (from == PostNewsFrom.personPage) {
          await homePageController.friendsConnectFollow(postNews?.author_id ?? '', ActionFriendsConnect.follow);
        } else if (from == PostNewsFrom.savedPostPage) {
          await savedPostsController.friendsConnectFollow(postNews?.author_id ?? '', ActionFriendsConnect.follow);
        }
        break;
      case 'unfollow':
        if (from == PostNewsFrom.newsFeedPage) {
          await newsFeedController.friendsConnectFollow(postNews?.author_id ?? '', ActionFriendsConnect.unfollow);
        } else if (from == PostNewsFrom.schoolPage) {
          await showPageController.friendsConnectFollow(postNews?.author_id ?? '', ActionFriendsConnect.unfollow);
        } else if (from == PostNewsFrom.classPage) {
          await showGroupController.friendsConnectFollow(postNews?.author_id ?? '', ActionFriendsConnect.unfollow);
        } else if (from == PostNewsFrom.personPage) {
          await homePageController.friendsConnectFollow(postNews?.author_id ?? '', ActionFriendsConnect.unfollow);
        } else if (from == PostNewsFrom.savedPostPage) {
          await savedPostsController.friendsConnectFollow(postNews?.author_id ?? '', ActionFriendsConnect.unfollow);
        }
        break;
      case 'hide':
        if (from == PostNewsFrom.newsFeedPage) {
          await newsFeedController.postActionHidePost(postNews?.post_id ?? '');
        } else if (from == PostNewsFrom.schoolPage) {
          await showPageController.postActionHidePost(postNews?.post_id ?? '');
        } else if (from == PostNewsFrom.classPage) {
          await showGroupController.postActionHidePost(postNews?.post_id ?? '');
        } else if (from == PostNewsFrom.personPage) {
          await homePageController.postActionHidePost(postNews?.post_id ?? '');
        } else if (from == PostNewsFrom.savedPostPage) {
          await savedPostsController.postActionHidePost(postNews?.post_id ?? '');
        }
        break;
      case 'report':
        if (from == PostNewsFrom.newsFeedPage) {
          await newsFeedController.reportPost(postNews?.post_id ?? '');
        } else if (from == PostNewsFrom.schoolPage) {
          await showPageController.reportPost(postNews?.post_id ?? '');
        } else if (from == PostNewsFrom.classPage) {
          await showGroupController.reportPost(postNews?.post_id ?? '');
        } else if (from == PostNewsFrom.personPage) {
          await homePageController.reportPost(postNews?.post_id ?? '');
        } else if (from == PostNewsFrom.savedPostPage) {
          await savedPostsController.reportPost(postNews?.post_id ?? '');
        }
        break;
      case 'save':
        if (from == PostNewsFrom.newsFeedPage) {
          await newsFeedController.postActionSavePost(postNews?.post_id ?? '');
        } else if (from == PostNewsFrom.schoolPage) {
          await showPageController.postActionSavePost(postNews?.post_id ?? '');
        } else if (from == PostNewsFrom.classPage) {
          await showGroupController.postActionSavePost(postNews?.post_id ?? '');
        } else if (from == PostNewsFrom.personPage) {
          await homePageController.postActionSavePost(postNews?.post_id ?? '');
        } else if (from == PostNewsFrom.savedPostPage) {
          await savedPostsController.postActionSavePost(postNews?.post_id ?? '');
        }
        break;
      case 'pin':
        if (from == PostNewsFrom.schoolPage) {
          await showPageController.postActionPinPost(postNews?.post_id ?? '');
        } else if (from == PostNewsFrom.classPage) {
          await showGroupController.postActionPinPost(postNews?.post_id ?? '');
        }
        break;
      case 'unpin':
        if (from == PostNewsFrom.schoolPage) {
          await showPageController.postActionUnPinPost(postNews?.post_id ?? '');
        } else if (from == PostNewsFrom.classPage) {
          await showGroupController.postActionUnPinPost(postNews?.post_id ?? '');
        }
        break;
      case 'edit':
        if (from == PostNewsFrom.newsFeedPage) {
          newsFeedController.postNewsEdit.value = postNews;
          newsFeedController.textCreateEditPostController.text = postNews?.text ?? '';
          Get.to(
            () => CreateEditPostPage(
              from: PostNewsFrom.newsFeedPage,
              type: 'edit'
            ),
            duration: const Duration(milliseconds: 400),
            transition: Transition.rightToLeft
          );
        } else if (from == PostNewsFrom.schoolPage) {
          showPageController.postNewsEdit.value = postNews;
          showPageController.textCreateEditPostController.text = postNews?.text ?? '';
          Get.to(
            () => CreateEditPostPage(
              from: PostNewsFrom.schoolPage,
              type: 'edit'
            ),
            duration: const Duration(milliseconds: 400),
            transition: Transition.rightToLeft
          );
        } else if (from == PostNewsFrom.classPage) {
          showGroupController.postNewsEdit.value = postNews;
          showGroupController.textCreateEditPostController.text = postNews?.text ?? '';
          Get.to(
            () => CreateEditPostPage(
              from: PostNewsFrom.classPage,
              type: 'edit'
            ),
            duration: const Duration(milliseconds: 400),
            transition: Transition.rightToLeft
          );
        } else if (from == PostNewsFrom.personPage) {
          homePageController.postNewsEdit.value = postNews;
          homePageController.textCreateEditPostController.text = postNews?.text ?? '';
          Get.to(
            () => CreateEditPostPage(
              from: PostNewsFrom.personPage,
              personName: personName,
              type: 'edit'
            ),
            duration: const Duration(milliseconds: 400),
            transition: Transition.rightToLeft
          );
        } else if (from == PostNewsFrom.savedPostPage) {
          savedPostsController.postNewsEdit.value = postNews;
          savedPostsController.textCreateEditPostController.text = postNews?.text ?? '';
          Get.to(
            () => CreateEditPostPage(
              from: PostNewsFrom.savedPostPage,
              type: 'edit'
            ),
            duration: const Duration(milliseconds: 400),
            transition: Transition.rightToLeft
          );
        }
        break;
      default:
        break;
    }
  }

  Widget actionItem(String action) {
    var actionName = '';
    switch (action) {
      case 'pin':
        actionName = 'Ghim bài viết';
        break;
      case 'unpin':
        actionName = 'Bỏ ghim';
        break;
      case 'edit':
        actionName = 'Sửa bài viết';
        break;
      case 'delete':
        actionName = 'Xóa bài viết';
        break;
      case 'follow':
        actionName = 'Theo dõi ${postNews?.post_author_name}';
        break;
      case 'unfollow':
        actionName = 'Bỏ theo dõi ${postNews?.post_author_name}';
        break;
      case 'hide':
        actionName = 'Ẩn bài viết';
        break;
      case 'report':
        actionName = 'Báo cáo bài viết';
        break;
      case 'save':
        actionName = 'Lưu bài viết';
        break;
      default:
        break;
    }
    return InkWell(
      onTap: () {
        handlePressNewsFeedAction(action);
      },
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(vertical: context.responsive(16.0)),
        child: Text(
          actionName,
          style: GoogleFonts.raleway(
            textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w500, color: HexColor('6F6F6F'))
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(context.responsive(15.0)),
      ),
    ),
    backgroundColor: HexColor('FFFFFF'),
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: context.responsive(8.0)),
          Opacity(
            opacity: 0.25,
            child: Container(
              width: context.responsive(42.0),
              height: context.responsive(3.0),
              decoration: BoxDecoration(
                color: HexColor('DFD9D9'),
                borderRadius: BorderRadius.all(Radius.circular(context.responsive(3.0))),
              ),
            ),
          ),
          SizedBox(height: context.responsive(10.0)),
          store.userFromStorage?.user_id == postNews?.author_id
            ? Column(
              children: [
                if (from == PostNewsFrom.schoolPage)
                  Column(
                    children: [
                      actionItem((postNews?.pinned ?? false) ? 'unpin' : 'pin'),
                      const HorizontalDividerNoPadding(),
                    ],
                  ),
                actionItem('edit'),
                const HorizontalDividerNoPadding(),
                actionItem('delete'),
              ],
            )
            : Column(
              children: [
                if (postNews?.user_type != UserTypePostNews.page)
                  Column(
                    children: [
                      actionItem((postNews?.i_follow ?? false) ? 'unfollow' : 'follow'),
                      const HorizontalDividerNoPadding(),
                    ],
                  ),
                actionItem('hide'),
                const HorizontalDividerNoPadding(),
                actionItem('report'),
                const HorizontalDividerNoPadding(),
                actionItem('save'),
              ],
            ),
          const HorizontalDividerNoPadding(),
          Container(
            width: widthScreen,
            height: context.responsive(50.0),
            padding: EdgeInsets.symmetric(horizontal: context.responsive(28.0)),
            margin: EdgeInsets.symmetric(vertical: context.responsive(20.0)),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(context.responsive(10.0)))
                ),
                elevation: 0.0,
                backgroundColor: HexColor('F67882'),
                textStyle: GoogleFonts.raleway(
                  textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w700, color: HexColor('FFFFFF'))
                )
              ),
              child: const Text('Hủy')
            ),
          )
        ],
      );
    },
  );
}

