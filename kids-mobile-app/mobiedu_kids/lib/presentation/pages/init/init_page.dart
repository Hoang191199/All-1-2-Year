import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/app/types/tab_type.dart';
import 'package:mobiedu_kids/presentation/controllers/growth/growth_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/infomation/infomation_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/infomation/infomation_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/init_page_tab_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/list_student/child_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/manager/manager_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/messenger/messenger_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/home_page_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/news_feed_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/news_feed_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/saved_posts_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_group_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_page_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/notification/notification_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/prescription/prescription_child_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/prescription/prescription_child_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/rest/rest_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/rest/rest_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/splash/splash_controller.dart';
import 'package:mobiedu_kids/presentation/pages/information/information_page.dart';
import 'package:mobiedu_kids/presentation/controllers/notification/notification_binding.dart';
import 'package:mobiedu_kids/presentation/pages/manager/manager_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/health/health_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/prescription_parent/prescription_parent.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/rest/rest_page.dart';
import 'package:mobiedu_kids/presentation/pages/messenger/messenger.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/news_feed_page.dart';
import 'package:mobiedu_kids/presentation/pages/notification/notification_page.dart';
import 'package:mobiedu_kids/presentation/pages/profile/profile_page.dart';

class InitPage extends StatelessWidget {
  InitPage({
    super.key,
    this.index,
  });

