import 'package:mobiedu_kids/domain/entities/attendance/attendace.dart';
import 'package:mobiedu_kids/domain/entities/attendance/listChild.dart';
import 'package:mobiedu_kids/domain/entities/attendance/upload.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';

abstract class AttendanceRepository {
  Future<ResponseDataObject<Attendance>> fetchData(String groupName, String date);
  Future<ResponseDataObject<Upload>> uploadImage(int? index);
  Future<ResponseNoData> update();
  Future<ResponseNoData> updateCheckOut();
  Future<ResponseDataObject<ListChild>> getHygiene();
  Future<ResponseNoData> updateHygiene();
  Future<ResponseDataObject<ListChild>> getSleep();
  Future<ResponseNoData> updateSleep();
  Future<ResponseNoData> confirm(String groupName, String childId, String attendanceDetailId);
}
