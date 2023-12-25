import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/post_news.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/news_feed_post_detail_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_avatar.dart';

class NewsFeedSearchPostItem extends StatelessWidget {
  const NewsFeedSearchPostItem({
    super.key,
    this.post
  });

  final PostNews? post;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        handlePressItem(post);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: context.responsive(14.0)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.responsive(28.0)),
            child: Row(
              children: [
                NewsFeedAvatar(imageNetwork: post?.post_author_picture ?? ''),
                SizedBox(width: context.responsive(8.0)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post?.post_author_name ?? '',
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            fontSize: context.responsive(14.0), 
                            height: context.responsive(1.3), 
                            fontWeight: FontWeight.w700, 
                            color: HexColor('464646')
                          )
                        ),
                      ),
                      SizedBox(height: context.responsive(5.0)),
                      Text(
                        dayAndDate(post?.time ?? ''),
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            fontSize: context.responsive(11.0), 
                            height: context.responsive(1.36), 
                            fontWeight: FontWeight.w500, 
                            color: HexColor('6F6F6F')
                          )
                        ),
                      )
                    ],
                  )
                )
              ],
            ),
          ),
          SizedBox(height: context.responsive(12.0)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.responsive(20.0)),
            child: Html(
              data: post?.text ?? '',
              style: {
                'body': Style(
                  lineHeight: LineHeight(context.responsive(1.6)),
                  fontSize: FontSize(context.responsive(14.0)),
                  color: HexColor('464646'),
                  fontFamily: 'Raleway',
                  margin: Margins.zero,
                  padding: HtmlPaddings.zero
                )
              }
            ),
          ),
          SizedBox(height: context.responsive(12.0)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.responsive(28.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    post?.i_like ?? false
                      ? Icon(CupertinoIcons.heart_fill, size: context.responsive(20.0), color: HexColor('F67882'))
                      : Icon(CupertinoIcons.heart, size: context.responsive(20.0), color: HexColor('6F6F6F')),
                    SizedBox(width: context.responsive(8.0)),
                    Text(
                      'Thích',
                      style: GoogleFonts.raleway(
                        textStyle: post?.i_like ?? false
                          ? TextStyle(fontSize: context.responsive(12.0), fontWeight: FontWeight.w700, color: HexColor('F67882'))
                          : TextStyle(fontSize: context.responsive(12.0), fontWeight: FontWeight.w500, color: HexColor('6F6F6F')),
                      )
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(CupertinoIcons.bubble_left, size: context.responsive(20.0), color: HexColor('6F6F6F')),
                    SizedBox(width: context.responsive(8.0)),
                    Text(
                      'Bình luận',
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(fontSize: context.responsive(12.0), fontWeight: FontWeight.w500, color: HexColor('6F6F6F'))
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.share_outlined, size: context.responsive(20.0), color: HexColor('6F6F6F')),
                    SizedBox(width: context.responsive(8.0)),
                    Text(
                      'Chia sẻ',
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(fontSize: context.responsive(12.0), fontWeight: FontWeight.w500, color: HexColor('6F6F6F'))
                      ),
                      textAlign: TextAlign.end,
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: context.responsive(14.0)),
        ],
      ),
    );
  }
  
  void handlePressItem(PostNews? post) {
    Get.to(
      () => NewsFeedPostDetailPage(
        from: PostNewsFrom.newsFeedPage,
        postId: post?.post_id ?? ''
      ),
      duration: const Duration(milliseconds: 400),
      transition: Transition.rightToLeft
    );
  }
}