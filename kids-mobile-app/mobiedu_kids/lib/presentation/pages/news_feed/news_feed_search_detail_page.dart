import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/news_feed_search_controller.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_search_post_item.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/top_search_input.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';
import 'package:mobiedu_kids/presentation/widgets/horizontal_divider_no_padding.dart';

class NewsFeedSearchDetailPage extends StatelessWidget {
  NewsFeedSearchDetailPage({
    super.key,
    required this.from,
    required this.id,
  });

  final String from;
  final String id;

  final newsFeedSearchController = Get.find<NewsFeedSearchController>();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return GetX(
      init: newsFeedSearchController,
      initState: (state) {
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.responsive(28.0)),
                  child: TopSearchInput(
                    from: from,
                    id: id,
                  ),
                ),
                SizedBox(height: context.responsive(16.0)),
                const HorizontalDividerNoPadding(),
                Expanded(
                  child: newsFeedSearchController.isLoadingSearchDetail.value
                    ? const Center(
                      child: CircularLoadingIndicator(),
                    )
                    : newsFeedSearchController.searchDetailTextEditingController.text.isNotEmpty && newsFeedSearchController.searchDetailPostData.isEmpty
                      ? Center(
                        child: Text(
                          'Không tìm thấy kết quả phù hợp.',
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w500, color: HexColor('464646'))
                          ),
                        ),
                      )
                      : ListView.separated(
                        controller: scrollController,
                        physics: const ClampingScrollPhysics(),
                        padding: EdgeInsets.only(top: 0.0, bottom: context.responsive(50.0)),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => const HorizontalDividerNoPadding(), 
                        itemCount: newsFeedSearchController.isLoadMore.value 
                          ? newsFeedSearchController.searchDetailPostData.length + 1 
                          : newsFeedSearchController.searchDetailPostData.length,
                        itemBuilder: (context, index) {
                          if (index < newsFeedSearchController.searchDetailPostData.length) {
                            final post = newsFeedSearchController.searchDetailPostData[index];
                            return NewsFeedSearchPostItem(post: post);
                          } else {
                            return const Center(
                              child: CircularLoadingIndicator(),
                            );
                          }
                        },
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
        newsFeedSearchController.searchDetailNewsFeedMore(newsFeedSearchController.searchTextEditingController.text, TypeSearchDetail.posts, id);
      }
    }
  }
}