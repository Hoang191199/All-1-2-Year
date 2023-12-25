import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:mooc_app/presentation/controllers/profile/fetch_profile_controller.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

import 'auth/auth_controller.dart';

class LoginController extends GetxController {
  final isTappedDown = false.obs;
  final isHandleLogging = false.obs;
  // final profile = Get.find<FetchProfileController>();
  @override
  void onInit() {
    isTappedDown(false);
    super.onInit();
  }

  tapButtonDown() {
    isTappedDown(true);
  }

  tapButtonUp() {
    isTappedDown.value = false;
  }

  Future<void> authenticate() async {
    
    final url = Uri.https("sso.codeinet.com", "login/oauth/authorize", {
      "client_id": "599ac1aaf88d969e9ed7",
      "response_type": "code",
      "scope": "read",
      "state": "moocs",
      "redirect_uri": "mooc-app://callback",
    });
    final result = await FlutterWebAuth.authenticate(
      url: url.toString(), 
      callbackUrlScheme: "mooc-app"
    );
    isHandleLogging(true);
    final code = Uri.parse(result).queryParameters['code'] ?? "";
    String? deviceId;
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
    } on PlatformException {
      deviceId = '';
    }
    final authController = Get.find<AuthController>();
    if (code.isNotEmpty && (deviceId?.isNotEmpty ?? false)) {
      await authController.signinSSOByCode(code, deviceId ?? '');
      // profile.fetchDataInit();
    }
    isHandleLogging(false);
    authController.sendFcmToken();
  }
}