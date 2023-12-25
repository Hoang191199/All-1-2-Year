import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/presentation/controllers/messenger/messenger_controller.dart';
import 'package:mobiedu_kids/presentation/pages/messenger/chat_messenger.dart';
import 'package:mobiedu_kids/presentation/widgets/avatar_error.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class ConversationsDetail extends StatelessWidget {
  ConversationsDetail({
    super.key,
    this.keyConversations,
    this.avatar,
    this.name,
    this.email,
    this.isGroup
  });

  final String? keyConversations;
  final String? avatar;
  final String? name;
  final String? email;
  final String? isGroup;
  final messengerController = Get.find<MessengerController>();
  final textMessenger = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: GetX(
        init: messengerController,
        builder: (_) {
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: CupertinoPageScaffold(
              resizeToAvoidBottomInset: false,
              navigationBar: CupertinoNavigationBar(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 28.0),
                leading: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        messengerController.listUserInGroup.value = [];
                        Navigator.pop(context);
                      },
                      child: Icon(CupertinoIcons.back,
                        color: AppColors.primary
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child:
                            avatar == "" ?
                              ClipOval(
                                child: Image.asset('assets/images/avatar-mac-dinh.png',
                                  fit: BoxFit.cover
                                )
                              )
                            : ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: '$avatar',
                                progressIndicatorBuilder: (context, url, downloadProgress) => Container(),
                                errorWidget: (context, url, error) => const AvatarError(),
                                fit: BoxFit.cover,
                              ),
                            )
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('$name', 
                                  style: GoogleFonts.raleway(
                                    textStyle: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      overflow: TextOverflow.ellipsis
                                    ),
                                  ),
                                  maxLines: 1
                                ),
                                Text(email ?? '', 
                                  style: GoogleFonts.raleway(
                                    textStyle: TextStyle(
                                      color: AppColors.grey,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis
                                    ),
                                  ),
                                  maxLines: 1
                                ),
                              ],
                            )
                          )
                        ],
                      )
                    )
                  ],
                ),
                backgroundColor: Colors.white,
                border: const Border(),
              ), 
              child: messengerController.isLoading.value
              ? const SizedBox(
                  child: Center(
                    child: CircularLoadingIndicator(),
                  ),
                )
              :
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ChatMessenger(
                        image: avatar,
                        keyConversations: keyConversations,
                        isGroup: isGroup,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Container(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Row(
                        children: [
                          // GestureDetector(
                          //   onTap: () { 
                          //   },
                          //   child: Image.asset('assets/images/camera.png'),
                          // ),
                          // const SizedBox(width: 8.0),
                          // GestureDetector(
                          //   onTap: () { 
                          //   },
                          //   child: Image.asset('assets/images/icon_image.png'),
                          // ),
                          // const SizedBox(width: 8.0),
                          Expanded(
                            child: CupertinoTextField(
                              controller: textMessenger,
                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                              decoration: BoxDecoration(
                                color: AppColors.lightPink,
                                borderRadius: BorderRadius.circular(18.0)
                              )
                            )
                          ),
                          const SizedBox(width: 8.0),
                          GestureDetector(
                            onTap: () {
                              messengerController.sendMessager(keyConversations, textMessenger.text);
                              textMessenger.text = '';
                            },
                            child: Image.asset('assets/images/send.png')
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            )
          );
        }
      )
    );
  }
}
