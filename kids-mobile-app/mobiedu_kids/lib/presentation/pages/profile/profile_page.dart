import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/media/media_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/home_page_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/news_feed_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/saved_posts_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_group_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_page_binding.dart';
import 'package:mobiedu_kids/presentation/pages/init/init_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/person_page.dart';
import 'package:mobiedu_kids/presentation/pages/profile/comic_page.dart';
import 'package:mobiedu_kids/presentation/pages/profile/present_page.dart';
import 'package:mobiedu_kids/presentation/pages/profile/profile_setting_page.dart';
import 'package:mobiedu_kids/presentation/pages/profile/support_parent_page.dart';
import 'package:mobiedu_kids/presentation/pages/profile/video.dart';
import 'package:mobiedu_kids/presentation/pages/profile/widget/item_profile.dart';
import 'package:mobiedu_kids/presentation/widgets/avatar_error.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final store = Get.find<LocalStorageService>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.off(() => InitPage());
        return false;
      },
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: CupertinoPageScaffold(
          resizeToAvoidBottomInset: false,
          navigationBar: CupertinoNavigationBar(
            automaticallyImplyLeading: false,
            padding: const EdgeInsetsDirectional.only(top: 12.0),
            trailing: Container(
              margin: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => ProfileSettingPage());
                },
                child: Icon(
                  CupertinoIcons.gear,
                  color: AppColors.primary,
                ),
              ),
            ),
            middle: Text(
              'Tài khoản',
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
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    NewsFeedBinding().dependencies();
                    ShowPageBinding().dependencies();
                    ShowGroupBinding().dependencies();
                    HomePageBinding(store.userFromStorage?.user_name ?? '').dependencies();
                    SavedPostsBinding().dependencies();
                    Get.to(() => 
                      PersonPage(
                        personName: store.userFromStorage?.user_name ?? '',
                        personFullName: store.userFromStorage?.user_fullname ?? '',
                      ),
                      duration: const Duration(milliseconds: 400),
                      transition: Transition.rightToLeft
                    );
                  },
                  child: Container(
                    color: AppColors.lightPink2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: store.userFromStorage?.user_picture == '' ? 
                              Image.asset('assets/images/avatar-mac-dinh.png',
                                fit: BoxFit.contain
                              ) : 
                              CachedNetworkImage(
                                imageUrl: store.userFromStorage?.user_picture ??'',
                                progressIndicatorBuilder: (context, url, downloadProgress) => Container(),
                                errorWidget: (context, url, error) => const AvatarError(),
                                fit: BoxFit.cover,
                              )
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${store.userFromStorage?.user_fullname}",
                                  style: GoogleFonts.raleway(
                                    textStyle: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 16,
                                      fontWeight:FontWeight.w700
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  "Trang cá nhân",
                                  style: GoogleFonts.raleway(
                                    textStyle: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    )
                  ),
                ),
                Expanded(
                  child: ListView(
                    physics: const ClampingScrollPhysics(),
                    children: [
                      CupertinoButton(
                        onPressed: () {
                          MediaBinding().dependencies();
                          Get.to(() => SupportParentPage());
                        },
                        child: const ItemProfile(image: "assets/images/support.png", title: "Trợ lý cha mẹ")
                      ),
                      const Divider(thickness: 1.0),
                      CupertinoButton(
                        onPressed: () {
                          MediaBinding().dependencies();
                          Get.to(() => VideoPage());
                        },
                        child: const ItemProfile(image: "assets/images/video_stream.png", title: "Video")
                      ),
                      const Divider(thickness: 1.0),
                      CupertinoButton(
                        onPressed: () {
                          MediaBinding().dependencies();
                          Get.to(() => ComicPage());
                        },
                        child: const ItemProfile(image: "assets/images/comic.png", title: "Truyện")
                      ),
                      const Divider(thickness: 1.0),
                      CupertinoButton(
                        onPressed: () {
                          Get.to(() => PresentPage());
                        },
                        child: const ItemProfile(image: "assets/images/kids.png", title: "Giới thiệu mobiEdu Kids")
                      ),
                    ],
                  )
                )
              ],
            )
          )
        )
      )
    );
  }
}
