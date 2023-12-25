import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/news_feed_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_page_controller.dart';

class AnimatedSearchBar extends StatelessWidget {
  AnimatedSearchBar({
    super.key,
    required this.from,
  });

  final String from;

  final newsFeedController = Get.find<NewsFeedController>();
  final showPageController = Get.find<ShowPageController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    return Obx(
      () => AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        width: from == PostNewsFrom.newsFeedPage
          ? newsFeedController.folded.value ? 42.0 : (widthScreen - 28.0 - 28.0)
          : showPageController.folded.value ? 42.0 : (widthScreen - 28.0 - 28.0),
        height: 42.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32.0),
          color: HexColor('FFF4FA'),
          boxShadow: kElevationToShadow[0],
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                // height: 42.0,
                child: (from == PostNewsFrom.newsFeedPage ? !newsFeedController.folded.value : !showPageController.folded.value)
                  ? TextField(
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: 'Tìm kiếm',
                      hintStyle: GoogleFonts.raleway(
                        textStyle: TextStyle(fontSize: 14.0, height: 1.3, fontWeight: FontWeight.w500, color: HexColor('6F6F6F'))
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0)
                    ),
                    cursorColor: HexColor('6F6F6F'),
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(fontSize: 14.0, height: 1.3, fontWeight: FontWeight.w500, color: HexColor('6F6F6F'), decorationThickness: 0.0)
                    ),
                    textAlignVertical: TextAlignVertical.center,
                  )
                  : null,
              )
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(from == PostNewsFrom.newsFeedPage
                      ? newsFeedController.folded.value ? 21.0 : 0.0
                      : showPageController.folded.value ? 21.0 : 0.0
                    ),
                    topRight: const Radius.circular(21.0),
                    bottomLeft: Radius.circular(from == PostNewsFrom.newsFeedPage
                      ? newsFeedController.folded.value ? 21.0 : 0.0
                      : showPageController.folded.value ? 21.0 : 0.0
                    ),
                    bottomRight: const Radius.circular(21.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Image.asset(
                      'assets/images/search.png',
                      width: 24.0,
                      height: 24.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  onTap: () {
                    if (from == PostNewsFrom.newsFeedPage) {
                      newsFeedController.folded.value = !newsFeedController.folded.value;
                    } else if (from == PostNewsFrom.schoolPage) {
                      showPageController.folded.value = !showPageController.folded.value;
                    }
                  },
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}