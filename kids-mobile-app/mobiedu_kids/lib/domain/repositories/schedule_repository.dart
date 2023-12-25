import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/schedule.dart';
import 'package:mobiedu_kids/domain/entities/schedule_child.dart';
import 'package:mobiedu_kids/domain/entities/schedule_class.dart';
import 'package:mobiedu_kids/domain/entities/schedule_details.dart';
import 'package:mobiedu_kids/domain/entities/schedule_history.dart';
import 'package:mobiedu_kids/domain/entities/schedule_more_details.dart';
import 'package:mobiedu_kids/domain/entities/schedule_school_details.dart';

abstract class ScheduleRepository {
  Future<ResponseDataObject<ScheduleClass>> get(String group_name);
  Future<ResponseDataObject<ScheduleChild>> getChild(String child_id);
  Future<ResponseDataObject<ScheduleHistory>> view(int page, String group_name);
  Future<ResponseDataObject<ScheduleDetails<ScheduleMoreDetails>>> detail(
      String group_name, String schedule_id);
  Future<ResponseDataObject<ScheduleHistory>> viewChild(
      int page, String child_id);
  Future<ResponseDataObject<ScheduleDetails<ScheduleMoreDetails>>> detailChild(
      String child_id, String schedule_id);
  Future<ResponseDataObject<Schedule>> schoolList(String school_name);
  Future<ResponseDataObject<ScheduleDetails<ScheduleSchoolDetails>>>
      schoolDetail(String school_name, String schedule_id);
}
