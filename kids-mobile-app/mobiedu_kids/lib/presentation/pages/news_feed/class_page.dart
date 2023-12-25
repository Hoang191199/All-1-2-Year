import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_group_controller.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_section.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_section_item.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/no_data_not_exist.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/page_tag.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/page_info.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/page_tag_top.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/show_page_group_top_header.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/what_thing.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';
import 'package:mobiedu_kids/presentation/widgets/horizontal_divider_no_padding.dart';

class ClassPage extends StatelessWidget {
  ClassPage({
    super.key,
    this.classTitle,
    required this.className,
    required this.classId,
  });

  final String? classTitle;
  final String className;
  final String classId;

  final showGroupController = Get.find<ShowGroupController>();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return GetX(
      init: showGroupController,
      initState: (state) async {
        showGroupController.showGroupAll(className);
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
            if (!showGroupController.folded.value) {
              showGroupController.folded.value = true;
            }
          },
          child: Scaffold(
            backgroundColor: HexColor('FFFFFF'),
            body: showGroupController.isLoadingAll.value && !showGroupController.isRefresh.value
              ? const Center(
                child: CircularLoadingIndicator(),
              )
              : Container(
                padding: EdgeInsets.only(top: statusBarHeight + context.responsive(10.0)),
                child: RefreshIndicator(
                  color: AppColors.pink,
                  onRefresh: () async {
                    showGroupController.refreshGroupAll(className);
                  },
                  child: Stack(
                    children: [
                      showGroupController.responseShowGroup.value?.code == 404
                        ? Column(
                          children: [
                            PageTagTop(tagName: classTitle ?? ''),
                            NotDataNotExist(text: showGroupController.responseShowGroup.value?.message)
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
                                from: PostNewsFrom.classPage,
                                id: classId
                              ),
                              backgroundColor: HexColor('FFFFFF'),
                              automaticallyImplyLeading: false,
                            ),
                            SliverToBoxAdapter(
                              child: Column(
                                children: [
                                  PageInfo(from: PostNewsFrom.classPage),
                                  SizedBox(height: context.responsive(14.0)),
                                  PageTag(
                                    from: PostNewsFrom.classPage,
                                    name: className
                                  ),
                                  SizedBox(height: context.responsive(8.0)),
                                  if (showGroupController.infoGroupData.value?.class_allow_post ?? false)
                                    WhatThing(from: PostNewsFrom.classPage),
                                  SizedBox(height: context.responsive(8.0)),
                                  const HorizontalDividerNoPadding(),
                                  if (showGroupController.pinnedPostGroupData.value != null)
                                    Column(
                                      children: [
                                        NewsFeedSectionItem(
                                          from: PostNewsFrom.schoolPage,
                                          postNews: showGroupController.pinnedPostGroupData.value,
                                          isShare: false,
                                          isPin: true,
                                        ),
                                        SizedBox(height: context.responsive(16.0)),
                                      ],
                                    ),
                                  NewsFeedSection(
                                    from: PostNewsFrom.classPage,
                                    listPostNews: showGroupController.postGroupData
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      showGroupController.isLoadingCreateComment.value || showGroupController.isLoadingCreatePost.value
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
    if (showGroupController.canLoadMoreGroup.value) {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        showGroupController.loadMoreShowGroupAll(className);
      }
    }
  }
}