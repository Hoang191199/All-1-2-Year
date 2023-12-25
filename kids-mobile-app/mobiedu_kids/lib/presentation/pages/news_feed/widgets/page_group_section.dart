import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/group_join.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/page_join.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/news_feed_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_group_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_page_binding.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/class_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/school_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_avatar.dart';

class PageGroupSection extends StatelessWidget {
  PageGroupSection({super.key});

  final newsFeedController = Get.find<NewsFeedController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    return Obx(
      () => newsFeedController.isLoadingPageGroup.value
        ? SizedBox(height: context.responsive(80.0))
        : SizedBox(
            width: widthScreen,
            height: context.responsive(80.0),
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              separatorBuilder: (context, index) => SizedBox(width: context.responsive(20.0)), 
              itemCount: newsFeedController.pageJoinData.length + newsFeedController.groupJoinData.length,
              itemBuilder: (context, index) {
                Object? data;
                String title = '';
                String pageGroupPicture = '';
                if (index < newsFeedController.pageJoinData.length) {
                  data = newsFeedController.pageJoinData[index];
                } else {
                  data = newsFeedController.groupJoinData[index - newsFeedController.pageJoinData.length];
                }
                if (data is PageJoin) {
                  title = data.page_title ?? '';
                  pageGroupPicture = data.page_picture ?? '';
                } else if (data is GroupJoin) {
                  title = data.group_title ?? '';
                  pageGroupPicture = data.group_picture ?? '';
                }
                return InkWell(
                  onTap: () {
                    handlePressPageGroupItem(index);
                  },
                  child: SizedBox(
                    width: context.responsive(66.0),
                    child: Column(
                      children: [
                        NewsFeedAvatar(
                          imageNetwork: pageGroupPicture,
                          radius: context.responsive(30.0),
                          backgroundColor: 'FFF4FA',
                          linkAsset: 'assets/images/news-feed-page-group.png',
                          sizeAsset: context.responsive(24.0),
                        ),
                        SizedBox(height: context.responsive(4.0)),
                        Expanded(
                          child: Text(
                            title,
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                fontSize: context.responsive(12.0), 
                                height: context.responsive(1.25), 
                                fontWeight: FontWeight.w500, 
                                color: HexColor('6F6F6F')
                              )
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis
                          )
                        )
                      ],
                    ),
                  ),
                );
              }, 
            ),
          )
    );
  }
  
  void handlePressPageGroupItem(int index) {
    ShowPageBinding().dependencies();
    ShowGroupBinding().dependencies();
    if (index < newsFeedController.pageJoinData.length) {
      Get.to(
        () => SchoolPage(
          pageTitle: newsFeedController.pageJoinData[index]?.page_title ?? '',
          pageName: newsFeedController.pageJoinData[index]?.page_name ?? '',
          pageId: newsFeedController.pageJoinData[index]?.page_id ?? ''
        ),
        duration: const Duration(milliseconds: 400),
        transition: Transition.rightToLeft
      );
    } else {
      Get.to(
        () => ClassPage(
          classTitle: newsFeedController.groupJoinData[index - newsFeedController.pageJoinData.length]?.group_title ?? '',
          className: newsFeedController.groupJoinData[index - newsFeedController.pageJoinData.length]?.group_name ?? '',
          classId: newsFeedController.groupJoinData[index - newsFeedController.pageJoinData.length]?.group_id ?? '',
        ),
        duration: const Duration(milliseconds: 400),
        transition: Transition.rightToLeft
      );
    }
  }
}