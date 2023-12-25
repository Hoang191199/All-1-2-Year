import 'dart:typed_data';

import 'package:mobiedu_kids/domain/entities/info_profile.dart';
import 'package:mobiedu_kids/domain/entities/profile.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';

abstract class ProfileRepository {
  Future<ResponseDataObject<InfoProfile>> profile(String user_name, int page);
  Future<ResponseDataObject<Profile>> detail(String user_name);
  Future<ResponseDataObject<Object>> edit(String kind, String payload);
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
      Uint8List? file);
  Future<ResponseDataObject<Object>> password(
      String current_password, String new_password, String confirm_password);
  Future<ResponseDataObject<Object>> resend();
}
