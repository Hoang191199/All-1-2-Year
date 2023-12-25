import 'package:mobiedu_kids/data/providers/network/apis/schedule_api.dart';
import 'package:mobiedu_kids/domain/entities/profile.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/schedule.dart';
import 'package:mobiedu_kids/domain/entities/schedule_child.dart';
import 'package:mobiedu_kids/domain/entities/schedule_class.dart';
import 'package:mobiedu_kids/domain/entities/schedule_details.dart';
import 'package:mobiedu_kids/domain/entities/schedule_history.dart';
import 'package:mobiedu_kids/domain/entities/schedule_more_details.dart';
import 'package:mobiedu_kids/domain/entities/schedule_school_details.dart';
import 'package:mobiedu_kids/domain/repositories/schedule_repository.dart';

class ScheduleRepositoryImpl extends ScheduleRepository {
  @override
  Future<ResponseDataObject<ScheduleClass>> get(String group_name) async {
    final response = await ScheduleAPI.get(group_name).request();
    return ResponseDataObject<ScheduleClass>.fromJson(
        response, (data) => ScheduleClass.fromJson(data));
  }

  @override
  Future<ResponseDataObject<ScheduleChild>> getChild(String child_id) async {
    final response = await ScheduleAPI.getChild(child_id).request();
    return ResponseDataObject<ScheduleChild>.fromJson(
        response, (data) => ScheduleChild.fromJson(data));
  }

  @override
  Future<ResponseDataObject<ScheduleHistory>> view(
      int page, String group_name) async {
    final response = await ScheduleAPI.view(page, group_name).request();
    return ResponseDataObject<ScheduleHistory>.fromJson(
        response, (data) => ScheduleHistory.fromJson(data));
  }

  @override
  Future<ResponseDataObject<ScheduleDetails<ScheduleMoreDetails>>> detail(
      String group_name, String schedule_id) async {
    final response =
        await ScheduleAPI.detail(group_name, schedule_id).request();
    return ResponseDataObject<ScheduleDetails<ScheduleMoreDetails>>.fromJson(
        response,
        (data) => ScheduleDetails<ScheduleMoreDetails>.fromJson(
            data, (d) => ScheduleMoreDetails.fromJson(d)));
  }

  @override
  Future<ResponseDataObject<ScheduleHistory>> viewChild(
      int page, String child_id) async {
    final response = await ScheduleAPI.viewChild(page, child_id).request();
    return ResponseDataObject<ScheduleHistory>.fromJson(
        response, (data) => ScheduleHistory.fromJson(data));
  }

  @override
  Future<ResponseDataObject<ScheduleDetails<ScheduleMoreDetails>>> detailChild(
      String child_id, String schedule_id) async {
    final response =
        await ScheduleAPI.detailChild(child_id, schedule_id).request();
    return ResponseDataObject<ScheduleDetails<ScheduleMoreDetails>>.fromJson(
        response,
        (data) => ScheduleDetails<ScheduleMoreDetails>.fromJson(
            data, (d) => ScheduleMoreDetails.fromJson(d)));
  }

  @override
  Future<ResponseDataObject<Schedule>> schoolList(String school_name) async {
    final response = await ScheduleAPI.schoolList(school_name).request();
    return ResponseDataObject<Schedule>.fromJson(
        response, (data) => Profile.fromJson(data));
  }

  @override
  Future<ResponseDataObject<ScheduleDetails<ScheduleSchoolDetails>>>
      schoolDetail(String school_name, String schedule_id) async {
    final response =
        await ScheduleAPI.schoolDetail(school_name, schedule_id).request();
    return ResponseDataObject<ScheduleDetails<ScheduleSchoolDetails>>.fromJson(
        response,
        (data) => ScheduleDetails<ScheduleSchoolDetails>.fromJson(
            data, (d) => ScheduleSchoolDetails.fromJson(d)));
  }
}
