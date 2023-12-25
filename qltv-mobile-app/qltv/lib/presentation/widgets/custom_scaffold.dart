// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:qltv/app/config/app_colors.dart';
// import 'package:qltv/app/types/tab_type.dart';
// import 'package:qltv/presentation/controllers/bookcase/bookcase_binding.dart';
// import 'package:qltv/presentation/controllers/bookcase/bookcase_controller.dart';
// import 'package:qltv/presentation/controllers/brrow/borrow_binding.dart';
// import 'package:qltv/presentation/controllers/brrow/borrow_controller.dart';
// import 'package:qltv/presentation/controllers/carousel_controller.dart';
// import 'package:qltv/presentation/controllers/home/home_binding.dart';
// import 'package:qltv/presentation/controllers/home/home_controller.dart';
// import 'package:qltv/presentation/controllers/login/login_controller.dart';
// import 'package:qltv/presentation/controllers/profile/profile_binding.dart';
// import 'package:qltv/presentation/controllers/profile/profile_controller.dart';
// import 'package:qltv/presentation/controllers/search/search_binding.dart';
// import 'package:qltv/presentation/controllers/search/search_controller.dart';
// import 'package:qltv/presentation/pages/bookcase/bookcase_page.dart';
// import 'package:qltv/presentation/pages/borrow/borrow_page.dart';
// import 'package:qltv/presentation/pages/home/home_page.dart';
// import 'package:qltv/presentation/pages/init/init_page.dart';
// import 'package:qltv/presentation/pages/reader_card/reader_card_page.dart';
// import 'package:qltv/presentation/pages/search/search_page.dart';

// class CustomInitPage extends GetView<LoginController> {
//   CustomInitPage({super.key, required this.child, required this.widgetIndex});
//   final int widgetIndex;
//   final Widget? child;

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => false,
//       child: CupertinoTabScaffold(
//           tabBar: CupertinoTabBar(
//             items: TabType.values
//                 .map((e) => BottomNavigationBarItem(
//                     icon: e.icon,
//                     activeIcon: e.activeIcon,
//                     label: e.title(context)))
//                 .toList(),
//             iconSize: 25.0,
//             inactiveColor: Colors.black54,
//             activeColor: AppColors.primaryBlue,
//             onTap: (value) async {
//               Get.delete<ProfileController>();
//               Get.delete<HomeController>();
//               Get.delete<BookcaseController>();
//               Get.delete<BorrowController>();
//               Get.delete<SearchController>();
//               Get.delete<CarouselSlideController>();
//               if (value == 0) {
//                 Get.off(() => InitPage(index: 0));
//               } else if (value == 1) {
//                 Get.off(() => InitPage(index: 1));
//               } else if (value == 2) {
//                 Get.off(() => InitPage(index: 2));
//               } else if (value == 3) {
//                 Get.off(() => InitPage(index: 3));
//               } else if (value == 4) {
//                 Get.off(() => InitPage(index: 4));
//               }
//             },
//           ),
//           tabBuilder: (context, index) {
//             switch (widgetIndex) {
//               case 0:
//                 return child!;
//               case 1:
//                 return child!;
//               case 2:
//                 return child!;
//               case 3:
//                 return child!;
//               case 4:
//                 return child!;
//               default:
//                 return child!;
//             }
//           }),
//     );
//   }
// }
