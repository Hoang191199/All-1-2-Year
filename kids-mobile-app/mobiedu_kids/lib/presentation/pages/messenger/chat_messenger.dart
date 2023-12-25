import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/domain/entities/firebase_messenger/add_group.dart';
import 'package:mobiedu_kids/presentation/controllers/messenger/messenger_controller.dart';
import 'package:mobiedu_kids/presentation/widgets/avatar_error.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

// ignore: must_be_immutable
class ChatMessenger extends StatelessWidget {
  ChatMessenger({
    super.key,
    this.image,
    this.keyConversations,
    this.isGroup
  });
  
  String? image;
  String? keyConversations;
  String? isGroup;

  final messengerController = Get.find<MessengerController>();
  final store = Get.find<LocalStorageService>();
  final scrollController = ScrollController();
  List<dynamic> listData = [];

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    
    return GetBuilder<MessengerController>(
      init: messengerController,
      initState: (state) async {
        scrollController.addListener(scrollListener);
        if(isGroup == '1'){
          messengerController.getInfoUserInGroup(keyConversations);
        }
      },
      didUpdateWidget: (old, newState) {
        scrollController.addListener(scrollListener);
      },
      dispose: (state) {
        scrollController.removeListener(scrollListener);
      },
      builder: (_) {
      return messengerController.isLoadingMore.value
      ? const SizedBox(
          child: Center(
            child: CircularLoadingIndicator(),
          ),
        )
      :
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          StreamBuilder(
            stream: messengerController.getMessenger(keyConversations),
            builder: (context, AsyncSnapshot<DatabaseEvent> snapshot){
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                if(snapshot.data?.snapshot.value == null){
                  return Container();
                }else{
                  Map<dynamic, dynamic> mapData = snapshot.data?.snapshot.value as dynamic;
                  listData.clear();
                  listData = mapData.values.toList();
                  listData.sort((a, b) => (a['time'] ?? '2023-07-24 10:14:09').compareTo(b['time'] ?? '2023-07-24 10:14:09'));
                  return ListView.builder(
                    controller: scrollController,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.snapshot.children.length,
                    itemBuilder: (context, index) {
                      String currentHour = formatDate(listData[index]['time'] ?? '2023-07-24 10:14:09');
                      String previousHour = '';
                      if (index > 0) {
                        previousHour = formatDate(listData[index - 1]['time'] ?? '2023-07-24 10:14:09');
                      }
                      Widget dateTextWidget = previousHour == currentHour ? const SizedBox()
                    : Text(
                        currentHour,
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: AppColors.grey,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                      String? avatarUser;
                      if(isGroup == '1'){
                        AddGroup? matchedUser = messengerController.listUserInGroup.firstWhere((item) => item?.userId == listData[index]['userId'],orElse: () => null,);
                        avatarUser = matchedUser?.image;
                      }
                      return Column(
                        children: [
                          dateTextWidget,
                          Row(
                            mainAxisAlignment: listData[index]['userId'] != '_${store.userFromStorage?.user_id}' ? MainAxisAlignment.start : MainAxisAlignment.end,
                            children: [
                              listData[index]['userId'] != '_${store.userFromStorage?.user_id}' ? 
                              Container(
                                width: 40.0,
                                height: 40.0,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child:
                                  isGroup == '0' ? 
                                    image == "" ? 
                                      ClipOval(
                                        child: Image.asset(
                                          'assets/images/avatar-mac-dinh.png',
                                          fit: BoxFit.contain
                                        )
                                      )
                                    : ClipOval(
                                        child: CachedNetworkImage(
                                          imageUrl: '$image',
                                          progressIndicatorBuilder: (context, url, downloadProgress) => Container(),
                                          errorWidget: (context, url, error) => const AvatarError(),
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                : ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: '$avatarUser',
                                      progressIndicatorBuilder: (context, url, downloadProgress) => Container(),
                                      errorWidget: (context, url, error) => const AvatarError(),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                              const SizedBox(width: 8.0,),
                                Container(
                                  constraints: BoxConstraints(
                                    maxWidth: widthScreen * 0.66,
                                    maxHeight: heightScreen,
                                  ),
                                  decoration: BoxDecoration(
                                    color: listData[index]['userId'] != '_${store.userFromStorage?.user_id}' ? AppColors.lightPink2 : AppColors.primary,
                                    borderRadius: BorderRadius.circular(18.0)
                                  ),
                                  padding: const EdgeInsets.all(10.0),
                                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Text(
                                    listData[index]['content'],
                                    style: GoogleFonts.raleway(
                                      textStyle: TextStyle(
                                        color: listData[index]['userId'] !='_${store.userFromStorage?.user_id}' ? AppColors.black : Colors.white,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                      }
                    );
                  }
                }
              }
            ),
        ],
      );
      }
    );
  }

  Future<void> scrollListener() async {
    if(messengerController.flagLoadMore.value == false){
      if (scrollController.position.pixels >= (scrollController.position.maxScrollExtent * 0.8)) {
        await messengerController.loadMoreMessages();
        messengerController.checkLoadMore.value = listData.length;
      }
    }
    if(messengerController.checkLoadMore.value == listData.length){
      messengerController.flagLoadMore.value = true;
    }
  }

  int parseTimeStringToTimestamp(String timeString) {
    DateTime dateTime = DateTime.parse(timeString);
    return dateTime.millisecondsSinceEpoch;
  }

  String formatDate(String dateString) {
    List<String> dateTimeParts = dateString.split(' ');
    String datePart = dateTimeParts[0];
    String timePart = dateTimeParts[1];
    List<String> timeParts = timePart.split(':');
    String seconds = timeParts[2];
    if (seconds.length < 2) {
      seconds = seconds.padLeft(2, '0');
    }
    String house = timeParts[0];
    if (house.length < 2) {
      house = house.padLeft(2, '0');
    }

    timePart = '$house:${timeParts[1]}:$seconds';
    dateString = '$datePart $timePart';
    DateTime dateTime = DateTime.parse(dateString);
    int currentYear = DateTime.now().year;

    String formatString = dateTime.year == currentYear ? "HH:mm, dd MMM" : "HH:mm, dd MMM, yyyy";
    String formattedDate = DateFormat(formatString).format(dateTime);

    formattedDate = formattedDate.replaceAllMapped(
      RegExp(r'[A-Za-z]+'),
      (match) => _getVietnameseMonth(match.group(0)!),
    );

    return formattedDate;
  }

  // String formatDate(String dateString) {
  //   DateTime dateTime = DateTime.parse(dateString);
  //   int currentYear = DateTime.now().year;

  //   String formatString =
  //       dateTime.year == currentYear ? "HH:mm, dd MMM" : "HH:mm, dd MMM, yyyy";
  //   String formattedDate = DateFormat(formatString).format(dateTime);

  //   formattedDate = formattedDate.replaceAllMapped(
  //     RegExp(r'[A-Za-z]+'),
  //     (match) => _getVietnameseMonth(match.group(0)!),
  //   );

  //   return formattedDate;
  // }

  String _getVietnameseMonth(String monthName) { 
    switch (monthName.toLowerCase()) {
      case 'jan':
        return 'THG 1';
      case 'feb':
        return 'THG 2';
      case 'mar':
        return 'THG 3';
      case 'apr':
        return 'THG 4';
      case 'may':
        return 'THG 5';
      case 'jun':
        return 'THG 6';
      case 'jul':
        return 'THG 7';
      case 'aug':
        return 'THG 8';
      case 'sep':
        return 'THG 9';
      case 'oct':
        return 'THG 10';
      case 'nov':
        return 'THG 11';
      case 'dec':
        return 'THG 12';
      default:
        return monthName;
    }
  }

}