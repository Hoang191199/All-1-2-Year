import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_page_controller.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/page_tag_top.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';
import 'package:mobiedu_kids/presentation/widgets/horizontal_divider_no_padding.dart';

class SchoolReviewPage extends StatelessWidget {
  SchoolReviewPage({
    super.key,
    required this.pageName,
  });

  final String pageName;

  final showPageController = Get.find<ShowPageController>();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return GetX(
      init: showPageController,
      initState: (state) async {
        showPageController.showPageReview(pageName);
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
          body: showPageController.isLoadingReview.value
            ? const Center(
              child: CircularLoadingIndicator(),
            )
            : Container(
              padding: EdgeInsets.only(top: statusBarHeight + context.responsive(10.0)),
              child: Column(
                children: [
                  const PageTagTop(tagName: 'Đánh giá'),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.responsive(28.0)),
                    child: ListView.separated(
                      controller: scrollController,
                      physics: const ClampingScrollPhysics(),
                      padding: EdgeInsets.only(top: context.responsive(16.0), bottom: context.responsive(50.0)),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => const HorizontalDividerNoPadding(), 
                      itemCount: showPageController.isLoadMore.value 
                        ? showPageController.reviewPageData.length + 1 
                        : showPageController.reviewPageData.length,
                      itemBuilder: (context, index) {
                        if (index < showPageController.reviewPageData.length) {
                          final review = showPageController.reviewPageData[index];
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    review.user_fullname ?? '',
                                    style: GoogleFonts.raleway(
                                      textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w700, color: HexColor('464646'))
                                    ),
                                  ),
                                  SizedBox(height: context.responsive(4.0)),
                                  Text(
                                    convertDateTimeToString(DateTime.parse(review.created_at ?? '')),
                                    style: GoogleFonts.raleway(
                                      textStyle: TextStyle(fontSize: context.responsive(12.0), fontWeight: FontWeight.w500, color: HexColor('6F6F6F'))
                                    ),
                                  ),
                                  SizedBox(height: context.responsive(10.0)),
                                  Text(
                                    review.comment ?? '',
                                    style: GoogleFonts.raleway(
                                      textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w500, color: HexColor('6F6F6F'))
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    review.rating ?? '',
                                    style: GoogleFonts.raleway(
                                      textStyle: TextStyle(fontSize: context.responsive(16.0), fontWeight: FontWeight.w700, color: HexColor('6F6F6F'))
                                    ),
                                  ),
                                   SizedBox(width: context.responsive(6.0)),
                                  Icon(CupertinoIcons.star_fill, size: context.responsive(22.0), color: HexColor('F1B821'))
                                ],
                              )
                            ],
                          );
                        } else {
                          return const Center(
                            child: CircularLoadingIndicator(),
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
        );
      }
    );
  }

  void scrollListener() {
    if (showPageController.canLoadMorePageReview.value) {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        showPageController.loadMoreShowPageReview(pageName);
      }
    }
  }
}