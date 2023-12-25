import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/presentation/widgets/avatar_error.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/list_student/child_controller.dart';

class SearchUserPage extends StatelessWidget {
  SearchUserPage({super.key});

  final childController = Get.find<ChildController>();
  final store = Get.find<LocalStorageService>();

  @override
  Widget build(BuildContext context) {
    // double widthScreen = MediaQuery.of(context).size.width;
    // double bottomPadding = MediaQuery.of(context).padding.bottom;
    return GetX(
      init: childController,
      initState: (state) async {
        childController.searchParents.value = [];
        childController.search.text = "";
      },
      builder: (state) => GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: CupertinoPageScaffold(
          resizeToAvoidBottomInset: false,
          navigationBar: CupertinoNavigationBar(
            padding: const EdgeInsetsDirectional.only(top: 12.0),
            leading: Container(
              margin: const EdgeInsets.only(left: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  CupertinoIcons.back,
                  color: AppColors.primary,
                ),
              ),
            ),
            middle: Text(
              'Thêm phụ huynh',
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                  color: AppColors.primary,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700
                ),
              ),
            ),
            backgroundColor: Colors.white,
            border: const Border(),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10, left: 28, right: 28),
                child: CupertinoButton(
                  pressedOpacity: 0.65,
                  color: AppColors.lightPink,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Expanded(
                        child: CupertinoTextField(
                          controller: childController.search,
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              color: AppColors.black,
                            ),
                          ),
                          placeholder: "Tìm kiếm phụ huynh",
                          placeholderStyle: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              color: AppColors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          autofocus: false,
                          autocorrect: true,
                          onChanged: (value) {
                            childController.searchUser(value, "0");
                          },
                          onSubmitted: (String value) {
                            childController.searchUser(value, "0");
                          },
                          decoration: const BoxDecoration(
                            border: Border()
                          ),
                        ),
                      ),
                      Icon(
                        CupertinoIcons.search,
                        color: AppColors.primary,
                      )
                    ]
                  ),
                  onPressed: () {},
                )
              ),
              childController.isSearching.value ? 
              const Expanded(
                child: Center(
                  child: CircularLoadingIndicator()
                )
              ) : 
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 20),
                  child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        childController.parents.add(childController.searchParents[index]);
                        childController.searchUser(childController.search.text, "0");
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 36.0,
                            height: 36.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: (childController.searchParents[index]?.user_picture == '' || childController.searchParents[index]?.user_picture ==  null) ? 
                              Image.asset(
                                'assets/images/avatar-mac-dinh.png',
                                fit: BoxFit.contain
                              ) : 
                              CachedNetworkImage(
                                imageUrl: childController.searchParents[index]?.user_picture ?? '',
                                progressIndicatorBuilder: (context,url, downloadProgress) =>Container(),
                                errorWidget:(context, url, error) =>const AvatarError(),
                                fit: BoxFit.cover
                              )
                            ),
                          ),
                          const SizedBox(width: 10),
                          (childController.searchParents[index]?.user_phone != "" && childController.searchParents[index]?.user_phone != null) ?
                          rowParent(childController.searchParents[index]?.user_fullname, childController.searchParents[index]?.user_phone, false) : 
                          rowParent(childController.searchParents[index]?.user_fullname, childController.searchParents[index]?.user_phone, true),
                          (childController.searchParents[index]?.user_phone != "" && childController.searchParents[index]?.user_phone != null) ? 
                          GestureDetector(
                            onTap: () async {
                              final Uri url = Uri(
                                scheme: 'tel',
                                path:'${childController.searchParents[index]?.user_phone}'
                              );
                              if (await UrlLauncher.canLaunchUrl(url)) {
                                await UrlLauncher.launchUrl(url);
                              }
                            },
                            child: Container(
                              width: 30.0,
                              height: 30.0,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: const ClipOval(
                                child: Image(
                                  image: AssetImage(
                                    'assets/images/phone.png',
                                  ),
                                  fit: BoxFit.cover
                                ),
                              ),
                            )
                          )
                          : const SizedBox(),
                        ],
                      )
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                  itemCount: childController.searchParents.length
                ),
              )
            )
          ]
        )
      )
    ));
  }

  Widget rowParent(String? userFullname, String? userPhone, bool? check){
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$userFullname",
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                color: AppColors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          check == false ?
          Text( "$userPhone",
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                color: AppColors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.w500
              ),
            ),
          ) :
          Text( "Chưa cập nhật",
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                color: AppColors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.w500
              ),
            ),
          )
        ],
      ),
    );
  }
}
