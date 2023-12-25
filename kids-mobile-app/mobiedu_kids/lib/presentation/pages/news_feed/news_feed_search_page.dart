import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/news_feed_search_controller.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_search_group.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/top_search_input.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_search_school_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_search_post.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_search_tag.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_search_user.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class NewsFeedSearchPage extends StatelessWidget {
  NewsFeedSearchPage({super.key});

  final newsFeedSearchController = Get.find<NewsFeedSearchController>();

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

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
                child: TopSearchInput(from: PostNewsFrom.newsFeedPage),
              ),
              SizedBox(height: context.responsive(16.0)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.responsive(10.0)),
                child: NewsFeedSearchTag(),
              ),
              SizedBox(height: context.responsive(12.0)),
              Expanded(
                child: Obx(
                  () => newsFeedSearchController.isLoadingSearchNewsFeed.value
                    ? const Center(
                      child: CircularLoadingIndicator(),
                    )
                    : newsFeedSearchController.searchTextEditingController.text.isNotEmpty 
                      && newsFeedSearchController.isSearch.value
                      && newsFeedSearchController.responseSearchNewsFeed.value?.data == null
                      ? Center(
                        child: Text(
                          'Không tìm thấy kết quả phù hợp.',
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              fontSize: context.responsive(14.0), 
                              fontWeight: FontWeight.w500, 
                              color: HexColor('464646')
                            )
                          ),
                        ),
                      )
                      : SingleChildScrollView(
                        child: Column(
                          children: [
                            NewsFeedSearchPost(),
                            NewsFeedSearchGroup(),
                            NewsFeedSearchSchoolPage(),
                            NewsFeedSearchUser()
                          ],
                        ),
                      )
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}