import 'dart:typed_data';

import 'package:mobiedu_kids/domain/entities/child.dart';
import 'package:mobiedu_kids/domain/entities/child_basic_info.dart';
import 'package:mobiedu_kids/domain/entities/child_list.dart';
import 'package:mobiedu_kids/domain/entities/overview.dart';
import 'package:mobiedu_kids/domain/entities/parent_details.dart';
import 'package:mobiedu_kids/domain/entities/picker_info.dart';
import 'package:mobiedu_kids/domain/entities/response_data_array_object.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';

abstract class ChildRepository {
  Future<ResponseDataObject<ChildList>> get(String group_name);
  Future<ResponseDataObject<Child>> detail(String group_name, String child_id);
  Future<ResponseDataObject<ChildBasicInfo>> detail_parent(String child_id);
  Future<ResponseDataArrayObject<Object>> add(
      String group_name,
      String code_auto,
      String first_name,
      String last_name,
      String description,
      String gender,
      String parent_phone,
      String parent_name,
      String parent_email,
      String create_parent_account,
      String address,
      String birthday,
      String begin_at,
      String pre_tuition_receive,
      String password,
      List<String> parent,
      int parentNum);
  Future<ResponseDataArrayObject<Object>> edit(
      String group_name,
      String child_id,
      String child_code,
      String first_name,
      String last_name,
      String description,
      String gender,
      String parent_phone,
      String parent_name,
      String parent_email,
      String create_parent_account,
      String address,
      String birthday,
      String begin_at,
      String pre_tuition_receive,
      String password,
      List<String> parent,
      int parentNum);
  Future<ResponseDataArrayObject<Object>> edit_parent(
      String child_id,
      String first_name,
      String last_name,
      String nickname,
      String description,
      String gender,
      String parent_phone,
      String parent_name,
      String parent_email,
      String address,
      String birthday,
      String blood_type,
      String hobby,
      String allergy,
      List<String> parent,
      int parentNum);
  Future<ResponseDataArrayObject<Object>> upload(
      String child_id, Uint8List file);    
  // Future<ResponseDataObject<Growths>> search(
  //     String group_name, String event_id);
  // Future<ResponseDataObject<Journals>> searchDiary(
  //     String group_name, String child_id, int year);
  // Future<ResponseDataArrayObject<Object>> addGrowth(
  //     String group_name, String child_id, String date, Uint8List file);
  // Future<ResponseDataArrayObject<Object>> addPhoto(
  //     String group_name, String child_id, String caption, Uint8List file);
  Future<ResponseDataArrayObject<PickerInfo>> infomation(
      String group_name, String child_id);
  Future<ResponseDataObject<OverView>> overview(String child_id);    
  Future<ResponseDataArrayObject<ParentDetails>> searchUser(
      String q, String page, List<String> parent, int parentNum);
  Future<ResponseDataObject<Child>> searchCode(
      String group_name, String child_code);
}
