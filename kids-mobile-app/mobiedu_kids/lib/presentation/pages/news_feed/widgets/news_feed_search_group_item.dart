import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/group_join.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/class_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/item_image_rect.dart';

class NewsFeedSearchGroupItem extends StatelessWidget {
  const NewsFeedSearchGroupItem({
    super.key,
    this.group,
  });

  final GroupJoin? group;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        handlePressGroupItem(group);
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          context.responsive(28.0), 
          context.responsive(20.0), 
          context.responsive(20.0), 
          context.responsive(16.0)
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            group?.group_picture?.isEmpty ?? false
              ? Container(
                width: context.responsive(60.0),
                height: context.responsive(60.0),
                decoration: BoxDecoration(
                  color: HexColor('FFF4FA'),
                  borderRadius: BorderRadius.all(Radius.circular(context.responsive(6.0))),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/news-feed-page-group.png',
                    width: context.responsive(24.0),
                    height: context.responsive(24.0),
                    fit: BoxFit.cover,
                  ),
                ),
              )
              : ItemImageRect(
                imageUrl: group?.group_picture ?? '', 
                width: context.responsive(60.0),
                height: context.responsive(60.0), 
              ),
            SizedBox(width: context.responsive(7.0)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group?.group_title ?? '',
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      fontSize: context.responsive(16.0), 
                      height: context.responsive(1.5), 
                      fontWeight: FontWeight.w700, 
                      color: HexColor('783199')
                    )
                  )
                ),
                SizedBox(height: context.responsive(5.0)),
                Container(
                  padding: EdgeInsets.symmetric(vertical: context.responsive(4.0), horizontal: context.responsive(12.0)),
                  decoration: BoxDecoration(
                    color: group?.i_joined == GroupIJoin.approved ? HexColor('5DD89D') : HexColor('F67882'),
                    borderRadius: const BorderRadius.all(Radius.circular(100.0))
                  ),
                  child: Text(
                    group?.i_joined == GroupIJoin.approved ? 'Tham gia' : 'Chưa tham gia',
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w700, color: HexColor('FFFFFF'))
                    )
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  
  void handlePressGroupItem(GroupJoin? group) {
    Get.to(
      () => ClassPage(
        classTitle: group?.group_title ?? '',
        className: group?.group_name ?? '',
        classId: group?.group_id ?? ''
      ),
      duration: const Duration(milliseconds: 400),
      transition: Transition.rightToLeft
    );
  }
}