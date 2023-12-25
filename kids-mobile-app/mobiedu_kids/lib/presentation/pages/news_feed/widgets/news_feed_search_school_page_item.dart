import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/page_join.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/school_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/item_image_rect.dart';

class NewsFeedSearchSchoolPageItem extends StatelessWidget {
  const NewsFeedSearchSchoolPageItem({
    super.key,
    this.page,
  });

  final PageJoin? page;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        handlePressSchoolPageItem(page);
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
            page?.page_picture?.isEmpty ?? false
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
                imageUrl: page?.page_picture ?? '', 
                width: context.responsive(60.0),
                height: context.responsive(60.0), 
              ),
            SizedBox(width: context.responsive(7.0)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    page?.page_title ?? '',
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
                      color: (page?.i_like ?? false) ? HexColor('5DD89D') : HexColor('F67882'),
                      borderRadius: const BorderRadius.all(Radius.circular(100.0))
                    ),
                    child: Text(
                      (page?.i_like ?? false) ? 'Đã thích trang' : 'Chưa thích trang',
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w700, color: HexColor('FFFFFF'))
                      )
                    ),
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
  
  void handlePressSchoolPageItem(PageJoin? page) {
    Get.to(
      () => SchoolPage(
        pageTitle: page?.page_title ?? '',
        pageName: page?.page_name ?? '',
        pageId: page?.page_id ?? '',
      ),
      duration: const Duration(milliseconds: 400),
      transition: Transition.rightToLeft
    );
  }
}