import 'dart:typed_data';

import 'package:mobiedu_kids/data/providers/network/apis/child_api.dart';
import 'package:mobiedu_kids/domain/entities/child.dart';
import 'package:mobiedu_kids/domain/entities/child_basic_info.dart';
import 'package:mobiedu_kids/domain/entities/child_list.dart';
import 'package:mobiedu_kids/domain/entities/overview.dart';
import 'package:mobiedu_kids/domain/entities/parent_details.dart';
import 'package:mobiedu_kids/domain/entities/picker_info.dart';
import 'package:mobiedu_kids/domain/entities/response_data_array_object.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/repositories/child_repository.dart';

class ChildRepositoryImpl extends ChildRepository {
  @override
  Future<ResponseDataObject<ChildList>> get(String group_name) async {
    final response = await ChildAPI.get(group_name).request();
    return ResponseDataObject.fromJson(
        response, (data) => ChildList.fromJson(data));
  }

  @override
  Future<ResponseDataObject<Child>> detail(
      String group_name, String child_id) async {
    final response = await ChildAPI.detail(group_name, child_id).request();
    return ResponseDataObject<Child>.fromJson(
        response, (data) => Child.fromJson(data));
  }

  @override
  Future<ResponseDataObject<ChildBasicInfo>> detail_parent(
      String child_id) async {
    final response = await ChildAPI.detail_parent(child_id).request();
    return ResponseDataObject<ChildBasicInfo>.fromJson(
        response, (data) => ChildBasicInfo.fromJson(data));
  }

  // @override
  // Future<ResponseDataObject<Growths>> search(
  //     String group_name, String child_id) async {
  //   final response = await ChildAPI.search(group_name, child_id).request();
  //   print(response);
  //   return ResponseDataObject<Growths>.fromJson(
  //       response, (data) => Growths.fromJson(data));
  // }

  // @override
  // Future<ResponseDataObject<Journals>> searchDiary(
  //     String group_name, String child_id, int year) async {
  //   final response =
  //       await ChildAPI.searchDiary(group_name, child_id, year).request();
  //   print(response);
  //   return ResponseDataObject<Journals>.fromJson(
  //       response, (data) => Journals.fromJson(data));
  // }

  @override
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
      int parentNum) async {
    final response = await ChildAPI.add(
            group_name,
            code_auto,
            first_name,
            last_name,
            description,
            gender,
            parent_phone,
            parent_name,
            parent_email,
            create_parent_account,
            address,
            birthday,
            begin_at,
            pre_tuition_receive,
            password,
            parent,
            parentNum)
        .request();
    return ResponseDataArrayObject<Object>.fromJson(response, (data) => Object);
  }

  @override
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
      int parentNum) async {
    final response = await ChildAPI.edit(
            group_name,
            child_id,
            child_code,
            first_name,
            last_name,
            description,
            gender,
            parent_phone,
            parent_name,
            parent_email,
            create_parent_account,
            address,
            birthday,
            begin_at,
            pre_tuition_receive,
            password,
            parent,
            parentNum)
        .request();
    return ResponseDataArrayObject<Object>.fromJson(response, (data) => Object);
  }

  @override
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
      int parentNum) async {
    final response = await ChildAPI.edit_parent(
            child_id,
            first_name,
            last_name,
            nickname,
            description,
            gender,
            parent_phone,
            parent_name,
            parent_email,
            address,
            birthday,
            blood_type,
            hobby,
            allergy,
            parent,
            parentNum)
        .request();
    return ResponseDataArrayObject<Object>.fromJson(response, (data) => Object);
  }

  @override
  Future<ResponseDataArrayObject<Object>> upload(
      String child_id, Uint8List file) async {
    final response = await ChildAPI.upload(child_id, file).request();
    return ResponseDataArrayObject<Object>.fromJson(
        response, (data) => Object());
  }
  // @override
  // Future<ResponseDataArrayObject<Object>> addGrowth(
  //     String group_name, String child_id, String date, Uint8List file) async {
  //   final response =
  //       await ChildAPI.addGrowth(group_name, child_id, date, file).request();
  //   print(response);
  //   return ResponseDataArrayObject<Object>.fromJson(response, (data) => Object);
  // }

  // @override
  // Future<ResponseDataArrayObject<Object>> addPhoto(
  //     String group_name, String child_id, String date, Uint8List file) async {
  //   final response =
  //       await ChildAPI.addPhoto(group_name, child_id, date, file).request();
  //   print(response);
  //   return ResponseDataArrayObject<Object>.fromJson(response, (data) => Object);
  // }

  @override
  Future<ResponseDataArrayObject<PickerInfo>> infomation(
      String group_name, String event_id) async {
    final response = await ChildAPI.infomation(group_name, event_id).request();
    return ResponseDataArrayObject<PickerInfo>.fromJson(
        response, (data) => PickerInfo.fromJson(data));
  }

  @override
  Future<ResponseDataObject<OverView>> overview(String child_id) async {
    final response = await ChildAPI.overview(child_id).request();
    return ResponseDataObject<OverView>.fromJson(
        response, (data) => OverView.fromJson(data));
  }

  @override
  Future<ResponseDataArrayObject<ParentDetails>> searchUser(
      String q, String page, List<String> parent, int parentNum) async {
    final response =
        await ChildAPI.searchUser(q, page, parent, parentNum).request();
    return ResponseDataArrayObject<ParentDetails>.fromJson(
        response, (data) => ParentDetails.fromJson(data));
  }

  @override
  Future<ResponseDataObject<Child>> searchCode(
      String group_name, String child_code) async {
    final response =
        await ChildAPI.searchCode(group_name, child_code).request();
    return ResponseDataObject<Child>.fromJson(response, (data) => Child.fromJson(data));
  }
}
