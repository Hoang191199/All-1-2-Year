import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:mooc_app/app/config/app_common.dart';
import 'package:mooc_app/app/config/app_constants.dart';

import 'package:mooc_app/app/services/local_storage.dart';
import 'package:mooc_app/domain/entities/user_sso.dart';
import 'package:mooc_app/domain/usecases/signin_sso_use_case.dart';
import 'package:mooc_app/presentation/controllers/notifications/connect_noti_controller.dart';

class AuthController extends GetxController {
  AuthController(this.signinSSOUseCase);

  final SigninSSOUseCase signinSSOUseCase;
  final store = Get.find<LocalStorageService>();
  final connectNoti = Get.find<ConnectNotiController>();
  var isLoggedIn = false.obs;
  String? fcmToken;
  UserSSO? get userLogin => store.userFromStorage;
  String? get token => store.tokenFromStorage;
  String? get notiToken => store.notiTokenFromStorage;

  @override
  void onInit() async {
    super.onInit();
    isLoggedIn.value =
        store.userFromStorage != null; // store.tokenFromStorage.isNotEmpty
  }

  signinSSOByCode(String code, String idDevice) async {
    try {
      final signinSSOModel =
          await signinSSOUseCase.execute(Tuple2(code, idDevice));
      if (!(signinSSOModel.error ?? false)) {
        showSnackbar(SnackbarType.success, "Đăng nhập", "Đăng nhập thành công");
        store.userToStorage = signinSSOModel.data;
        store.tokenToStorage = signinSSOModel.data?.accessToken;
        store.notiTokenToStorage = signinSSOModel.data?.notificationToken;
        isLoggedIn.value = true;
        isLoggedIn.refresh();
      }
    } catch (error) {
      showSnackbar(
          SnackbarType.error, "Đăng nhập", "Đăng nhập không thành công");
    }
  }

  sendFcmToken() async {
    if (GetPlatform.isMobile) {
      try {
        final message = FirebaseMessaging.instance;
        NotificationSettings settings = await message.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: true,
          sound: true,
        );
        // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        //   print('User granted permission');
        // } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
        //   print('User granted provisional permission');
        // } else {
        //   print('User declined or has not accepted permission');
        // }
        fcmToken = await message.getToken();
      } catch (e) {}
    }
    if (store.notiTokenFromStorage.isNotEmpty) {
      await connectNoti.fetchData(fcmToken ?? '');
    }
  }

  logout() {
    store.userToStorage = null;
    store.tokenToStorage = '';
    store.notiTokenToStorage = '';
    isLoggedIn.value = false;
  }
}
