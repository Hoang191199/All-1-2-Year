import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/create_edit_post_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/news_feed_avatar.dart';

class WhatThing extends StatelessWidget {
  WhatThing({
    super.key,
    required this.from
  });

  final String from;

  final store = Get.find<LocalStorageService>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        handlePressCreatePost();
      },
      child: Column(
        children: [
          SizedBox(height: context.responsive(8.0)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.responsive(28.0)),
            child: Row(
              children: [
                NewsFeedAvatar(imageNetwork: store.userFromStorage?.user_picture),
                SizedBox(width: context.responsive(8.0)),
                Text(
                  'Bạn đang nghĩ gì?',
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w500, color: HexColor('6F6F6F'))
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  void handlePressCreatePost() {
    Get.to(
      () => CreateEditPostPage(
        from: from,
        type: 'create'
      ),
      duration: const Duration(milliseconds: 400),
      transition: Transition.rightToLeft
    );
  }
}