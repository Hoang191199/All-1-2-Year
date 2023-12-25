import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/news_feed_search_controller.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_search_group_item.dart';
import 'package:mobiedu_kids/presentation/widgets/horizontal_divider_no_padding.dart';

class NewsFeedSearchGroup extends StatelessWidget {
  NewsFeedSearchGroup({super.key});

  final newsFeedSearchController = Get.find<NewsFeedSearchController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => newsFeedSearchController.searchGroupData.isNotEmpty
        ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: context.responsive(20.0)),
            Padding(
              padding: EdgeInsets.only(left: context.responsive(28.0)),
              child: Text(
                'Nhóm',
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w500, color: HexColor('6F6F6F'))
                ),
              ),
            ),
            SizedBox(height: context.responsive(4.0)),
            const HorizontalDividerNoPadding(),
            ListView.separated(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              shrinkWrap: true,
              separatorBuilder: (context, index) => const HorizontalDividerNoPadding(), 
              itemCount: newsFeedSearchController.searchGroupData.length,
              itemBuilder: (context, index) {
                final group = newsFeedSearchController.searchGroupData[index];
                return NewsFeedSearchGroupItem(group: group);
              },
            )
          ],
        )
        : Container()
    );
  }
}