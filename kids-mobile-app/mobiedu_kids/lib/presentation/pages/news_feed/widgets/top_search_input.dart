import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/home_page_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/news_feed_search_controller.dart';

class TopSearchInput extends StatelessWidget {
  TopSearchInput({
    super.key,
    required this.from,
    this.id,
    this.personName,
  });

  final String from;
  final String? id;
  final String? personName;

  final newsFeedSearchController = Get.find<NewsFeedSearchController>();

  @override
  Widget build(BuildContext context) {
    
    final homePageController = Get.find<HomePageController>(tag: personName);

    void handleChangeValueInput() {
      if (from == PostNewsFrom.newsFeedPage) {
        newsFeedSearchController.isSearch.value = false;
      } else if (from == PostNewsFrom.friendPage) {
        homePageController.searchFriends();
      }
    }

    void handlePressSubmit(String value) {
      if (value.isNotEmpty) {
        if (from == PostNewsFrom.newsFeedPage) {
          newsFeedSearchController.searchNewsFeed(value);
        } else if (from == PostNewsFrom.schoolPage || from == PostNewsFrom.classPage) {
          newsFeedSearchController.searchDetailNewsFeed(newsFeedSearchController.searchDetailTextEditingController.text, TypeSearchDetail.posts, id);
        }
      }
    }
    
    void handlePressClear() {
      if (from == PostNewsFrom.newsFeedPage) {
        newsFeedSearchController.searchTextEditingController.text = '';
      } else if (from == PostNewsFrom.schoolPage || from == PostNewsFrom.classPage) {
        newsFeedSearchController.searchDetailTextEditingController.text = '';
      } else if (from == PostNewsFrom.friendPage) {
        homePageController.searchFriendController.text = '';
        homePageController.searchFriends();
      }
    }

    void handlePressBack() {
      Get.back();
      newsFeedSearchController.searchTextEditingController.text = '';
      newsFeedSearchController.searchDetailTextEditingController.text = '';
      homePageController.searchFriendController.text = '';
    }
    
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(top: context.responsive(12.0), bottom: context.responsive(10.0)),
          child: InkWell(
            onTap: () {
              handlePressBack();
            },
            child: Padding(
              padding: EdgeInsets.all(context.responsive(5.0)),
              child: Icon(CupertinoIcons.back, size: context.responsive(28.0), color: HexColor('783199')),
            ),
          ),
        ),
        SizedBox(width: context.responsive(10.0)),
        Expanded(
          child: TextField(
            controller: from == PostNewsFrom.newsFeedPage
              ? newsFeedSearchController.searchTextEditingController
              : (from == PostNewsFrom.schoolPage || from == PostNewsFrom.classPage)
                ? newsFeedSearchController.searchDetailTextEditingController
                : from == PostNewsFrom.friendPage
                  ? homePageController.searchFriendController
                  : null,
            enableSuggestions: false,
            autocorrect: false,
            textInputAction: TextInputAction.search,
            onChanged: (value) {
              handleChangeValueInput();
            },
            onSubmitted: (value) async {
              handlePressSubmit(value);
            },
            decoration: InputDecoration(
              hintText: 'Tìm kiếm',
              hintStyle: GoogleFonts.raleway(
                textStyle: TextStyle(
                  fontSize: context.responsive(14.0), 
                  height: context.responsive(1.3), 
                  fontWeight: FontWeight.w500, 
                  color: HexColor('6F6F6F')
                )
              ),
              filled: true,
              fillColor: HexColor('FFF4FA'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.responsive(21.0)),
                borderSide: const BorderSide(
                  width: 0, 
                  style: BorderStyle.none,
                )
              ),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: context.responsive(12.0), horizontal: context.responsive(16.0)),
              suffixIcon: InkWell(
                onTap: () {
                  handlePressClear();
                },
                borderRadius: BorderRadius.circular(context.responsive(21.0)),
                child: Padding(
                  padding: EdgeInsets.all(context.responsive(9.0)),
                  child: Icon(CupertinoIcons.xmark_circle_fill, size: context.responsive(20.0), color: HexColor('6F6F6F')),
                ),
              ),
              suffixIconConstraints: BoxConstraints(minWidth: context.responsive(42.0), maxHeight: context.responsive(42.0))
            ),
            cursorColor: HexColor('6F6F6F'),
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                fontSize: context.responsive(14.0), 
                height: context.responsive(1.3), 
                fontWeight: FontWeight.w500, 
                color: HexColor('6F6F6F'), 
                decorationThickness: 0.0
              )
            ),
            textAlignVertical: TextAlignVertical.center,
          )
        )
      ],
    );
  }
}