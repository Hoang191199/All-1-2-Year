import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/home_page_controller.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_section.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/no_data_not_exist.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/page_info.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/page_tag.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/page_tag_top.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/person_interact.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class PersonPage extends StatelessWidget {
  PersonPage({
    super.key,
    required this.personName,
    required this.personFullName,
  });

  final String personName;
  final String personFullName;

  final scrollController = ScrollController();
  final store = Get.find<LocalStorageService>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    
    final homePageController = Get.find<HomePageController>(tag: personName);

    void scrollListener() {
      if (homePageController.canLoadMoreHome.value) {
        if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
          homePageController.loadMoreHomePageAll(personName);
        }
      }
    }

    return GetX(
      init: homePageController,
      initState: (state) async {
        homePageController.homePageAll(personName);
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
            backgroundColor: HexColor('FFFFFF'),
            body: homePageController.isLoadingAll.value && !homePageController.isRefresh.value
              ? const Center(
                child: CircularLoadingIndicator(),
              )
              : Container(
                padding: EdgeInsets.only(top: statusBarHeight + context.responsive(10.0)),
                child: RefreshIndicator(
                  color: AppColors.pink,
                  onRefresh: () async {
                    homePageController.refreshHomePageAll(personName);
                  },
                  child: Stack(
                    children: [
                      CustomScrollView(
                        controller: scrollController,
                        physics: const ClampingScrollPhysics(),
                        slivers: [
                          SliverAppBar(
                            floating: true,
                            pinned: false,
                            snap: false,
                            expandedHeight: context.responsive(60.0 - statusBarHeight),
                            collapsedHeight: context.responsive(60.0 - statusBarHeight),
                            toolbarHeight: context.responsive(60.0 - statusBarHeight),
                            flexibleSpace: PageTagTop(tagName: personFullName),
                            backgroundColor: HexColor('FFFFFF'),
                            automaticallyImplyLeading: false,
                          ),
                          SliverToBoxAdapter(
                            child: homePageController.responseHome.value?.code == 404
                              ? NotDataNotExist(text: homePageController.responseHome.value?.message)
                              : Column(
                                children: [
                                  PageInfo(
                                    from: PostNewsFrom.personPage,
                                    personName: personName,
                                  ),
                                  if (store.userFromStorage?.user_id != homePageController.profileData.value?.user_id)
                                    Column(
                                      children: [
                                        SizedBox(height: context.responsive(10.0)),
                                        PersonInteract(personName: personName)
                                      ],
                                    ),
                                  SizedBox(height: context.responsive(14.0)),
                                  PageTag(
                                    from: PostNewsFrom.personPage,
                                    name: personName
                                  ),
                                  SizedBox(height: context.responsive(16.0)),
                                  NewsFeedSection(
                                    from: PostNewsFrom.personPage,
                                    personName: personName,
                                    listPostNews: homePageController.postHomeData
                                  )
                                ],
                              ),
                          )
                        ],
                      ),
                      homePageController.isLoadingCreateComment.value || homePageController.isLoadingCreatePost.value
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
}