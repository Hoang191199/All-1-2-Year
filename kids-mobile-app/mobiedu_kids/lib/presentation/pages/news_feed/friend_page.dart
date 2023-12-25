import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/user.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/home_page_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/home_page_controller.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/person_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_avatar.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/top_search_input.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class FriendPage extends StatelessWidget {
  FriendPage({
    super.key,
    required this.personName,
  });

  final String personName;

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    final homePageController = Get.find<HomePageController>(tag: personName);

    void scrollListener() {
      if (homePageController.canLoadMoreFriends.value) {
        if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
          homePageController.loadMoreHomePageFriends(personName);
        }
      }
    }

    return GetX(
      init: homePageController,
      initState: (state) async {
        homePageController.homePageFriends(personName);
        homePageController.searchFriendController.text = '';
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
            body: Container(
              padding: EdgeInsets.only(top: statusBarHeight + context.responsive(10.0)),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.responsive(28.0)),
                    child: TopSearchInput(
                      from: PostNewsFrom.friendPage,
                      personName: personName,
                    ),
                  ),
                  SizedBox(height: context.responsive(8.0)),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.responsive(28.0)),
                      child: ListView.separated(
                        controller: scrollController,
                        physics: const ClampingScrollPhysics(),
                        padding: EdgeInsets.only(top: 0.0, bottom: context.responsive(50.0)),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => SizedBox(height: context.responsive(8.0)), 
                        itemCount: homePageController.isLoadMoreFriends.value 
                          ? homePageController.friendsHomeDataUI.length + 1 
                          : homePageController.friendsHomeDataUI.length,
                        itemBuilder: (context, index) {
                          if (index < homePageController.friendsHomeDataUI.length) {
                            final friend = homePageController.friendsHomeDataUI[index];
                            return InkWell(
                              onTap: () {
                                handlePressFriendItem(friend);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      NewsFeedAvatar(
                                        imageNetwork: friend.user_picture,
                                        radius: context.responsive(18.0),
                                        sizeAsset: context.responsive(24.0),
                                      ),
                                      SizedBox(width: context.responsive(12.0)),
                                      Text(
                                        friend.user_fullname ?? '',
                                        style: GoogleFonts.raleway(
                                          textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w700, color: HexColor('464646'))
                                        ),
                                      )
                                    ],
                                  ),
                                  Icon(CupertinoIcons.right_chevron, size: context.responsive(20.0), color: HexColor('D8D8D8'))
                                ],
                              ),
                            );
                          } else {
                            return const Center(
                              child: CircularLoadingIndicator(),
                            );
                          }
                        },
                      ),
                    )
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  void handlePressFriendItem(User friend) {
    HomePageBinding(friend.user_name ?? '').dependencies();
    Get.to(
      () => PersonPage(
        personName: friend.user_name ?? '',
        personFullName: friend.user_fullname ?? '',
      ),
      duration: const Duration(milliseconds: 400),
      transition: Transition.rightToLeft
    );
  }
}