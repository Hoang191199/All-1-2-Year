import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/domain/entities/profile.dart';
import 'package:mobiedu_kids/domain/usecases/profile_use_case.dart';

class ProfileController extends GetxController {
  ProfileController(
      this.profileUseCase,
      this.detailProfileUseCase,
      this.editProfileUseCase,
      this.updateUseCase,
      this.editPasswordUseCase,
      this.resendEmailUseCase);

  final ProfileUseCase profileUseCase;
  final UpdateUseCase updateUseCase;
  final EditProfileUseCase editProfileUseCase;
  final EditPasswordUseCase editPasswordUseCase;
  final DetailProfileUseCase detailProfileUseCase;
  final ResendEmailUseCase resendEmailUseCase;
  var data = Rx<Profile?>(null);
  final isLoading = false.obs;
  late TextEditingController firstname;
  late TextEditingController lastname;
  late TextEditingController birth;
  late TextEditingController id;
  late TextEditingController doi;
  late TextEditingController poi;
  late TextEditingController work;
  late TextEditingController factory;
  late TextEditingController resident;
  late TextEditingController hometown;
  late TextEditingController faculty;
  late TextEditingController school;
  late TextEditingController classroom;
  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController telephone;
  late TextEditingController oldpassword;
  late TextEditingController newpassword;
  late TextEditingController repassword;
  final cityID = 0.obs;
  final gender = false.obs;

  @override
  void onInit() {
    firstname = TextEditingController(text: "");
    lastname = TextEditingController(text: "");
    birth = TextEditingController(text: "");
    id = TextEditingController(text: "");
    doi = TextEditingController(text: "");
    poi = TextEditingController(text: "");
    work = TextEditingController(text: "");
    factory = TextEditingController(text: "");
    resident = TextEditingController(text: "");
    hometown = TextEditingController(text: "");
    faculty = TextEditingController(text: "");
    school = TextEditingController(text: "");
    classroom = TextEditingController(text: "");
    username = TextEditingController(text: "");
    email = TextEditingController(text: "");
    telephone = TextEditingController(text: "");
    oldpassword = TextEditingController(text: "");
    newpassword = TextEditingController(text: "");
    repassword = TextEditingController(text: "");
    super.onInit();
  }

  profile(String username) async {
    isLoading(true);
    final response = await detailProfileUseCase.execute(username);
    data.value = response.data;
    firstname.text = data.value?.profile?.user_firstname ?? "";
    lastname.text = data.value?.profile?.user_lastname ?? "";
    birth.text = data.value?.profile?.user_birthdate ?? "";
    id.text = data.value?.profile?.user_id_card_number ?? "";
    doi.text = data.value?.profile?.date_of_issue ?? "";
    poi.text = data.value?.profile?.place_of_issue ?? "";
    cityID.value = int.parse(data.value?.profile?.city_id ?? "");
    gender.value = data.value?.profile?.user_gender == "male" ? true : false;
    work.text = data.value?.profile?.user_work_title ?? "";
    factory.text = data.value?.profile?.user_work_place ?? "";
    resident.text = data.value?.profile?.user_current_city ?? "";
    hometown.text = data.value?.profile?.user_hometown ?? "";
    faculty.text = data.value?.profile?.user_edu_major ?? "";
    school.text = data.value?.profile?.user_edu_school ?? "";
    classroom.text = data.value?.profile?.user_edu_class ?? "";
    isLoading(false);
  }

  updateSingle(String kind, String payload) async {
    final res = await editProfileUseCase.execute(Tuple2(kind, payload));
    if (res.code == 200) {
      showSnackbar(SnackbarType.success, "Cập nhật thành công",
          "Cập nhật thông tin thành công!");
    } else {
      showSnackbar(SnackbarType.error, "Không thành công", res.message ?? "");
    }
  }

  updateProfile(
      String first_name,
      String last_name,
      String gender,
      String birth_day,
      String user_phone,
      String work_title,
      String work_place,
      String city,
      String hometown,
      String edu_major,
      String edu_school,
      String edu_class,
      String city_id,
      String identification_card_number,
      String date_of_issue,
      String place_of_issue,
      Uint8List? file) async {
    final res = await updateUseCase.execute(Tuple17(
        first_name,
        last_name,
        gender,
        birth_day,
        user_phone,
        work_title,
        work_place,
        city,
        hometown,
        edu_major,
        edu_school,
        edu_class,
        city_id,
        identification_card_number,
        date_of_issue,
        place_of_issue,
        file));
    if (res.code == 200) {
      showSnackbar(SnackbarType.success, "Cập nhật thành công",
          "Cập nhật thông tin thành công!");
    } else {
      showSnackbar(SnackbarType.error, "Không thành công", res.message ?? "");
    }
  }

  password(oldpassword, newpassword, repassword) async {
    final res = await editPasswordUseCase
        .execute(Tuple3(oldpassword, newpassword, repassword));
    if (res.code == 200) {
      showSnackbar(
          SnackbarType.success, "Cập nhật thành công", res.message ?? "");
    } else {
      showSnackbar(SnackbarType.error, "Không thành công", res.message ?? "");
    }
  }

  resend() async {
    final res = await resendEmailUseCase.execute();
    if (res.code == 200) {
      showSnackbar(SnackbarType.success, "Thành công", res.message ?? "");
    } else {
      showSnackbar(SnackbarType.error, "Không thành công", res.message ?? "");
    }
  }
}
