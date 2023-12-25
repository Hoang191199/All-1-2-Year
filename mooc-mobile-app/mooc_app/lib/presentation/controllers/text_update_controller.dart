import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mooc_app/domain/entities/profile.dart';
import 'package:mooc_app/presentation/controllers/profile/fetch_profile_controller.dart';
import 'package:mooc_app/presentation/controllers/profile/update_profile_controller.dart';
import 'package:mooc_app/presentation/pages/init/init_page.dart';

class TextUpdateProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static TextUpdateProfileController get to =>
      Get.find<TextUpdateProfileController>();
  late TextEditingController nameText;
  late TextEditingController emailText;
  late TextEditingController phoneText;
  late TextEditingController avatarText;
  late TextEditingController dobText;
  late TextEditingController addressText;
  late TextEditingController cityText;
  late TextEditingController genderText;
  final profile = Get.find<FetchProfileController>();
  final up = Get.find<UpdateProfileController>();
  final isInitialized = false.obs;
  @override
  void onInit() async {
    super.onInit();
    await updateprofileInitilization();
    isInitialized(true);
  }

  recurve(pro) async {
    if (pro.isInitialized.value == true) {
    } else {
      await Future.delayed(const Duration(milliseconds: 50), () {});
      await recurve(pro);
    }
  }

  updateprofileInitilization() async {
    await recurve(profile);
    await profile.fetchDataInit();
    nameText = TextEditingController(
        text: profile.profile.value?.data?.fullname == null
            ? ""
            : '${profile.profile.value?.data?.fullname}');
    emailText = TextEditingController(
        text: profile.profile.value?.data?.email == null
            ? ""
            : '${profile.profile.value?.data?.email}');
    phoneText = TextEditingController(
        text: profile.profile.value?.data?.phone == null
            ? ""
            : '${profile.profile.value?.data?.phone}');
    avatarText = TextEditingController(
        text: profile.profile.value?.data?.avatar == null
            ? ""
            : '${profile.profile.value?.data?.avatar}');
    dobText = TextEditingController(
        text: profile.profile.value?.data?.dob == null
            ? ""
            : '${profile.profile.value?.data?.dob}');
    addressText = TextEditingController(
        text: profile.profile.value?.data?.address == null
            ? ""
            : '${profile.profile.value?.data?.address}');
    cityText = TextEditingController(
        text: profile.profile.value?.data?.city == null
            ? ""
            : '${profile.profile.value?.data?.city}');
    genderText = TextEditingController(
        text: profile.profile.value?.data?.gender == null
            ? "other"
            : (profile.profile.value?.data?.gender == 'male' ||
                    profile.profile.value?.data?.gender == 'Male' ||
                    profile.profile.value?.data?.gender == 'female' ||
                    profile.profile.value?.data?.gender == 'Female')
                ? '${profile.profile.value?.data?.gender}'
                : "other");
    update();
  }

  updateProfile(String fullname, String email, String? phone, String? dob,
      String? avatar, String address, String gender, String city) {
    up.updateData(fullname, email, phone, dob, avatar, address, gender, city);
    // up.updateprofileUseCase.execute(Tuple7(fullname, email, dob, avatar,address,gender,city));
    print("$fullname, $email, $phone, $dob, $avatar, $address, $gender, $city");
  }
}
