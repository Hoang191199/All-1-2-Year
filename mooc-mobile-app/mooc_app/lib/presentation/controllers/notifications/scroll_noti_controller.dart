// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:mooc_app/presentation/controllers/auth/auth_controller.dart';
// import 'package:mooc_app/presentation/pages/init/init_page.dart';
//
// import '../../../app/config/app_common.dart';
// import '../../../app/config/app_constants.dart';
// import '../../../domain/entities/noti_mooc.dart';
// import '../../../domain/entities/paging_mooc.dart';
// import '../init_page_tab_controller.dart';
// import 'list_noti_controller.dart';
//
// class ScrollingNotiController extends GetxController
//     with GetSingleTickerProviderStateMixin {
//   ScrollingNotiController({required this.height});
//   final auth = Get.find<AuthController>();
//   final initPageTabController = Get.put(InitPageTabController());
//   RxInt page = 1.obs;
//   double height;
//   late ScrollController? scrollController;
//   var paging = Rx<PagingMooc?>(null);
//   var listNotiData = Rx<List<NotiMooc>>([]);
//   final listnoti = Get.find<ListNotiController>();
//   final isInitialized = false.obs;
//   final isloading = false.obs;
//   RxBool showButton = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     scrollExtend();
//   }
//
//   scrollExtend() async {
//     isloading(true);
//     listNotiData.value = [];
//     scrollController = ScrollController();
//     scrollController?.removeListener(() {
//       _scrollmanager();
//     });
//     scrollController?.addListener(() {
//       _scrollmanager();
//     });
//     await listnoti.fetchData(page.value);
//     if (listnoti.code.value == 401 && auth.token != "" && auth.token != null) {
//       auth.logout();
//       scrollController?.removeListener(() {
//         _scrollmanager();
//       });
//       initPageTabController.changeIndexTab(3);
//       showSnackbar(
//           SnackbarType.notice, "Hết phiên đăng nhập", "Vui lòng đăng nhập lại");
//       Get.off(() => InitPage());
//     } else {
//       paging.value = listnoti.paging.value;
//       listNotiData.value.addAll(listnoti.listNotiMoocData.value);
//     }
//     isloading(false);
//     isInitialized(true);
//   }
//
//   _scrollmanager() async {
//     if (page.value < listnoti.paging.value!.last_page) {
//       if (scrollController!.position.extentAfter < height) {
//         await listnoti.fetchData(page.value + 1);
//         paging.value = listnoti.paging.value;
//         listNotiData.value.addAll(listnoti.listNotiMoocData.value);
//         page.value += 1;
//       }
//     }
//   }
// }
