import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/post_news.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/news_feed_post_detail_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_avatar.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_section_item_comment.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_section_item_action.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_section_item_image.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_section_item_like_comment_view.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_section_item_text.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_section_item_title.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/video_post.dart';
import 'package:mobiedu_kids/presentation/widgets/horizontal_divider_no_padding.dart';

class NewsFeedSectionItem extends StatelessWidget {
  const NewsFeedSectionItem({
    super.key,
    required this.from,
    this.personName,
    this.postNews,
    required this.isShare,
    required this.isPin,
  });

  final String from;
  final String? personName;
  final PostNews? postNews;
  final bool isShare;
  final bool isPin;

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(vertical: context.responsive(16.0)),
      decoration: BoxDecoration(
        color: HexColor('FFF4FA'),
        borderRadius: BorderRadius.all(Radius.circular(context.responsive(10.0))),
        boxShadow: [
          BoxShadow(
            color: const Color(0x1A000000), 
            blurRadius: context.responsive(10.0), 
            offset: Offset(0.0, context.responsive(4.0))
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.responsive(20.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NewsFeedAvatar(imageNetwork: postNews?.post_author_picture),
                    SizedBox(width: context.responsive(11.0)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NewsFeedSectionItemTitle(
                            from: from,
                            postNews: postNews
                          ),
                          Text(
                            dayAndDate(postNews?.time ?? ''),
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
                    ),
                    SizedBox(width: context.responsive(8.0)),
                    if (!isShare)
                      InkWell(
                        child: Padding(
                          padding: EdgeInsets.all(context.responsive(2.0)),
                          child: Icon(CupertinoIcons.ellipsis, size: context.responsive(24.0), color: HexColor('6F6F6F')),
                        ),
                        onTap: () {
                          handlePressAction(context, postNews);
                        },
                      ),
                  ],
                ),
                if (postNews?.text?.isNotEmpty ?? false)
                  InkWell(
                    onTap: isShare ? null : () {
                      handlePressComments(postNews);
                    },
                    child: Column(
                      children: [
                        SizedBox(height: context.responsive(8.0)),
                        NewsFeedSectionItemText(postNews: postNews),
                      ],
                    ),
                  ),
                if (postNews?.post_type == PostTypeNews.shared)
                  Column(
                    children: [
                      SizedBox(height: context.responsive(8.0)),
                      NewsFeedSectionItem(
                        from: from,
                        postNews: postNews?.origin,
                        isShare: true,
                        isPin: false,
                      )
                    ],
                  ),
                if (postNews?.photos_num != null && (postNews?.photos_num ?? 0) > 0)
                  InkWell(
                    onTap: isShare ? null : () {
                      // handlePressComments(postNews);
                    },
                    child: Column(
                      children: [
                        SizedBox(height: context.responsive(8.0)),
                        NewsFeedSectionItemImage(postNews: postNews)
                      ],
                    ),
                  ),
                if (postNews?.post_type == PostTypeNews.video)
                  InkWell(
                    onTap: isShare ? null : () {
                      // handlePressComments(postNews);
                    },
                    child: Column(
                      children: [
                        SizedBox(height: context.responsive(8.0)),
                        (postNews?.video?.source?.isNotEmpty ?? false)
                          ? Container(
                            width: widthScreen,
                            height: widthScreen * 9 / 16,
                            decoration: const BoxDecoration(
                              color: Colors.black
                            ),
                            child: VideoPost(
                              fileType: VideoFileType.network,
                              filePath: postNews?.video?.source ?? '',
                            ),
                          )
                          : Container()
                      ],
                    ),
                  ),
              ],
            ),
          ),
          if (!isShare)
            Column(
              children: [
                SizedBox(height: context.responsive(18.0)),
                const HorizontalDividerNoPadding(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.responsive(20.0)),
                  child: Column(
                    children: [
                      NewsFeedSectionItemLikeCommentView(
                        from: from,
                        personName: personName,
                        postNews: postNews
                      ),
                      NewsFeedSectionItemComment(
                        from: from,
                        personName: personName,
                        postNews: postNews,
                        isPin: isPin,
                      )
                    ],
                  )
                )
              ],
            )
        ],
      ),
    );
  }
  
  void handlePressAction(BuildContext context, PostNews? postNews) {
    showNewsFeedSectionItemAction(context, from, personName, postNews);
  }

  void handlePressComments(PostNews? postNews) {
    Get.to(
      () => NewsFeedPostDetailPage(
        from: from,
        postId: postNews?.post_id ?? ''
      ),
      duration: const Duration(milliseconds: 400),
      transition: Transition.rightToLeft
    );
  }
}