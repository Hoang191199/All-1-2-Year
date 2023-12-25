import 'dart:typed_data';

import 'package:mobiedu_kids/data/providers/network/apis/profile_api.dart';
import 'package:mobiedu_kids/domain/entities/info_profile.dart';
import 'package:mobiedu_kids/domain/entities/profile.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  @override
  Future<ResponseDataObject<InfoProfile>> profile(
      String user_name, int page) async {
    final response = await ProfileAPI.profile(user_name, page).request();
    return ResponseDataObject<InfoProfile>.fromJson(
        response, (data) => InfoProfile.fromJson(data));
  }

  @override
  Future<ResponseDataObject<Profile>> detail(String user_name) async {
    final response = await ProfileAPI.detail(user_name).request();
    return ResponseDataObject<Profile>.fromJson(
        response, (data) => Profile.fromJson(data));
  }

  @override
  Future<ResponseDataObject<Object>> edit(String kind, String payload) async {
    final response = await ProfileAPI.edit(kind, payload).request();
    return ResponseDataObject<Object>.fromJson(response, (data) => Object);
  }

  @override
  Future<ResponseDataObject<Profile>> update(
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
    final response = await ProfileAPI.update(
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
            file)
        .request();
    return ResponseDataObject<Profile>.fromJson(
        response, (data) => Profile.fromJson(data));
  }

  @override
  Future<ResponseDataObject<Object>> password(String current_password,
      String new_password, String confirm_password) async {
    final response = await ProfileAPI.password(
            current_password, new_password, confirm_password)
        .request();
    return ResponseDataObject<Object>.fromJson(response, (data) => Object);
  }

  @override
  Future<ResponseDataObject<Object>> resend() async {
    final response = await ProfileAPI.resend().request();
    return ResponseDataObject<Object>.fromJson(response, (data) => Object);
  }
}
