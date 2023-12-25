import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/news_feed_search_controller.dart';

class NewsFeedSearchDetailTop extends StatelessWidget {
  NewsFeedSearchDetailTop({super.key});

  final newsFeedSearchController = Get.find<NewsFeedSearchController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.responsive(28.0)),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: context.responsive(40.0), 
              top: context.responsive(20.0), 
              bottom: context.responsive(10.0)
            ),
            width: double.infinity,
            child: Center(
              child: Text (
                newsFeedSearchController.searchTextEditingController.text,
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    fontSize: context.responsive(14.0), 
                    height: context.responsive(1.5), 
                    fontWeight: FontWeight.w500, 
                    color: HexColor('6F6F6F')
                  )
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Positioned(
            left: 0.0,
            child: Padding(
              padding: EdgeInsets.only(
                top: context.responsive(12.0), 
                bottom: context.responsive(10.0), 
                right: context.responsive(10.0)
              ),
              child: InkWell(
                onTap: () {
                  handlePressBack();
                },
                child: Padding(
                  padding: EdgeInsets.all(context.responsive(5.0)),
                  child: Icon(CupertinoIcons.back, size: context.responsive(28.0), color: HexColor('783199')),
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
}