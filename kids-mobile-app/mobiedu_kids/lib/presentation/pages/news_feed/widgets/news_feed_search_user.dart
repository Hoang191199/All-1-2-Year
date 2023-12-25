import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/user.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/home_page_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/news_feed_search_controller.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/person_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_avatar.dart';
import 'package:mobiedu_kids/presentation/widgets/horizontal_divider_no_padding.dart';

class NewsFeedSearchUser extends StatelessWidget {
  NewsFeedSearchUser({super.key});

  final newsFeedSearchController = Get.find<NewsFeedSearchController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => newsFeedSearchController.searchUserData.isNotEmpty
        ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: context.responsive(20.0)),
            Padding(
              padding: EdgeInsets.only(left: context.responsive(28.0)),
              child: Text(
                'Người dùng',
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
              itemCount: newsFeedSearchController.searchUserData.length,
              itemBuilder: (context, index) {
                final user = newsFeedSearchController.searchUserData[index];
                return InkWell(
                  onTap: () {
                    handlePressUserItem(user);
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      context.responsive(28.0), 
                      context.responsive(18.0), 
                      context.responsive(20.0), 
                      context.responsive(18.0)
                    ),
                    child: Row(
                      children: [
                        NewsFeedAvatar(imageNetwork: user.user_picture),
                        SizedBox(width: context.responsive(8.0)),
                        Text(
                          user.user_fullname ?? '',
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w700, color: HexColor('464646'))
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        )
        : Container()
    );
  }

  void handlePressUserItem(User user) {
    HomePageBinding(user.user_name ?? '').dependencies();
    Get.to(
      () => PersonPage(
        personName: user.user_name ?? '',
        personFullName: user.user_fullname ?? '',
      ),
      duration: const Duration(milliseconds: 400),
      transition: Transition.rightToLeft
    );
  }
}