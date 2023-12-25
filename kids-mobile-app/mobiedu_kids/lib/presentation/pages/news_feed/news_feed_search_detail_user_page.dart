import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/user.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/home_page_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/news_feed_search_controller.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/person_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_avatar.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_search_detail_top.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';
import 'package:mobiedu_kids/presentation/widgets/horizontal_divider_no_padding.dart';

class NewsFeedSearchDetailUserPage extends StatelessWidget {
  NewsFeedSearchDetailUserPage({super.key});

  final newsFeedSearchController = Get.find<NewsFeedSearchController>();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return GetX(
      init: newsFeedSearchController,
      initState: (state) async {
        newsFeedSearchController.searchDetailNewsFeed(newsFeedSearchController.searchTextEditingController.text, TypeSearchDetail.users, null);
        scrollController.addListener(scrollListener);
      },
      didUpdateWidget: (old, newState) {
        scrollController.addListener(scrollListener);
      },
      dispose: (state) {
        scrollController.removeListener(scrollListener);
      },
      builder: (_) {
        return Scaffold(
          backgroundColor: HexColor('FFFFFF'),
          body: Container(
            padding: EdgeInsets.only(top: statusBarHeight + context.responsive(10.0)),
            child: Column(
              children: [
                NewsFeedSearchDetailTop(),
                Expanded(
                  child: newsFeedSearchController.isLoadingSearchDetail.value
                    ? const Center(
                      child: CircularLoadingIndicator(),
                    )
                    : SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: context.responsive(20.0)),
                          Padding(
                            padding: EdgeInsets.only(left: context.responsive(28.0)),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: context.responsive(6.0), horizontal: context.responsive(25.0)),
                              decoration: BoxDecoration(
                                color: HexColor('FFF4FA'),
                                borderRadius: BorderRadius.all(Radius.circular(context.responsive(20.0)))
                              ),
                              child: Text(
                                'Người dùng',
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
                          ),
                          SizedBox(height: context.responsive(16.0)),
                          const HorizontalDividerNoPadding(),
                          ListView.separated(
                            physics: const ClampingScrollPhysics(),
                            padding: EdgeInsets.only(top: 0.0, bottom: context.responsive(50.0)),
                            shrinkWrap: true,
                            separatorBuilder: (context, index) => const HorizontalDividerNoPadding(), 
                            itemCount: newsFeedSearchController.isLoadMore.value 
                              ? newsFeedSearchController.searchDetailUserData.length + 1 
                              : newsFeedSearchController.searchDetailUserData.length,
                            itemBuilder: (context, index) {
                              if (index < newsFeedSearchController.searchDetailUserData.length) {
                                final user = newsFeedSearchController.searchDetailUserData[index];
                                return InkWell(
                                  onTap: () {
                                    handlePressUserItem(user);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                      context.responsive(28.0), 
                                      context.responsive(18.0), 
                                      context.responsive(20.0), 
                                      context.responsive(18.0)
                                    ),
                                    child: Row(
                                      children: [
                                        NewsFeedAvatar(imageNetwork: user.user_picture),
                                        SizedBox(width: context.responsive(8.0)),
                                        Text(
                                          user.user_fullname ?? '',
                                          style: GoogleFonts.raleway(
                                            textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w700, color: HexColor('464646'))
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return const Center(
                                  child: CircularLoadingIndicator(),
                                );
                              }
                            },
                          )
                        ],
                      ),
                    )
                )
              ],
            ),
          ),
        );
      }
    );
  }

  void scrollListener() {
    if (newsFeedSearchController.canLoadMore.value) {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        newsFeedSearchController.searchDetailNewsFeedMore(newsFeedSearchController.searchTextEditingController.text, TypeSearchDetail.users, null);
      }
    }
  }

  void handlePressUserItem(User? user) {
    HomePageBinding(user?.user_name ?? '').dependencies();
    Get.to(
      () => PersonPage(
        personName: user?.user_name ?? '',
        personFullName: user?.user_fullname ?? '',
      ),
      duration: const Duration(milliseconds: 400),
      transition: Transition.rightToLeft
    );
  }
}