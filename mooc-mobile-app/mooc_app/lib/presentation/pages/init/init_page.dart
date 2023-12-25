import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mooc_app/app/config/app_colors.dart';
import 'package:mooc_app/app/config/app_common.dart';
import 'package:mooc_app/app/types/tab_type.dart';
import 'package:mooc_app/presentation/controllers/auth/auth_controller.dart';
import 'package:mooc_app/presentation/controllers/category/category_binding.dart';
import 'package:mooc_app/presentation/controllers/course_list/course_list_binding.dart';
import 'package:mooc_app/presentation/controllers/course_list/course_list_controller.dart';
import 'package:mooc_app/presentation/controllers/course_list/course_recommend_binding.dart';
import 'package:mooc_app/presentation/controllers/course_list/course_recommend_controller.dart';
import 'package:mooc_app/presentation/controllers/init_page_tab_controller.dart';
import 'package:mooc_app/presentation/controllers/learning/learning_course_list_binding.dart';
import 'package:mooc_app/presentation/controllers/profile/profile_binding.dart';
import 'package:mooc_app/presentation/controllers/search_api_controller/search_binding.dart';
import 'package:mooc_app/presentation/pages/home/home_page.dart';
import 'package:mooc_app/presentation/pages/learning/learning_course_page.dart';
import 'package:mooc_app/presentation/pages/profile/profile_page.dart';
import 'package:mooc_app/presentation/pages/search/search_page.dart';

import '../../controllers/profile/fetch_profile_controller.dart';

class InitPage extends GetView<AuthController> {
  InitPage({super.key, this.index});

  int? index;

  final initPageTabController = Get.put(InitPageTabController());
  @override
  Widget build(BuildContext context) {
    if (index != null) {
      initPageTabController.changeIndexTab(index);
    }
    Future<bool> onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Thoát ứng dụng'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const <Widget>[
                    Text('Bạn có thực sự muốn đóng ứng dụng lại ?'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Thoát'),
                  onPressed: () {
                    if (Platform.isIOS) {
                      exit(0);
                    } else {
                      SystemNavigator.pop();
                    }
                  },
                ),
                TextButton(
                  child: const Text('Ở lại'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ],
            ),
          )) ??
          false;
    }

    return WillPopScope(
      onWillPop: onWillPop,
      child: CupertinoTabScaffold(
        controller: initPageTabController.cupertinoTabController,
        tabBar: CupertinoTabBar(
          items: TabType.values
              .map((e) => BottomNavigationBarItem(
                  icon: e.icon,
                  activeIcon: e.activeIcon,
                  label: e.title(context)))
              .toList(),
          inactiveColor: Colors.black54,
          activeColor: AppColors.primaryBlue,
          onTap: (value) async {
            if (value == 0) {
              Get.delete<CourseListController>();
              CourseRecommendBinding().dependencies();
              final courseRecommendController =
                  Get.find<CourseRecommendController>();
              courseRecommendController.fetchData(0, 6);
            } else if (value == 2) {
              if (controller.isLoggedIn.value) {
                await handleRidirectToLearningCoursePage(context);
              } else {
                CategoryBinding().dependencies();
              }
            } else if (value == 3) {
              ProfileBinding().dependencies();
              SearchFetchBinding().dependencies();
              if (controller.isLoggedIn.value) {
                final fetch = Get.find<FetchProfileController>();
                fetch.fetchDataInit();
              }
            }
          },
        ),
        tabBuilder: (context, index) {
          final type = TabType.values[index];
          switch (type) {
            case TabType.home:
              CourseRecommendBinding().dependencies();
              CategoryBinding().dependencies();
              return HomePage();
            case TabType.search:
              CategoryBinding().dependencies();
              CourseListBinding().dependencies();
              SearchFetchBinding().dependencies();
              return const SearchPage();
            case TabType.learning:
              CategoryBinding().dependencies();
              LearningCourseListBinding().dependencies();
              return LearningCoursePage();
            // case TabType.favorite:
            //   CategoryBinding().dependencies();
            //   SearchFetchBinding().dependencies();
            //   return const FavoritePage();
            case TabType.profile:
              ProfileBinding().dependencies();
              SearchFetchBinding().dependencies();
              return const ProfilePage();
          }
        },
      ),
    );
  }
}
