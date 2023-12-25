import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/app/types/tab_type.dart';
import 'package:qltv/presentation/controllers/bookcase/bookcase_binding.dart';
import 'package:qltv/presentation/controllers/bookcase/bookcase_controller.dart';
import 'package:qltv/presentation/controllers/brrow/borrow_binding.dart';
import 'package:qltv/presentation/controllers/brrow/borrow_controller.dart';
import 'package:qltv/presentation/controllers/carousel_controller.dart';
import 'package:qltv/presentation/controllers/home/home_binding.dart';
import 'package:qltv/presentation/controllers/home/home_controller.dart';
import 'package:qltv/presentation/controllers/login/login_controller.dart';
import 'package:qltv/presentation/controllers/profile/profile_binding.dart';
import 'package:qltv/presentation/controllers/profile/profile_controller.dart';
import 'package:qltv/presentation/controllers/search/search_binding.dart';
import 'package:qltv/presentation/controllers/search/search_controller.dart'
    as search;
import 'package:qltv/presentation/pages/bookcase/bookcase_page.dart';
import 'package:qltv/presentation/pages/borrow/borrow_page.dart';
import 'package:qltv/presentation/pages/home/home_page.dart';
import 'package:qltv/presentation/pages/reader_card/reader_card_page.dart';
import 'package:qltv/presentation/pages/search/search_page.dart';

class InitPage extends GetView<LoginController> {
  InitPage({
    super.key,
    // this.index
  });
  // int? index;

  // final initPageTabController = Get.put(InitPageTabController());
  @override
  Widget build(BuildContext context) {
    // if (index != null) {
    //   initPageTabController.changeIndexTab(index);
    // }
    return WillPopScope(
      onWillPop: () async => false,
      child: CupertinoTabScaffold(
          // controller: initPageTabController.cupertinoTabController,
          tabBar: CupertinoTabBar(
            items: TabType.values
                .map((e) => BottomNavigationBarItem(
                    icon: e.icon,
                    activeIcon: e.activeIcon,
                    label: e.title(context)))
                .toList(),
            iconSize: 25.0,
            inactiveColor: Colors.black54,
            activeColor: AppColors.primaryBlue,
            onTap: (value) async {
              if (value == 0) {
                HomeBinding().dependencies();
                BookcaseBinding().dependencies();
                final homeController = Get.find<HomeController>();
                final cr = Get.put(CarouselSlideController());
                await homeController.fetchData();
                cr.current.value = 0;
              } else if (value == 1) {
                BookcaseBinding().dependencies();
                final bookcaseController = Get.find<BookcaseController>();
                await bookcaseController.fetchData();
                await bookcaseController.fetchDataLastseen();
              } else if (value == 2) {
                SearchBinding().dependencies();
                final searchController = Get.find<search.SearchController>();
                searchController.fetchData('');
              } else if (value == 3) {
                BorrowBinding().dependencies();
                final borrowController = Get.find<BorrowController>();
                borrowController.fetchDataBorrow('', null);
              } else if (value == 4) {
                ProfileBinding().dependencies();
                final profileController = Get.find<ProfileController>();
                await profileController.fetchProfile();
              }
            },
          ),
          tabBuilder: (context, index) {
            final type = TabType.values[index];
            switch (type) {
              case TabType.home:
                BookcaseBinding().dependencies();
                ProfileBinding().dependencies();
                HomeBinding().dependencies();
                SearchBinding().dependencies();
                return HomePage();
              case TabType.bookcase:
                BookcaseBinding().dependencies();
                return BookcasePage();
              case TabType.search:
                SearchBinding().dependencies();
                return SearchPage();
              case TabType.borrow:
                BorrowBinding().dependencies();
                return BorrowPage();
              case TabType.readerCard:
                ProfileBinding().dependencies();
                return ReaderCardPage();
            }
          }),
    );
  }
}
