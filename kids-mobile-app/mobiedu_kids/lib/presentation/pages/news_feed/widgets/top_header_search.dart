import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/news_feed_search_binding.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/news_feed_search_page.dart';

class TopHeaderSearch extends StatelessWidget {
  const TopHeaderSearch({
    super.key,
    required this.from,
  });

  final String from;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.responsive(62.0),
      child: Stack(
        children: [
          Container(
            // padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: HexColor('D8D8D8')))
            ),
            child: Center(
              child: Text(
                'Bảng tin',
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    fontSize: context.responsive(22.0), 
                    fontWeight: FontWeight.w700, 
                    color: HexColor('783199')
                  )
                ),
              ),
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
            ),
          )
        ],
      ),
    );
  }
  
  void handlePressSearch() {
    NewsFeedSearchBinding().dependencies();
    Get.to(
      () => NewsFeedSearchPage(),
      duration: const Duration(milliseconds: 400),
      transition: Transition.rightToLeft
    );
  }
}