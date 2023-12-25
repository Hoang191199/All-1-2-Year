import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/presentation/controllers/messenger/messenger_controller.dart';
import 'package:mobiedu_kids/presentation/pages/messenger/conversations_detail.dart';
import 'package:mobiedu_kids/presentation/pages/messenger/friend_messenger.dart';
import 'package:mobiedu_kids/presentation/widgets/avatar_error.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class MessengerPage extends StatelessWidget {
  MessengerPage({super.key});

  final messengerController = Get.find<MessengerController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    
    return GetX(
      init: messengerController,
      initState: (state) {
      },
      builder: (_) {
        return Scaffold(
          body: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: CupertinoPageScaffold(
              resizeToAvoidBottomInset: false,
              navigationBar: CupertinoNavigationBar(
                padding:  const EdgeInsetsDirectional.symmetric(horizontal: 28.0),
                leading: GestureDetector(
                  onTap: () async {
                    await messengerController.getListFriend();
                    Get.to(()=> FriendMessenger());
                  },
                  child: Container(
                    width: 40.0,
                    color: Colors.transparent,
                    child: Icon(
                      Icons.groups_2,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                middle: Text('Tin nhắn',
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      color: AppColors.primary,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                trailing: GestureDetector(
                  onTap: () {
                  },
                  child: Icon(
                    Icons.search,
                    size: 24.0,
                    color: AppColors.pink,
                  ),
                ),
                backgroundColor: Colors.white,
              ), 
              child: messengerController.isLoadingListChat.value
              ? const SizedBox(
                  child: Center(
                    child: CircularLoadingIndicator(),
                  ),
                )
              : 
              messengerController.checkData.value == true ?
              SizedBox(
                width: widthScreen,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/no_assig.png'
                    ),
                    const SizedBox(height: 8.0),
                    Text('Bạn chưa nhắn tin với ai', 
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: AppColors.grey,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    )
                  ]
                ),
              )
            : Column(
                children: [
                  CupertinoSearchTextField(
                    controller: messengerController.search,
                    backgroundColor: AppColors.lightPink2,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                    placeholder: 'Tìm kiếm',
                    placeholderStyle: GoogleFonts.raleway(
                      textStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: GoogleFonts.raleway(
                      textStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onSuffixTap: () {
                      messengerController.search.text = '';
                    },
                    itemSize: 20,
                    autofocus: false,
                    autocorrect: true,
                    prefixIcon: const SizedBox()
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 8.0),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      height: double.infinity,
                      color: Colors.white,
                      child: StreamBuilder(
                        stream: messengerController.getListChatStream(),
                        builder: (context, snapshot){
                           if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          } else {
                            if(snapshot.data == null){
                              return const Center(
                                child: CircularLoadingIndicator(),
                              );
                            }else{
                              if(snapshot.data?.isNotEmpty ?? false){
                                List<dynamic>? data = snapshot.data;
                                data?.sort((a, b) => (toUtcDateTime(b['lastTimeUpdated'])).compareTo(toUtcDateTime(a['lastTimeUpdated'])));
                                if (messengerController.search.text.isNotEmpty) {
                                  data = data?.where((element) {
                                    String fullName = (element['fullName'] ?? '').toString().toLowerCase();
                                    String groupName = (element['nameGroup'] ?? '').toString().toLowerCase();
                                    String searchText = messengerController.search.text.toLowerCase();

                                    return fullName.contains(searchText) || groupName.contains(searchText);
                                  }).toList();
                                } 
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: data?.length,
                                  itemBuilder: (context, index) => 
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(()=> ConversationsDetail(
                                        avatar: (data?[index]['isGroup'] == '0' || data?[index]['isGroup'] == 'null') ? (data?[index]['avatar']) : (data?[index]['avatarGroup']),
                                        name: (data?[index]['isGroup'] == '0' || data?[index]['isGroup'] == 'null') ? (data?[index]['fullName']) : (data?[index]['nameGroup']),
                                        email: (data?[index]['isGroup'] == '0' || data?[index]['isGroup'] == 'null') ? (data?[index]['email']) : '',
                                        keyConversations: data?[index]['conversation_key'],
                                        isGroup: data?[index]['isGroup'],
                                      ));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 16.0),
                                      child:  Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 60.0,
                                                  height: 60.0,
                                                  decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: showImage(data?[index]['avatar'] ?? '',(data?[index]['avatarGroup'] ?? ''))
                                                ),
                                                const SizedBox(width: 12.0),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text((data?[index]['isGroup'] == '0' || data?[index]['isGroup'] == 'null') ? (data?[index]['fullName'] ) : (data?[index]['nameGroup'] ?? ''),
                                                        style: GoogleFonts.raleway(
                                                          textStyle: TextStyle(
                                                            color: AppColors.grey,
                                                            fontSize: 16.0,
                                                            fontWeight: FontWeight.w700,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                        maxLines: 1
                                                      ),
                                                      Html(
                                                        data: data?[index]['lastMessage'] ?? '',
                                                        style: {
                                                          'body': Style(
                                                            lineHeight: const LineHeight(1.6),
                                                            fontSize: FontSize(14.0),
                                                            fontWeight: FontWeight.w500,
                                                            color: AppColors.grey,
                                                            fontFamily: 'Raleway',
                                                            margin: Margins.zero,
                                                            padding: HtmlPaddings.zero,
                                                            textOverflow: TextOverflow.ellipsis,
                                                            maxLines: 1
                                                          )
                                                        },
                                                      ),
                                                    ],
                                                  )
                                                )
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            Icons.circle_sharp,
                                            color: data?[index]['isOnline'] == 1 ?  AppColors.pink : AppColors.grey,
                                            size: 14.0,
                                          )
                                        ]
                                      ),
                                    ),
                                  )
                                );
                              }else{
                                return  SizedBox(
                                  width: widthScreen,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/no_assig.png'
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text('Bạn chưa nhắn tin với ai', 
                                        style: GoogleFonts.raleway(
                                          textStyle: TextStyle(
                                            color: AppColors.grey,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      )
                                    ]
                                  ),
                                );
                              }
                            }
                          }
                        }
                      )
                    ),
                  ),
                ],
              ),
            ),
          )
        );
      }
    );
  }

  Widget showImage(String avatar, String avatarGroup){
    Widget image = ClipOval(
      child: Image.asset('assets/images/avatar-mac-dinh.png',
      fit: BoxFit.contain)
    );
    if(avatar != ''){
    image = ClipOval(
        child: CachedNetworkImage(
          imageUrl: avatar,
          progressIndicatorBuilder: (context, url, downloadProgress) => Container(),
          errorWidget: (context, url, error) => const AvatarError(),
          fit: BoxFit.cover,
        ),
      );
    }
    if(avatarGroup != ''){
      image = ClipOval(
        child: CachedNetworkImage(
          imageUrl: avatarGroup,
          progressIndicatorBuilder: (context, url, downloadProgress) => Container(),
          errorWidget: (context, url, error) => const AvatarError(),
          fit: BoxFit.cover,
        ),
      );
    }
    return image;
  }
}
