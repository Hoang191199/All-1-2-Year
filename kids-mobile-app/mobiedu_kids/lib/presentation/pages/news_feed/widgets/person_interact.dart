import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/contact/contact_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/contact/contact_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/home_page_controller.dart';

class PersonInteract extends StatelessWidget {
  const PersonInteract({
    super.key,
    required this.personName,
  });

  final String personName;

  @override
  Widget build(BuildContext context) {

    final homePageController = Get.find<HomePageController>(tag: personName);

    Future<void> handlePressFriend() async {
      if (homePageController.profileData.value?.we_friends ?? false) {
        await homePageController.friendsConnectFriend(ActionFriendsConnect.friendRemove);
      } else {
        if (homePageController.profileData.value?.i_request ?? false) {
          await homePageController.friendsConnectFriend(ActionFriendsConnect.friendCancel);
        } else {
          await homePageController.friendsConnectFriend(ActionFriendsConnect.friendAdd);
        }
      }
    }

    Future<void> handlePressFollow() async {
      if (homePageController.profileData.value?.i_follow ?? false) {
        await homePageController.friendsConnectFollow(homePageController.profileData.value?.user_id ?? '', ActionFriendsConnect.unfollow);
      } else {
        await homePageController.friendsConnectFollow(homePageController.profileData.value?.user_id ?? '', ActionFriendsConnect.follow);
      }
    }

    Future<void> handlePressMoreItem(BuildContext context, String type) async {
      Navigator.of(context).pop();
      switch (type) {
        case 'message':
          ContactBinding().dependencies();
          final contactController = Get.find<ContactController>();
          contactController.newChat(
            homePageController.profileData.value?.user_fullname ?? '', 
            homePageController.profileData.value?.user_id ?? '', 
            null, 
            homePageController.profileData.value?.user_picture ?? ''
          );
          break;
        case 'report':
          await homePageController.reportUser();
          break;
        default:
          break;
      }
    }

    Widget moreItem(String type) {
      return InkWell(
        onTap: () {
          handlePressMoreItem(context, type);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: context.responsive(10.0)),
          child: Row(
            children: [
              type == 'message'
                ? FaIcon(FontAwesomeIcons.facebookMessenger, size: context.responsive(18.0), color: HexColor('6F6F6F'))
                : type == 'report'
                  ? FaIcon(FontAwesomeIcons.commentSlash, size: context.responsive(18.0), color: HexColor('6F6F6F'))
                  : FaIcon(FontAwesomeIcons.userMinus, size: context.responsive(18.0), color: HexColor('6F6F6F')),
              SizedBox(width: context.responsive(20.0)),
              Text(
                type == 'message' ? 'Tin nhắn' : type == 'report' ? 'Báo cáo' : 'Chặn',
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(fontSize: context.responsive(16.0), fontWeight: FontWeight.w500, color: HexColor('464646'))
                )
              )
            ],
          ),
        ),
      );
    }

    void handlePressMore() {
      showDialog(
        context: context, 
        builder: (context) {
          return Dialog(
            backgroundColor: HexColor('FFFFFF'),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: context.responsive(20.0), horizontal: context.responsive(30.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  moreItem('message'),
                  SizedBox(height: context.responsive(10.0)),
                  moreItem('report'),
                  SizedBox(height: context.responsive(10.0)),
                  moreItem('block'),
                ],
              ),
            ),
          );
        },
      );
    }
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {
              handlePressFriend();
            },
            child: Column(
              children: [
                homePageController.profileData.value?.we_friends ?? false
                  ? FaIcon(FontAwesomeIcons.userCheck, size: context.responsive(14.0), color: HexColor('5DD89D'))
                  : homePageController.profileData.value?.i_request ?? false
                    ? FaIcon(FontAwesomeIcons.userMinus, size: context.responsive(14.0), color: HexColor('5DD89D'))
                    : FaIcon(FontAwesomeIcons.userPlus, size: context.responsive(14.0), color: HexColor('6F6F6F')),
                SizedBox(height: context.responsive(4.0)),
                Text(
                  homePageController.profileData.value?.we_friends ?? false
                    ? 'Bạn bè'
                    : homePageController.profileData.value?.i_request ?? false
                      ? 'Hủy yêu cầu'
                      : 'Thêm bạn',
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      fontSize: context.responsive(13.0), 
                      fontWeight: FontWeight.w500, 
                      color: HexColor(((homePageController.profileData.value?.i_request ?? false) || (homePageController.profileData.value?.we_friends ?? false)) ? '783199' : '464646')
                    )
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
              handlePressFollow();
            },
            child: Column(
              children: [
                Transform.rotate(
                  angle: 45 * pi / 180,
                  child: FaIcon(
                    FontAwesomeIcons.wifi, 
                    size: context.responsive(14.0), 
                    color: HexColor(homePageController.profileData.value?.i_follow ?? false ? '5DD89D' : '6F6F6F')),
                ),
                SizedBox(height: context.responsive(4.0)),
                Text(
                  homePageController.profileData.value?.i_follow ?? false ? 'Đang theo dõi' : 'Theo dõi',
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      fontSize: context.responsive(13.0), 
                      fontWeight: FontWeight.w500, 
                      color: HexColor(homePageController.profileData.value?.i_follow ?? false ? '783199' : '464646')
                    )
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
              handlePressMore();
            },
            child: Column(
              children: [
                FaIcon(FontAwesomeIcons.ellipsis, size: context.responsive(14.0), color: HexColor('6F6F6F')),
                SizedBox(height: context.responsive(4.0)),
                Text(
                  'Khác',
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(fontSize: context.responsive(13.0), fontWeight: FontWeight.w500, color: HexColor('464646'))
                  ),
                )
              ],
            ),
          )
        ),
      ],
    );
  }
}