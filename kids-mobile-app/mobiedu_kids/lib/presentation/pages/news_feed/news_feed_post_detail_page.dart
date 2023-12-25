import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/home_page_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/news_feed_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/saved_posts_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_group_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_page_controller.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_avatar.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_section_item.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_section_item_image.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_section_item_text.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_section_item_title.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/no_data_not_exist.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/page_tag_top.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/post_detail_comment.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/post_detail_like_comment_share_action.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/post_detail_like_comment_share_view.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/post_detail_list_comment.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/video_post.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';
import 'package:mobiedu_kids/presentation/widgets/horizontal_divider_no_padding.dart';

class NewsFeedPostDetailPage extends StatelessWidget {
  NewsFeedPostDetailPage({
    super.key,
    required this.from,
    required this.postId,
    this.showComment,
    this.personName,
  });

  final String from;
  final String postId;
  final bool? showComment;
  final String? personName;

  final newsFeedController = Get.find<NewsFeedController>();
  final showPageController = Get.find<ShowPageController>();
  final showGroupController = Get.find<ShowGroupController>();
  final savedPostsController = Get.find<SavedPostsController>();
  final store = Get.find<LocalStorageService>();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    final homePageController = Get.find<HomePageController>(tag: personName);

    Future<void> scrollListener() async {
      if (from == PostNewsFrom.newsFeedPage) {
        if (newsFeedController.canLoadMorePost.value) {
          if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
            await newsFeedController.loadMoreGetPost(postId);
          }
        }
      } else if (from == PostNewsFrom.schoolPage) {
        if (showPageController.canLoadMorePost.value) {
          if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
            await showPageController.loadMoreGetPost(postId);
          }
        }
      } else if (from == PostNewsFrom.classPage) {
        if (showGroupController.canLoadMorePost.value) {
          if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
            await showGroupController.loadMoreGetPost(postId);
          }
        }
      } else if (from == PostNewsFrom.personPage) {
        if (homePageController.canLoadMorePost.value) {
          if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
            await homePageController.loadMoreGetPost(postId);
          }
        }
      }
    }

    return GetX(
      init: from == PostNewsFrom.newsFeedPage 
        ? newsFeedController 
        : from == PostNewsFrom.schoolPage
          ? showPageController
          : from == PostNewsFrom.classPage
            ? showGroupController
            : from == PostNewsFrom.personPage
              ? homePageController
              : savedPostsController,
      initState: (state) {
        if (from == PostNewsFrom.newsFeedPage) {
          newsFeedController.initialPostDetail(postId);
        } else if (from == PostNewsFrom.schoolPage) {
          showPageController.initialPostDetail(postId);
        } else if (from == PostNewsFrom.classPage) {
          showGroupController.initialPostDetail(postId);
        } else if (from == PostNewsFrom.personPage) {
          homePageController.initialPostDetail(postId);
        } else if (from == PostNewsFrom.savedPostPage) {
          savedPostsController.initialPostDetail(postId);
        }
        scrollController.addListener(scrollListener);
      },
      didUpdateWidget: (old, newState) {
        scrollController.addListener(scrollListener);
      },
      dispose: (state) {
        scrollController.removeListener(scrollListener);
      },
      builder: (_) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            backgroundColor: HexColor('FFF4FA'),
            body: (newsFeedController.isLoadingPost.value 
              || showPageController.isLoadingPost.value 
              || showGroupController.isLoadingPost.value
              || homePageController.isLoadingPost.value
              || savedPostsController.isLoadingPost.value
            )
              ? const Center(
                child: CircularLoadingIndicator(),
              )
              : Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: statusBarHeight),
                    child: RefreshIndicator(
                      color: AppColors.pink,
                      onRefresh: () async {
                        if (from == PostNewsFrom.newsFeedPage) {
                          await newsFeedController.getPost(postId);
                        } else if (from == PostNewsFrom.schoolPage) {
                          await showPageController.getPost(postId);
                        } else if (from == PostNewsFrom.classPage) {
                          await showGroupController.getPost(postId);
                        } else if (from == PostNewsFrom.personPage) {
                          await homePageController.getPost(postId);
                        } else if (from == PostNewsFrom.savedPostPage) {
                          await savedPostsController.getPost(postId);
                        }
                      },
                      child: (from == PostNewsFrom.newsFeedPage
                        ? newsFeedController.responsePostDetail.value?.code == 404
                        : from == PostNewsFrom.schoolPage
                          ? showPageController.responsePostDetail.value?.code == 404
                          : from == PostNewsFrom.classPage
                            ? showGroupController.responsePostDetail.value?.code == 404
                            : from == PostNewsFrom.personPage
                              ? homePageController.responsePostDetail.value?.code == 404
                              : savedPostsController.responsePostDetail.value?.code == 404)
                        ? Column(
                          children: [
                            const PageTagTop(tagName: 'Chi tiết bài viết'),
                            NotDataNotExist(text: homePageController.responseHome.value?.message)
                          ],
                        )
                        : Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                controller: scrollController,
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: context.responsive(10.0)),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: context.responsive(20.0)),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(width: context.responsive(8.0)),
                                          InkWell(
                                            onTap: () {
                                              handlePressBack();
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.all(context.responsive(5.0)),
                                              child: Icon(CupertinoIcons.back, size: context.responsive(28.0), color: HexColor('783199')),
                                            ),
                                          ),
                                          SizedBox(width: context.responsive(10.0)),
                                          NewsFeedAvatar(
                                            imageNetwork: from == PostNewsFrom.newsFeedPage
                                              ? newsFeedController.postDetailData.value?.post_author_picture
                                              : from == PostNewsFrom.schoolPage
                                                ? showPageController.postDetailData.value?.post_author_picture
                                                : from == PostNewsFrom.classPage
                                                  ? showGroupController.postDetailData.value?.post_author_picture
                                                  : from == PostNewsFrom.personPage
                                                    ? homePageController.postDetailData.value?.post_author_picture
                                                    : savedPostsController.postDetailData.value?.post_author_picture
                                          ),
                                          SizedBox(width: context.responsive(11.0)),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                NewsFeedSectionItemTitle(
                                                  from: from,
                                                  postNews: from == PostNewsFrom.newsFeedPage
                                                    ? newsFeedController.postDetailData.value
                                                    : from == PostNewsFrom.schoolPage
                                                      ? showPageController.postDetailData.value
                                                      : from == PostNewsFrom.classPage
                                                        ? showGroupController.postDetailData.value
                                                        : from == PostNewsFrom.personPage
                                                          ? homePageController.postDetailData.value
                                                          : savedPostsController.postDetailData.value
                                                ),
                                                Text(
                                                  dayAndDate(from == PostNewsFrom.newsFeedPage
                                                    ? newsFeedController.postDetailData.value?.time ?? ''
                                                    : from == PostNewsFrom.schoolPage
                                                      ? showPageController.postDetailData.value?.time ?? ''
                                                      : from == PostNewsFrom.classPage
                                                        ? showGroupController.postDetailData.value?.time ?? ''
                                                        : from == PostNewsFrom.personPage
                                                          ? homePageController.postDetailData.value?.time ?? ''
                                                          : savedPostsController.postDetailData.value?.time ?? ''
                                                  ),
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
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: context.responsive(20.0)),
                                      child: Column(
                                        children: [
                                          if (from == PostNewsFrom.newsFeedPage 
                                            ? (newsFeedController.postDetailData.value?.post_type == PostTypeNews.shared)
                                            : from == PostNewsFrom.schoolPage
                                              ? (showPageController.postDetailData.value?.post_type == PostTypeNews.shared)
                                              : from == PostNewsFrom.classPage
                                                ? (showGroupController.postDetailData.value?.post_type == PostTypeNews.shared)
                                                : from == PostNewsFrom.personPage
                                                  ? (homePageController.postDetailData.value?.post_type == PostTypeNews.shared)
                                                  : (savedPostsController.postDetailData.value?.post_type == PostTypeNews.shared)
                                          )
                                            Column(
                                              children: [
                                                SizedBox(height: context.responsive(8.0)),
                                                NewsFeedSectionItem(
                                                  from: from,
                                                  postNews: from == PostNewsFrom.newsFeedPage
                                                    ? newsFeedController.postDetailData.value?.origin
                                                    : from == PostNewsFrom.schoolPage
                                                      ? showPageController.postDetailData.value?.origin
                                                      : from == PostNewsFrom.classPage
                                                        ? showGroupController.postDetailData.value?.origin
                                                        : from == PostNewsFrom.personPage
                                                          ? homePageController.postDetailData.value?.origin
                                                          : savedPostsController.postDetailData.value?.origin,
                                                  isShare: true,
                                                  isPin: false,
                                                  personName: personName,
                                                )
                                              ],
                                            ),
                                          if (from == PostNewsFrom.newsFeedPage 
                                            ? (newsFeedController.postDetailData.value?.text?.isNotEmpty ?? false) 
                                            : from == PostNewsFrom.schoolPage
                                              ? (showPageController.postDetailData.value?.text?.isNotEmpty ?? false)
                                              : from == PostNewsFrom.classPage
                                                ? (showGroupController.postDetailData.value?.text?.isNotEmpty ?? false)
                                                : from == PostNewsFrom.personPage
                                                  ? (homePageController.postDetailData.value?.text?.isNotEmpty ?? false)
                                                  : (savedPostsController.postDetailData.value?.text?.isNotEmpty ?? false)
                                          )
                                            Column(
                                              children: [
                                                SizedBox(height: context.responsive(8.0)),
                                                NewsFeedSectionItemText(
                                                  postNews: from == PostNewsFrom.newsFeedPage
                                                    ? newsFeedController.postDetailData.value
                                                    : from == PostNewsFrom.schoolPage
                                                      ? showPageController.postDetailData.value
                                                      : from == PostNewsFrom.classPage
                                                        ? showGroupController.postDetailData.value
                                                        : from == PostNewsFrom.personPage
                                                          ? homePageController.postDetailData.value
                                                          : savedPostsController.postDetailData.value
                                                ),
                                              ],
                                            ),
                                          if (from == PostNewsFrom.newsFeedPage
                                            ? (newsFeedController.postDetailData.value?.photos_num != null && (newsFeedController.postDetailData.value?.photos_num ?? 0) > 0)
                                            : from == PostNewsFrom.schoolPage
                                              ? (showPageController.postDetailData.value?.photos_num != null && (showPageController.postDetailData.value?.photos_num ?? 0) > 0)
                                              : from == PostNewsFrom.classPage
                                                ? (showGroupController.postDetailData.value?.photos_num != null && (showGroupController.postDetailData.value?.photos_num ?? 0) > 0)
                                                : from == PostNewsFrom.personPage
                                                  ? (homePageController.postDetailData.value?.photos_num != null && (homePageController.postDetailData.value?.photos_num ?? 0) > 0)
                                                  : (savedPostsController.postDetailData.value?.photos_num != null && (savedPostsController.postDetailData.value?.photos_num ?? 0) > 0)
                                          )
                                            Column(
                                              children: [
                                                SizedBox(height: context.responsive(8.0)),
                                                NewsFeedSectionItemImage(
                                                  postNews: from == PostNewsFrom.newsFeedPage
                                                    ? newsFeedController.postDetailData.value
                                                    : from == PostNewsFrom.schoolPage
                                                      ? showPageController.postDetailData.value
                                                      : from == PostNewsFrom.classPage
                                                        ? showGroupController.postDetailData.value
                                                        : from == PostNewsFrom.personPage
                                                          ? homePageController.postDetailData.value
                                                          : savedPostsController.postDetailData.value
                                                )
                                              ],
                                            ),
                                          if (from == PostNewsFrom.newsFeedPage
                                            ? (newsFeedController.postDetailData.value?.post_type == PostTypeNews.video)
                                            : from == PostNewsFrom.schoolPage
                                              ? (showPageController.postDetailData.value?.post_type == PostTypeNews.video)
                                              : from == PostNewsFrom.classPage
                                                ? (showGroupController.postDetailData.value?.post_type == PostTypeNews.video)
                                                : from == PostNewsFrom.personPage
                                                  ? (homePageController.postDetailData.value?.post_type == PostTypeNews.video)
                                                  : (savedPostsController.postDetailData.value?.post_type == PostTypeNews.video)
                                          )
                                            Column(
                                              children: [
                                                SizedBox(height: context.responsive(8.0)),
                                                (from == PostNewsFrom.newsFeedPage
                                                  ? (newsFeedController.postDetailData.value?.video?.source?.isNotEmpty ?? false)
                                                  : from == PostNewsFrom.schoolPage
                                                    ? (showPageController.postDetailData.value?.video?.source?.isNotEmpty ?? false)
                                                    : from == PostNewsFrom.classPage
                                                      ? (showGroupController.postDetailData.value?.video?.source?.isNotEmpty ?? false)
                                                      : from == PostNewsFrom.personPage
                                                        ? (homePageController.postDetailData.value?.video?.source?.isNotEmpty ?? false)
                                                        : (savedPostsController.postDetailData.value?.video?.source?.isNotEmpty ?? false)
                                                )
                                                  ? Container(
                                                    width: widthScreen,
                                                    height: widthScreen * 9 / 16,
                                                    decoration: const BoxDecoration(
                                                      color: Colors.black
                                                    ),
                                                    child: VideoPost(
                                                      fileType: VideoFileType.network,
                                                      filePath: from == PostNewsFrom.newsFeedPage
                                                        ? newsFeedController.postDetailData.value?.video?.source ?? ''
                                                        : from == PostNewsFrom.schoolPage
                                                          ? showPageController.postDetailData.value?.video?.source ?? ''
                                                          : from == PostNewsFrom.classPage
                                                            ? showGroupController.postDetailData.value?.video?.source ?? ''
                                                            : from == PostNewsFrom.personPage
                                                              ? homePageController.postDetailData.value?.video?.source ?? ''
                                                              : savedPostsController.postDetailData.value?.video?.source ?? '',
                                                    ),
                                                  )
                                                  : Container()
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: context.responsive(18.0)),
                                    const HorizontalDividerNoPadding(),
                                    SizedBox(height: context.responsive(10.0)),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: context.responsive(20.0)),
                                      child: PostDetailLikeCommentShareView(
                                        from: from,
                                        personName: personName,
                                      ),
                                    ),
                                    SizedBox(height: context.responsive(10.0)),
                                    const HorizontalDividerNoPadding(),
                                    SizedBox(height: context.responsive(8.0)),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: context.responsive(28.0)),
                                      child: PostDetailLikeCommentShareAction(
                                        from: from,
                                        personName: personName,
                                      ),
                                    ),
                                    SizedBox(height: context.responsive(14.0)),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: context.responsive(20.0)),
                                      child: PostDetailListComment(
                                        from: from,
                                        personName: personName,
                                        listPostComment: from == PostNewsFrom.newsFeedPage
                                          ? newsFeedController.postCommentDetailData
                                          : from == PostNewsFrom.schoolPage
                                            ? showPageController.postCommentDetailData
                                            : from == PostNewsFrom.classPage
                                              ? showGroupController.postCommentDetailData
                                              : from == PostNewsFrom.personPage
                                                ? homePageController.postCommentDetailData
                                                : savedPostsController.postCommentDetailData
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: context.responsive(10.0), horizontal: context.responsive(20.0)),
                              child: PostDetailComment(
                                from: from,
                                personName: personName,
                                postNews: from == PostNewsFrom.newsFeedPage
                                  ? newsFeedController.postDetailData.value
                                  : from == PostNewsFrom.schoolPage
                                    ? showPageController.postDetailData.value
                                    : from == PostNewsFrom.classPage
                                      ? showGroupController.postDetailData.value
                                      : from == PostNewsFrom.personPage
                                        ? homePageController.postDetailData.value
                                        : savedPostsController.postDetailData.value
                              ),
                            )
                          ],
                      ),
                    ),
                  ),
                  (from == PostNewsFrom.newsFeedPage 
                    ? newsFeedController.isLoadingCreateComment.value
                    : from == PostNewsFrom.schoolPage
                      ? showPageController.isLoadingCreateComment.value
                      : from == PostNewsFrom.classPage
                        ? showGroupController.isLoadingCreateComment.value
                        : from == PostNewsFrom.personPage
                          ? homePageController.isLoadingCreateComment.value
                          : savedPostsController.isLoadingCreateComment.value
                  )
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
                ],
              ),
          ),
        );
      }
    );
  }
  
  void handlePressBack() {
    Get.back();
  }
}