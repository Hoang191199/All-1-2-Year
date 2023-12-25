import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_page_controller.dart';

class SchoolPageLikeReport extends StatelessWidget {
  SchoolPageLikeReport({super.key});

  final showPageController = Get.find<ShowPageController>();

  @override
  Widget build(BuildContext context) {

    return Obx(
      () => Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                handlePressLikePage();
              },
              child: Column(
                children: [
                  showPageController.infoPageData.value?.i_like ?? false
                    ? Icon(CupertinoIcons.hand_thumbsup_fill, size: context.responsive(24.0), color: HexColor('FF9ACE'))
                    : Icon(CupertinoIcons.hand_thumbsup, size: context.responsive(24.0), color: HexColor('FF9ACE')),
                  SizedBox(height: context.responsive(5.0)),
                  Text(
                    'Thích',
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(fontSize: context.responsive(12.0), fontWeight: FontWeight.w500, color: HexColor('6F6F6F'))
                    ),
                  )
                ],
              ),
            )
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                handlePressReportPage();
              },
              child: Column(
                children: [
                  Icon(CupertinoIcons.flag, size: context.responsive(24.0), color: HexColor('FF9ACE')),
                  SizedBox(height: context.responsive(5.0)),
                  Text(
                    'Báo cáo',
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(fontSize: context.responsive(12.0), fontWeight: FontWeight.w500, color: HexColor('6F6F6F'))
                    ),
                  )
                ],
              ),
            )
          )
        ],
      )
    );
  }
  
  Future<void> handlePressLikePage() async {
    final action = (showPageController.infoPageData.value?.i_like ?? false) ? ActionPageConnect.pageUnLike : ActionPageConnect.pageLike;
    await showPageController.pageConnectLikePage(action, showPageController.infoPageData.value?.page_id ?? '');
  }
  
  Future<void> handlePressReportPage() async {
    await showPageController.reportPage(showPageController.infoPageData.value?.page_id ?? '');
  }
}