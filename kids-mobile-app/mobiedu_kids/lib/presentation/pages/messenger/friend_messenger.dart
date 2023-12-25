import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/domain/entities/firebase_messenger/add_group.dart';
import 'package:mobiedu_kids/presentation/controllers/messenger/messenger_controller.dart';
import 'package:mobiedu_kids/presentation/pages/messenger/conversations_detail.dart';
import 'package:mobiedu_kids/presentation/widgets/avatar_error.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class FriendMessenger extends StatelessWidget {
  FriendMessenger({super.key});

  final messengerController = Get.find<MessengerController>();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    
    return GetBuilder<MessengerController>(
      init: messengerController,
      initState: (state) async {
        scrollController.addListener(scrollListener);
      },
      didUpdateWidget: (old, newState) {
        scrollController.addListener(scrollListener);
      },
      dispose: (state) {
        scrollController.removeListener(scrollListener);
      },
      builder: (_) {
        return Scaffold(
          body: CupertinoPageScaffold(
            resizeToAvoidBottomInset: false,
            navigationBar: CupertinoNavigationBar(
              padding:  const EdgeInsetsDirectional.symmetric(horizontal: 28.0),
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  messengerController.listGroup.value = [];
                },
                child: Container(
                  width: 40.0,
                  color: Colors.transparent,
                  child: Icon(CupertinoIcons.back,
                    color: AppColors.primary,
                  ),
                ),
              ),
              middle: Text('Danh sách bạn bè',
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
                  messengerController.addGroupChat();
                },
                child: Icon(
                  Icons.groups_2,
                  size: 24.0,
                  color: AppColors.pink,
                )
              ),
              backgroundColor: Colors.white,
              border: const Border(),
            ), 
            child: messengerController.isLoadingFriend.value
              ? const SizedBox(
                  child: Center(
                    child: CircularLoadingIndicator(),
                  ),
                )
              : messengerController.checkDataFriend.value == true ?
              SizedBox(
                width: widthScreen,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/no_assig.png'
                    ),
                    const SizedBox(height: 8.0),
                    Text('Bạn chưa có bạn bè nào', 
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
            : Container(
                margin: const EdgeInsets.only(top: 8.0),
                height: double.infinity,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => 
                    messengerController.listGroup.isNotEmpty ?
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 8.0),
                      width: widthScreen,
                      color: AppColors.lightPink,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Đến: ',
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                color: AppColors.grey,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              child: Wrap(
                                spacing: 6.0,
                                runSpacing: 6.0,
                                children: List.generate(messengerController.listGroup.length, (index) {
                                   String comma = (index == messengerController.listGroup.length - 1) ? '' : ',';
                                  return Text(
                                    (messengerController.listGroup[index]?.fullName ?? '') + comma,
                                    style: GoogleFonts.raleway(
                                      textStyle: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  );
                                }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    : const SizedBox(),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: StreamBuilder(
                        stream: messengerController.getListFriendStream(),
                        builder: (context, snapshot) {
                          // if (snapshot.connectionState == ConnectionState.waiting) {
                          //   return const Center(
                          //     child: CircularLoadingIndicator(),
                          //   );
                          // } else if (snapshot.hasError) {
                          //     return Center(
                          //       child: Text('Error: ${snapshot.error}'),
                          //     );
                          //   } else 
                          if(snapshot.data?.isNotEmpty ?? false) 
                            {
                              messengerController.listData?.assignAll(snapshot.data ?? []);
                              messengerController.listData?.sort((a, b) => (toUtcDateTime(b['lastTimeUpdated'])).compareTo(toUtcDateTime(a['lastTimeUpdated']))); 
                              messengerController.initializeData(messengerController.listData?.length ?? 0);
                              return ListView.builder(
                                controller: scrollController,
                                shrinkWrap: true,
                                itemCount: snapshot.connectionState == ConnectionState.waiting ? (messengerController.listData?.length ?? 0 + 1) : messengerController.listData?.length,
                                itemBuilder: (context, index) {
                                  if (index < (messengerController.listData?.length ?? 0)) {
                                      return GestureDetector(
                                  onTap: () {
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 6.0, top: 12.0),
                                    child:  Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Get.to(()=> ConversationsDetail(
                                                    avatar: messengerController.listData?[index]['avatar'],
                                                    name: messengerController.listData?[index]['fullName'],
                                                    email: messengerController.listData?[index]['email'],
                                                    keyConversations: messengerController.listData?[index]['conversation_key'],
                                                    isGroup: messengerController.listData?[index]['isGroup'],
                                                  ));
                                                },
                                                child: Container(
                                                  width: 60.0,
                                                  height: 60.0,
                                                  decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: 
                                                  messengerController.listData?[index]['avatar'] == ""?
                                                  ClipOval(
                                                    child: Image.asset('assets/images/avatar-mac-dinh.png',
                                                      fit: BoxFit.contain
                                                      )
                                                  )
                                                : ClipOval(
                                                    child: CachedNetworkImage(
                                                      imageUrl: messengerController.listData?[index]['avatar'] ?? '',
                                                      progressIndicatorBuilder: (context, url, downloadProgress) => Container(),
                                                      errorWidget: (context, url, error) => const AvatarError(),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                ),
                                              ),
                                              const SizedBox(width: 12.0),
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Get.to(()=> ConversationsDetail(
                                                      avatar: messengerController.listData?[index]['avatar'],
                                                      name: messengerController.listData?[index]['fullName'],
                                                      email: messengerController.listData?[index]['email'],
                                                      keyConversations: messengerController.listData?[index]['conversation_key'],
                                                      isGroup: messengerController.listData?[index]['isGroup'],
                                                    ));
                                                  },
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text('${messengerController.listData?[index]['fullName']}',
                                                        style: GoogleFonts.raleway(
                                                          textStyle: TextStyle(
                                                            color: AppColors.grey,
                                                            fontSize: 16.0,
                                                            fontWeight: FontWeight.w700,
                                                          ),
                                                        ),
                                                      ),
                                                      Html(
                                                        data: messengerController.listData?[index]['lastMessage'] ?? '',
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
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Obx(() {
                                          return Checkbox(
                                            checkColor: Colors.white,
                                            activeColor: AppColors.green,
                                            value: messengerController.checkBox[index],
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                            onChanged: (bool? value) {
                                              messengerController.checkBox[index] = value!;
                                              if(messengerController.checkBox[index] == true){
                                                AddGroup newGroup = AddGroup(
                                                  fullName: messengerController.listData?[index]['fullName'],
                                                  userId: messengerController.listData?[index]['friend_id'],
                                                );
                                                messengerController.listGroup.add(newGroup);
                                              }else{
                                                messengerController.listGroup.removeWhere((item) => item?.userId == messengerController.listData?[index]['friend_id']);
                                              }
                                            },
                                          );
                                        }
                                      )
                                    ]
                                  ),
                                ),
                              );
                              } else { 
                                return const Center(
                                  child: CircularLoadingIndicator(),
                                );
                              }
                            } 
                          );
                        }else{
                          return const Center(
                            child: CircularLoadingIndicator(),
                          );
                        }
                        },
                      ),
                    ),
                  ),
                ],
              )
            ),
          )
        );
      }
    );
  }

  Future<void> scrollListener() async {
    if(messengerController.flagLoadMoreFriend.value == false){
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        await messengerController.loadMoreFriend();
        messengerController.checkLoadMoreFriend.value = messengerController.listData?.length ?? 0;
        await messengerController.getListFriend();
      }
    }
    if(messengerController.checkLoadMoreFriend.value == messengerController.listData?.length){
      messengerController.flagLoadMoreFriend.value = true;
    }
  }
}
