import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/news_feed_controller.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_section.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/page_group_section.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/top_header_search.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class NewsFeedPage extends StatelessWidget {
  NewsFeedPage({super.key});

  final newsFeedController = Get.find<NewsFeedController>();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return GetX(
      init: newsFeedController,
      initState: (state) async {
        // newsFeedController.getPageGroupJoined();
        // newsFeedController.getListNewsFeed();
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
            if (!newsFeedController.folded.value) {
              newsFeedController.folded.value = true;
            }
          },
          child: Scaffold(
            backgroundColor: HexColor('FFFFFF'),
            body: Container(
              padding: EdgeInsets.only(top: statusBarHeight + context.responsive(10.0, sm: 10.0)),
              child: RefreshIndicator(
                color: AppColors.pink,
                onRefresh: () async {
                  newsFeedController.getPageGroupJoined();
                  newsFeedController.getListNewsFeed();
                },
                child: Stack(
                  children: [
                    CustomScrollView(
                      controller: scrollController,
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      slivers: [
                        SliverAppBar(
                          floating: true,
                          pinned: false,
                          snap: false,
                          expandedHeight: context.responsive(150.0 - statusBarHeight),
                          collapsedHeight: context.responsive(150.0 - statusBarHeight),
                          toolbarHeight: context.responsive(150.0 - statusBarHeight),
                          flexibleSpace: Column(
                            children: [
                              const TopHeaderSearch(from: PostNewsFrom.newsFeedPage),
                              SizedBox(height: context.responsive(8.0)),
                              PageGroupSection(),
                            ],
                          ),
                          backgroundColor: HexColor('FFFFFF'),
                          automaticallyImplyLeading: false,
                        ),
                        SliverToBoxAdapter(
                          child: newsFeedController.isLoadingNewsFeed.value 
                          // && !newsFeedController.isRefresh.value
                            ? SizedBox(
                              height: heightScreen - statusBarHeight - context.responsive(10.0 + 130.0 + 70.0),
                              child: const Center(
                                child: CircularLoadingIndicator(),
                              ),
                            )
                            : Column(
                              children: [
                                SizedBox(height: context.responsive(12.0)),
                                NewsFeedSection(
                                  from: PostNewsFrom.newsFeedPage,
                                  listPostNews: newsFeedController.postNewsData
                                )
                              ],
                            ),
                        )
                      ],
                    ),
                    newsFeedController.isLoadingCreateComment.value
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
      },
    );
  }

  void scrollListener() {
    if (newsFeedController.canLoadMoreNewsFeed.value) {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        newsFeedController.loadMoreNewsFeed();
      }
    }
  }
}
