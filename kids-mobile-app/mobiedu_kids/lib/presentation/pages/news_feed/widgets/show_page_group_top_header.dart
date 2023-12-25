import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/news_feed_search_binding.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/news_feed_search_detail_page.dart';
// import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/animated_search_bar.dart';

class ShowPageGroupTopHeader extends StatelessWidget {
  const ShowPageGroupTopHeader({
    super.key,
    required this.from,
    required this.id,
  });

  final String from;
  final String id;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.responsive(62.0),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: context.responsive(28.0)),
            height: context.responsive(62.0),
            width: double.infinity,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    handlePressBack();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(context.responsive(5.0)),
                    child: Icon(CupertinoIcons.back, size: context.responsive(28.0), color: HexColor('783199')),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            right: context.responsive(28.0),
            bottom: context.responsive(10.0),
            // child: AnimatedSearchBar(from: from),
            child: Container(
              width: context.responsive(42.0),
              height: context.responsive(42.0),
              decoration: BoxDecoration(
                color: HexColor('FFF4FA'),
                borderRadius: BorderRadius.all(Radius.circular(context.responsive(21.0))),
              ),
              child: InkWell(
                onTap: () {
                  handlePressSearch();
                },
                child: Padding(
                  padding: EdgeInsets.all(context.responsive(9.0)),
                  child: Image.asset(
                    'assets/images/search.png',
                    width: context.responsive(24.0),
                    height: context.responsive(24.0),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          )
        ],
      ),
    );
  }

  void handlePressBack() {
    Get.back();
  }

  void handlePressSearch() {
    NewsFeedSearchBinding().dependencies();
    Get.to(
      () => NewsFeedSearchDetailPage(
        from: from,
        id: id
      ),
      duration: const Duration(milliseconds: 400),
      transition: Transition.rightToLeft
    );
  }
}