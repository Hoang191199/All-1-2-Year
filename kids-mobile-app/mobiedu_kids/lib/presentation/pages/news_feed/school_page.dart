import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_page_controller.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_section.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_section_item.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/no_data_not_exist.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/page_info.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/page_tag_top.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/school_page_like_report.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/school_page_rate.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/page_tag.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/show_page_group_top_header.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/what_thing.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';
import 'package:mobiedu_kids/presentation/widgets/horizontal_divider_no_padding.dart';

class SchoolPage extends StatelessWidget {
  SchoolPage({
    super.key,
    this.pageTitle,
    required this.pageName,
    required this.pageId,
  });

  final String? pageTitle;
  final String pageName;
  final String pageId;

  final showPageController = Get.find<ShowPageController>();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return GetX(
      init: showPageController,
      initState: (state) async {
        showPageController.showPageAll(pageName);
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
            if (!showPageController.folded.value) {
              showPageController.folded.value = true;
            }
          },
          child: Scaffold(
            backgroundColor: HexColor('FFFFFF'),
            body: showPageController.isLoadingAll.value && !showPageController.isRefresh.value
              ? const Center(
                child: CircularLoadingIndicator(),
              )
              : Container(
                padding: EdgeInsets.only(top: statusBarHeight + context.responsive(10.0)),
                child: RefreshIndicator(
                  color: AppColors.pink,
                  onRefresh: () async {
                    showPageController.refreshPageAll(pageName);
                  },
                  child: Stack(
                    children: [
                      showPageController.responseShowPage.value?.code == 404
                        ? Column(
                          children: [
                            PageTagTop(tagName: pageTitle ?? ''),
                            NotDataNotExist(text: showPageController.responseShowPage.value?.message)
                          ],
                        )
                        : CustomScrollView(
                          controller: scrollController,
                          physics: const ClampingScrollPhysics(),
                          slivers: [
                            SliverAppBar(
                              floating: true,
                              pinned: false,
                              snap: false,
                              expandedHeight: context.responsive(62.0 - statusBarHeight),
                              collapsedHeight: context.responsive(62.0 - statusBarHeight),
                              toolbarHeight: context.responsive(62.0 - statusBarHeight),
                              flexibleSpace: ShowPageGroupTopHeader(
                                from: PostNewsFrom.schoolPage,
                                id: pageId
                              ),
                              backgroundColor: HexColor('FFFFFF'),
                              automaticallyImplyLeading: false,
                            ),
                            SliverToBoxAdapter(
                              child: Column(
                                children: [
                                  PageInfo(from: PostNewsFrom.schoolPage),
                                  SizedBox(height: context.responsive(8.0)),
                                  SchoolPageLikeReport(),
                                  SizedBox(height: context.responsive(8.0)),
                                  const HorizontalDividerNoPadding(),
                                  if (showPageController.infoPageData.value?.display_rate_school ?? false)
                                    Column(
                                      children: [
                                        SizedBox(height: context.responsive(8.0)),
                                        SchoolPageRate(),
                                      ],
                                    ),
                                  SizedBox(height: context.responsive(14.0)),
                                  PageTag(
                                    from: PostNewsFrom.schoolPage,
                                    name: pageName
                                  ),
                                  SizedBox(height: context.responsive(8.0)),
                                  if (showPageController.infoPageData.value?.i_admin ?? false)
                                    WhatThing(from: PostNewsFrom.schoolPage),
                                  SizedBox(height: context.responsive(8.0)),
                                  const HorizontalDividerNoPadding(),
                                  if (showPageController.pinnedPostPageData.value != null)
                                    Column(
                                      children: [
                                        NewsFeedSectionItem(
                                          from: PostNewsFrom.schoolPage,
                                          postNews: showPageController.pinnedPostPageData.value,
                                          isShare: false,
                                          isPin: true,
                                        ),
                                        SizedBox(height: context.responsive(16.0)),
                                      ],
                                    ),
                                  NewsFeedSection(
                                    from: PostNewsFrom.schoolPage,
                                    listPostNews: showPageController.postPageData
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      showPageController.isLoadingCreateComment.value || showPageController.isLoadingCreatePost.value
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
              ),
          ),
        );
      }
    );
  }

  void scrollListener() {
    if (showPageController.canLoadMorePage.value) {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        showPageController.loadMoreShowPageAll(pageName);
      }
    }
  }
}