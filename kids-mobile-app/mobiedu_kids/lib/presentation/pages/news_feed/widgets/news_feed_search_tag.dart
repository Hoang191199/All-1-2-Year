import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/news_feed_search_detail_group_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/news_feed_search_detail_post_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/news_feed_search_detail_school_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/news_feed_search_detail_user_page.dart';

class NewsFeedSearchTag extends StatelessWidget {
  NewsFeedSearchTag({super.key});

  final tags = ['posts', 'groups', 'pages', 'users'];

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    return SizedBox(
      width: widthScreen,
      height: context.responsive(30.0),
      child: Center(
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          separatorBuilder: (context, index) => SizedBox(width: context.responsive(6.0)), 
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
      case 'posts':
        tagName = 'Bài viết';
        break;
      case 'groups':
        tagName = 'Nhóm';
        break;
      case 'pages':
        tagName = 'Trang';
        break;
      case 'users':
        tagName = 'Người dùng';
        break;
      default:
        break;
    }
    return InkWell(
      onTap: () {
        handlePressSearchTag(tag);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: context.responsive(6.0), horizontal: context.responsive(25.0)),
        decoration: BoxDecoration(
          color: HexColor('FFF4FA'),
          borderRadius: BorderRadius.all(Radius.circular(context.responsive(20.0)))
        ),
        child: Text(
          tagName,
          style: GoogleFonts.raleway(
            textStyle: TextStyle(
              fontSize: context.responsive(14.0), 
              height: context.responsive(1.28), 
              fontWeight: FontWeight.w500, 
              color: HexColor('783199')
            )
          ),
        ),
      ),
    );
  }
  
  void handlePressSearchTag(String tag) {
    switch (tag) {
      case 'posts':
        Get.to(
          () => NewsFeedSearchDetailPostPage(),
          duration: const Duration(milliseconds: 400),
          transition: Transition.rightToLeft
        );
        break;
      case 'groups':
        Get.to(
          () => NewsFeedSearchDetailGroupPage(),
          duration: const Duration(milliseconds: 400),
          transition: Transition.rightToLeft
        );
        break;
      case 'pages':
        Get.to(
          () => NewsFeedSearchDetailSchoolPage(),
          duration: const Duration(milliseconds: 400),
          transition: Transition.rightToLeft
        );
        break;
      case 'users':
        Get.to(
          () => NewsFeedSearchDetailUserPage(),
          duration: const Duration(milliseconds: 400),
          transition: Transition.rightToLeft
        );
        break;
      default:
        break;
    }
  }
}