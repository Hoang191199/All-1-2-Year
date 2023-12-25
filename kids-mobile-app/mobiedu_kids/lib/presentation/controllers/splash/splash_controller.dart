import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/role/role_user.dart';
import 'package:mobiedu_kids/domain/usecases/role_user_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/infomation/infomation_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/infomation/infomation_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/init_page_tab_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/login/log_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/network_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/notification/notification_controller.dart';
import 'package:mobiedu_kids/presentation/pages/chose/chose_school.dart';
import 'package:mobiedu_kids/presentation/pages/init/init_page.dart';
import 'package:mobiedu_kids/presentation/pages/login/login_page.dart';
import 'package:mobiedu_kids/presentation/pages/splash/connect_fail_page.dart';

class SplashScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  SplashScreenController(this.roleUser);

  late AnimationController animationController;
  late Animation<double> animation;

  final loginController = Get.find<LogController>();
  final notificationController = Get.find<NotificationController>();

  var responseManagerData = Rx<ResponseDataObject<RoleUser>?>(null);
  var managerData = RxList<RoleUser?>([]);
  var listData = [];
  final RoleUserUseCase roleUser;
  final childId = ''.obs;
  final groupName = ''.obs;
  final isShowNotification = false.obs;
  final indexChildId = 0.obs;

  @override
  void onInit() {
    animationInitilization();
    super.onInit();
  }

  animationInitilization() {
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = CurvedAnimation(parent: animationController, curve: Curves.easeOut).obs.value;
    animation.addListener(() => update());
    animationController.forward();
    Future.delayed(const Duration(seconds: 4), () async {
      final connect = Get.put(GetXNetworkManager());
      await recurve(connect);
    });
  }

  recurve(connect) async {
    if (connect.isInitialized.value == true) {
      if (connect.connectionType != 0) {
        if (loginController.userLogin != null) {
          // try {
          await managerHome();
          // if (responseManagerData.value?.data?.classes?.isEmpty ??
          //     true &&
          //         (responseManagerData.value?.data?.schools?.isEmpty ?? true)) {
          //   Get.off(() => InitPage());
          // } else {
          //   Get.off(() => ChoseSchool());
          // }
        } else {
          Get.off(() => LoginPage());
        }
      } else {
        Get.off(() => const ConnectFailPage());
      }
    } else {
      await Future.delayed(const Duration(milliseconds: 100), () {});
      await recurve(connect);
    }
  }

  managerHome() async {
    final responseManager = await roleUser.execute();
    if (responseManager.code == 100) {
      Get.off(() => LoginPage());
    } else if (responseManager.code == 200) {
      responseManagerData.value = responseManager;
      if ((responseManagerData.value?.data?.children?.length ?? 0) > 0) {
        childId.value =responseManagerData.value?.data?.children?[0].child_id ?? '0';
        groupName.value =responseManagerData.value?.data?.children?[0].group_name ?? '0';
      }
      await notificationController.fetchData();
      if (responseManagerData.value?.data?.classes?.isEmpty ?? true && (responseManagerData.value?.data?.schools?.isEmpty ?? true)) {
        if(responseManagerData.value?.data?.children?.isNotEmpty ??false) {
          final initPageTabController = Get.put(InitPageTabController());
          initPageTabController.changeIndexTab(0);
          Get.delete<InformationController>();
          InformationBinding().dependencies();
        }
        Get.off(() => InitPage());
      } else {
        Get.off(() => ChoseSchool());
      }
    }
    // var classes = responseManagerData.value?.data?.classes ?? [];
    // var schools = responseManagerData.value?.data?.schools ?? [];
    // listData = [...classes, ...schools].toList();
  }
}
