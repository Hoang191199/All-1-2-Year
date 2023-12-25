import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/presentation/controllers/notification/notification_controller.dart';
import 'package:mobiedu_kids/presentation/pages/notification/widgets/notification_avatar.dart';

class NotificationFriendRequest extends StatelessWidget {
  NotificationFriendRequest({super.key});

  final notificationController = Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 28.0, top: 6.0),
          child: Text(
            'Lời mời kết bạn',
            style: GoogleFonts.raleway(
              textStyle: TextStyle(fontSize: 14.0, height: 1.3, fontWeight: FontWeight.w700, color: HexColor('464646'))
            ),
          ),
        ),
        Obx(
          () => Container(
            padding: EdgeInsets.only(
              top: notificationController.friendRequestsData.isNotEmpty ? 8.0 : 16.0, 
              bottom: 16.0
            ),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: HexColor('D8D8D8')))
            ),
            child: notificationController.friendRequestsData.isNotEmpty
              ? ListView.builder(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                shrinkWrap: true,
                itemCount: notificationController.friendRequestsData.length,
                itemBuilder: (context, index) {
                  final friendRequest = notificationController.friendRequestsData[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 15.0),
                    child: Row(
                      children: [
                        NotificationAvatar(userPicture: friendRequest?.user_picture),
                        const SizedBox(width: 7.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (friendRequest?.user_fullname != null && (friendRequest?.user_fullname?.isNotEmpty ?? false))
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10.0),
                                  child: Text(
                                    friendRequest?.user_fullname ?? '',
                                    style: GoogleFonts.raleway(
                                      textStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: HexColor('464646'))
                                    ),
                                  ),
                                ),
                              Row(
                                children: [
                                  optionButton('ok', friendRequest?.user_id),
                                  const SizedBox(width: 20.0),
                                  optionButton('cancel', friendRequest?.user_id)
                                ],
                              )
                            ],
                          )
                        )
                      ],
                    ),
                  );
                },
              )
              : Center(
                child: Text(
                  'Không có lời mời kết bạn mới',
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(fontSize: 12.0, height: 1.25, fontWeight: FontWeight.w500, color: HexColor('464646'))
                  ),
                ),
              ),
          )
        )
      ],
    );
  }

  Widget optionButton(String type, String? friendId) {
    return SizedBox(
      width: 100.0,
      height: 30.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          backgroundColor: HexColor(type == 'ok' ? 'FF9ACE' : 'F2F2F2')
        ),
        child: Text(
          type == 'ok' ? 'Xác nhận' :'Hủy',
          style: GoogleFonts.raleway(
            textStyle: TextStyle(fontSize: 12.0, height: 1.25, fontWeight: FontWeight.w700, color: HexColor(type == 'ok' ? 'FFFFFF' : '464646'))
          ),
        ), 
        onPressed: () {
          handlePressOptionButton(type, friendId);
        },
      ),
    );
  }
  
  Future<void> handlePressOptionButton(String type, String? friendId) async {
    if (friendId != null && friendId.isNotEmpty) {
      final actionFriend = type == 'ok' ? ActionFriendsConnect.friendAccept : ActionFriendsConnect.friendDecline;
      await notificationController.friendsConnect(friendId, actionFriend);
    }
  }
}