  final int? index;
  final splashController = Get.find<SplashScreenController>();
  final store = Get.find<LocalStorageService>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    final initPageTabController = Get.put(InitPageTabController());
    // if (index != null) {
    //   initPageTabController.changeIndexTab(index);
    // }
    return GetX(
      init: splashController,
      builder: (_) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Stack(
            children: [
              CupertinoTabScaffold(
                backgroundColor: AppColors.black,
                controller: initPageTabController.cupertinoTabController,
                tabBar: CupertinoTabBar(
                  items: splashController.responseManagerData.value?.data?.classes?.isNotEmpty ?? false ? 
                    ([
                      TabType.manager,
                      TabType.news,
                      TabType.messenger,
                      TabType.notification,
                      TabType.profile,
                    ].map((type) {
                      return BottomNavigationBarItem(
                        icon: type.icon,
                        activeIcon: type.activeIcon,
                      );
                    }).toList())
                  : ([
                      TabType.information,
                      TabType.manager,
                      TabType.messenger,
                      TabType.notification,
                      TabType.profile,
                    ].map((type) {
                      return BottomNavigationBarItem(
                        icon: type.icon,
                        activeIcon: type.activeIcon,
                      );
                    }).toList()),
                  height: 70.0,
                  inactiveColor: AppColors.pink,
                  activeColor: AppColors.primary,
                  backgroundColor: Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: AppColors.grey2
                    )
                  ),
                  onTap: (value) async {
                    if (splashController.responseManagerData.value?.data?.classes?.isNotEmpty ?? false) {
                      if (value == 0) {
                        ChildBinding().dependencies();
                        Get.find<ManagerController>();
                      } else if (value == 1) {
                        NewsFeedBinding().dependencies();
                        ShowPageBinding().dependencies();
                        ShowGroupBinding().dependencies();
                        HomePageBinding('').dependencies();
                        SavedPostsBinding().dependencies();
                        final newsFeedController = Get.find<NewsFeedController>();
                        newsFeedController.getPageGroupJoined();
                        newsFeedController.getListNewsFeed();
                      } else if (value == 2) {
                        final messengerController = Get.put(MessengerController());
                        await messengerController.getListChat();
                      }
                    } else {
                      if (value == 0) {
                        InformationBinding().dependencies();
                        PrescriptionChildBinding().dependencies();
                        final informationController = Get.find<InformationController>();
                        final prescriptionChildController = Get.find<PrescriptionChildController>();
                        informationController.fetchData();
                        prescriptionChildController.fetchData();
                      } else if (value == 1) {
                        ChildBinding().dependencies();
                      }
                      else if (value == 2) {
                        return;
                      }
                    }
                    if (value == 3) {
                      NotificationBinding().dependencies();
                      final notificationController = Get.find<NotificationController>();
                      notificationController.fetchData();
                      notificationController.setCountNotifications();
                      splashController.isShowNotification.value = true;
                    }
                  },
                ),
                tabBuilder: (context, index) {
                  final type = splashController.responseManagerData.value?.data?.classes?.isNotEmpty ?? false ? 
                    ([
                      TabType.manager,
                      TabType.news,
                      TabType.messenger,
                      TabType.notification,
                      TabType.profile,
                    ][index])
                  : ([
                      TabType.information,
                      TabType.manager,
                      TabType.messenger,
                      TabType.notification,
                      TabType.profile,
                    ][index]);
                  if (splashController.responseManagerData.value?.data?.classes?.isNotEmpty ?? false) {
                    switch (type) {
                      case TabType.manager:
                      InformationBinding().dependencies();
                      ChildBinding().dependencies();
                        return ManagerPage();
                      case TabType.news:
                        NewsFeedBinding().dependencies();
                        ShowPageBinding().dependencies();
                        ShowGroupBinding().dependencies();
                        HomePageBinding('').dependencies();
                        SavedPostsBinding().dependencies();
                        return NewsFeedPage();
                      case TabType.messenger:
                        return MessengerPage();
                      case TabType.notification:
                        NotificationBinding().dependencies();
                        return NotificationPage();
                      case TabType.profile:
                        return ProfilePage();
                      default:
                        return const SizedBox();
                    }
                  } else {
                    switch (type) {
                      case TabType.information:
                        InformationBinding().dependencies();
                        PrescriptionChildBinding().dependencies();
                        return InformationPage();
                      case TabType.manager:
                      ChildBinding().dependencies();
                        return ManagerPage();
                      case TabType.messenger:
                        return AbsorbPointer(
                          child: Container(),
                        );
                      case TabType.notification:
                        NotificationBinding().dependencies();
                        return NotificationPage();
                      case TabType.profile:
                        return ProfilePage();
                      default:
                        return const SizedBox();
                    }
                  }
                },
              ),
              if (splashController.responseManagerData.value?.data?.classes?.isEmpty ??false)
                Positioned(
                  bottom: MediaQuery.of(context).padding.bottom,
                  left: (widthScreen / 2) - 40.0,
                  child: Container(
                    width: 80.0,
                    height: 70.0,
                    color: Colors.transparent,
                  )
                ),
              if (splashController.responseManagerData.value?.data?.classes?.isEmpty ??false)
                Positioned(
                  bottom: bottomPadding + 26.0,
                  left: (widthScreen / 2) - 28.0,
                  child: Container(
                    width: 56.0,
                    height: 56.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          HexColor('FF9ACE'),
                          HexColor('783199'),
                        ],
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(100.0))
                    ),
                    child: Center(
                      child: SpeedDial(
                        renderOverlay: true,
                        overlayOpacity: 0.4,
                        backgroundColor: Colors.transparent,
                        icon: CupertinoIcons.add,
                        activeIcon: CupertinoIcons.xmark,
                        gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          HexColor('FF9ACE'),
                          HexColor('783199'),
                        ],
                        ),
                        gradientBoxShape: BoxShape.circle,
                        overlayColor: AppColors.black,
                        children: [
                          SpeedDialChild(                  
                            child: Image.asset(
                              'assets/images/thuoc-info.png',
                              width: 24.0,
                              height: 24.0,
                              fit: BoxFit.cover
                            ),                  
                            label: 'Chỉ số sức khỏe',
                            labelBackgroundColor: Colors.white,    
                            labelStyle: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                fontSize: 14.0,
                                color: AppColors.black,
                                fontWeight: FontWeight.w700
                              )
                            ), 
                            onTap: () async {
                              GrowthBinding().dependencies();
                              Get.to(() => HealthChildPage(
                                child_parent_id: store.getChild?.child_parent_id ?? "",
                              ));
                            },
                          ),
                          SpeedDialChild(                  
                            child: Image.asset(
                              'assets/images/album-info.png',
                              width: 24.0,
                              height: 24.0,
                              fit: BoxFit.cover
                            ),                  
                            label: 'Xin nghỉ',
                            labelBackgroundColor: Colors.white,    
                            labelStyle: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                fontSize: 14.0,
                                color: AppColors.black,
                                fontWeight: FontWeight.w700
                              )
                            ), 
                            onTap: () async {
                              RestBinding().dependencies();
                              final restController = Get.find<RestController>();
                              await restController.fetchData();
                              return Get.to(() => RestPage());
                            },
                          ),
                          SpeedDialChild(                  
                            child: Image.asset(
                              'assets/images/xin-nghi.png',
                              width: 24.0,
                              height: 24.0,
                              fit: BoxFit.cover
                            ),                  
                            label: 'Đơn thuốc',
                            labelBackgroundColor: Colors.white,    
                            labelStyle: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                fontSize: 14.0,
                                color: AppColors.black,
                                fontWeight: FontWeight.w700
                              )
                            ), 
                            onTap: () async {
                              PrescriptionChildBinding().dependencies();
                              final prescriptionChildController = Get.find<PrescriptionChildController>();
                              await prescriptionChildController.fetchData();
                              return Get.to(() => PrescriptionParent());
                            },
                          ),
                        ],
                      )
                      // Icon(CupertinoIcons.add, color: HexColor('FFFFFF')),
                    ),
                  )
                ), 
            ],
          ),
        );
      }
    );
  }
}
