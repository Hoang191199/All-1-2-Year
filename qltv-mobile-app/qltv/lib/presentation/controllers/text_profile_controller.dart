import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:qltv/app/services/local_storage.dart';
import 'package:qltv/presentation/controllers/profile/profile_controller.dart';

class TextUpdateProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static TextUpdateProfileController get to =>
      Get.find<TextUpdateProfileController>();
  final store = Get.find<LocalStorageService>();
  late TextEditingController nameText;
  late TextEditingController emailText;
  late TextEditingController phoneText;
  late TextEditingController avatarText;
  late TextEditingController dobText;
  late TextEditingController descriptionText;
  late TextEditingController genderText;
  late TextEditingController passwordText;
  final profile = Get.find<ProfileController>();
  final isInitialized = false.obs;
  @override
  void onInit() async {
    super.onInit();
    await updateprofileInitilization();
    isInitialized(true);
  }

  updateprofileInitilization() async {
    nameText = TextEditingController(
        text: store.userFromStorage?.fullname == null
            ? ""
            : '${store.userFromStorage?.fullname}');
    emailText = TextEditingController(
        text: store.userFromStorage?.email == null
            ? ""
            : '${store.userFromStorage?.email}');
    phoneText = TextEditingController(
        text: store.userFromStorage?.phone == null
            ? ""
            : '${store.userFromStorage?.phone}');
    avatarText = TextEditingController(
        text: store.userFromStorage?.avatar_url == null
            ? ""
            : '${store.userFromStorage?.avatar_url}');
    dobText = TextEditingController(
        text: store.userFromStorage?.birthday == null
            ? ""
            : '${store.userFromStorage?.birthday}');
    genderText = TextEditingController(
        text: store.userFromStorage?.gender == null
            ? "2"
            : (store.userFromStorage?.gender == 0 ||
                    store.userFromStorage?.gender == 0 ||
                    store.userFromStorage?.gender == 1 ||
                    store.userFromStorage?.gender == 1)
                ? '${store.userFromStorage?.gender}'
                : "2");
    passwordText = TextEditingController(text: "");
    update();
  }
}
