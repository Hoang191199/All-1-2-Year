import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/album.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/post_news.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/home_page_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/photo_video_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_page_binding.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/album_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/class_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/person_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/school_page.dart';

class NewsFeedSectionItemTitle extends StatelessWidget {
  const NewsFeedSectionItemTitle({
    super.key,
    required this.from,
    this.postNews,
  });

  final String from;
  final PostNews? postNews;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
              text: postNews?.post_author_name ?? '',
              style: styleTitle1(context),
              recognizer: TapGestureRecognizer()..onTap = () {
                handlePressPostAuthorName(postNews);
              },
              children: [
                if (postNews?.post_type == PostTypeNews.photos)
                  TextSpan(
                    text: ' đã thêm ${postNews?.photos_num} ảnh mới',
                    style: styleTitle2(context)
                  ),
                if (postNews?.post_type == PostTypeNews.album)
                  TextSpan(
                    text: ' đã thêm ${postNews?.photos_num} ảnh vào album',
                    style: styleTitle2(context)
                  ),
                if (postNews?.post_type == PostTypeNews.album)
                  TextSpan(
                    text: ' ${postNews?.album?.title ?? ''}',
                    style: styleTitle1(context),
                    recognizer: TapGestureRecognizer()..onTap = () {
                      handlePressAlbumTitle(postNews?.album);
                    }
                  ),
                if (postNews?.post_type == PostTypeNews.video)
                  TextSpan(
                    text: ' thêm một video',
                    style: styleTitle2(context)
                  ),
                if (postNews?.post_type == PostTypeNews.pagePicture)
                  TextSpan(
                    text: ' cập nhật ảnh đại diện của trang',
                    style: styleTitle2(context)
                  ),
                if (postNews?.post_type == PostTypeNews.pageCover)
                  TextSpan(
                    text: ' cập nhật ảnh bìa của trang',
                    style: styleTitle2(context)
                  ),
                if (postNews?.post_type == PostTypeNews.groupPicture || postNews?.post_type == PostTypeNews.profilePicture)
                  TextSpan(
                    text: ' cập nhật ảnh đại diện',
                    style: styleTitle2(context)
                  ),
                if (postNews?.post_type == PostTypeNews.groupCover || postNews?.post_type == PostTypeNews.profileCover)
                  TextSpan(
                    text: ' cập nhật ảnh bìa',
                    style: styleTitle2(context)
                  ),
                if (postNews?.post_type == PostTypeNews.shared)
                  TextSpan(
                    text: ' đã chia sẻ',
                    style: styleTitle2(context),
                    children: [
                      if (postNews?.origin?.post_type == PostTypeNews.video)
                        TextSpan(
                          text: ' Video',
                          style: styleTitle1(context),
                        ),
                      // if (postNews?.origin?.post_type == PostTypeNews.ciEvent)
                      if (postNews?.origin?.post_type != PostTypeNews.ciEvent)
                        TextSpan(
                          text: ' bài viết',
                          style: styleTitle1(context),
                        ),
                      TextSpan(
                        text: ' của ',
                        style: styleTitle2(context),
                      ),
                      TextSpan(
                        text: postNews?.origin?.post_author_name ?? '',
                        style: styleTitle1(context),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          handlePressPostAuthorName(postNews?.origin);
                        },
                      )
                    ]
                  ),
                if (from != PostNewsFrom.classPage && postNews?.group_title != null && (postNews?.group_title?.isNotEmpty ?? false))
                  TextSpan(
                    text: ' ➜ ',
                    style: styleTitle3(context),
                  ),
                if (from != PostNewsFrom.classPage && postNews?.group_title != null && (postNews?.group_title?.isNotEmpty ?? false))
                  TextSpan(
                    text: postNews?.group_title ?? '',
                    style: styleTitle1(context),
                    recognizer: TapGestureRecognizer()..onTap = () {
                      handlePressGroupTitle();
                    }
                  )
              ]
            )
          )
        ),
      ],
    );
  }

  TextStyle styleTitle1(BuildContext context) {
    return GoogleFonts.raleway(
      textStyle: TextStyle(
        fontSize: context.responsive(14.0), 
        height: context.responsive(1.3), 
        fontWeight: FontWeight.w700, 
        color: HexColor('464646')
      )
    );
  }

  TextStyle styleTitle2(BuildContext context) {
    return GoogleFonts.raleway(
      textStyle: TextStyle(
        fontSize: context.responsive(14.0), 
        height: context.responsive(1.3), 
        fontWeight: FontWeight.w500, 
        color: HexColor('464646')
      )
    );
  }

  TextStyle styleTitle3(BuildContext context) {
    return GoogleFonts.raleway(
      textStyle: TextStyle(
        fontSize: context.responsive(16.0), 
        height: context.responsive(1.3), 
        fontWeight: FontWeight.w500, 
        color: HexColor('FF9ACE')
      )
    );
  }
  
  void handlePressPostAuthorName(PostNews? postNewsData) {
    if (postNewsData?.user_type == UserTypePostNews.user) {
      HomePageBinding(postNewsData?.user_name ?? '').dependencies();
      Get.to(
        () => PersonPage(
          personName: postNewsData?.user_name ?? '',
          personFullName: postNewsData?.user_fullname ?? '',
        ),
        duration: const Duration(milliseconds: 400),
        transition: Transition.rightToLeft
      );
    } else if (postNewsData?.user_type == UserTypePostNews.page) {
      ShowPageBinding().dependencies();
      Get.to(
        () => SchoolPage(
          pageTitle: postNewsData?.page_title ?? '',
          pageName: postNewsData?.page_name ?? '',
          pageId: postNewsData?.page_id ?? '',
        ),
        duration: const Duration(milliseconds: 400),
        transition: Transition.rightToLeft
      );
    }
  }
  
  void handlePressGroupTitle() {
    Get.to(
      () => ClassPage(
        classTitle: postNews?.group_title ?? '',
        className: postNews?.group_name ?? '',
        classId: postNews?.group_id ?? '',
      ),
      duration: const Duration(milliseconds: 400),
      transition: Transition.rightToLeft
    );
  }
  
  void handlePressAlbumTitle(Album? album) {
    PhotoVideoBinding().dependencies();
    Get.to(
      () => AlbumPage(
        typeOwner: album?.in_group == '0' ? TypeGetPhoto.page : TypeGetPhoto.group,
        username: album?.in_group == '0' ? album?.page_name ?? '' : album?.group_name ?? '',
        albumId: album?.album_id ?? '',
        albumName: getAlbumTitle(album?.title ?? ''),
      ),
      duration: const Duration(milliseconds: 400),
      transition: Transition.rightToLeft
    );
  }
}