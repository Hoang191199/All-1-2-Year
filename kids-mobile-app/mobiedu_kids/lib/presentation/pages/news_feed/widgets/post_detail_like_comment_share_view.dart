import 'package:flutter/cupertino.dart';
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

class PostDetailLikeCommentShareView extends StatelessWidget {
  PostDetailLikeCommentShareView({
    super.key,
    required this.from,
    this.personName,
  });

  final String from;
  final String? personName;

  final newsFeedController = Get.find<NewsFeedController>();
  final showPageController = Get.find<ShowPageController>();
  final showGroupController = Get.find<ShowGroupController>();
  final savedPostsController = Get.find<SavedPostsController>();

  @override
  Widget build(BuildContext context) {
    
    final homePageController = Get.find<HomePageController>(tag: personName);

    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Icon(CupertinoIcons.heart, size: context.responsive(22.0), color: HexColor('6F6F6F')),
                SizedBox(width: context.responsive(8.0)),
                Text(
                  from == PostNewsFrom.newsFeedPage
                    ? '${newsFeedController.postDetailData.value?.likes ?? 0}'
                    : from == PostNewsFrom.schoolPage
                      ? '${showPageController.postDetailData.value?.likes ?? 0}'
                      : from == PostNewsFrom.classPage
                        ? '${showGroupController.postDetailData.value?.likes ?? 0}'
                        : from == PostNewsFrom.personPage
                          ? '${homePageController.postDetailData.value?.likes ?? 0}'
                          : '${savedPostsController.postDetailData.value?.likes ?? 0}',
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w500, color: HexColor('6F6F6F'))
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              from == PostNewsFrom.newsFeedPage 
                ? '${newsFeedController.postDetailData.value?.comments ?? 0} Bình luận'
                : from == PostNewsFrom.schoolPage
                  ? '${showPageController.postDetailData.value?.comments ?? 0} Bình luận'
                  : from == PostNewsFrom.classPage
                    ? '${showGroupController.postDetailData.value?.comments ?? 0} Bình luận'
                    : from == PostNewsFrom.personPage
                      ? '${homePageController.postDetailData.value?.comments ?? 0} Bình luận'
                      : '${savedPostsController.postDetailData.value?.comments ?? 0} Bình luận',
              style: GoogleFonts.raleway(
                textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w500, color: HexColor('6F6F6F'))
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              from == PostNewsFrom.newsFeedPage 
                ? '${newsFeedController.postDetailData.value?.shares ?? 0} lượt chia sẻ'
                : from == PostNewsFrom.schoolPage
                  ? '${showPageController.postDetailData.value?.shares ?? 0} lượt chia sẻ'
                  : from == PostNewsFrom.classPage
                    ? '${showGroupController.postDetailData.value?.shares ?? 0} lượt chia sẻ'
                    : from == PostNewsFrom.personPage
                      ? '${homePageController.postDetailData.value?.shares ?? 0} lượt chia sẻ'
                      : '${savedPostsController.postDetailData.value?.shares ?? 0} lượt chia sẻ',
              style: GoogleFonts.raleway(
                textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w500, color: HexColor('6F6F6F'))
              ),
              textAlign: TextAlign.end,
            ),
          )
        ],
      )
    );
  }
}