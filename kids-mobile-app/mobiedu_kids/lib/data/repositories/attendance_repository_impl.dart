import 'package:mobiedu_kids/data/providers/network/apis/attendance_api.dart';
import 'package:mobiedu_kids/domain/entities/attendance/attendace.dart';
import 'package:mobiedu_kids/domain/entities/attendance/listChild.dart';
import 'package:mobiedu_kids/domain/entities/attendance/upload.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';
import 'package:mobiedu_kids/domain/repositories/attendance_repository.dart';

class AttendanceRepositoryImpl extends AttendanceRepository {
  @override
  Future<ResponseDataObject<Attendance>> fetchData(String groupName, String date) async {
    final response = await AttendanceAPI.fetchData(groupName, date).request();
    return ResponseDataObject<Attendance>.fromJson(response, (data) => Attendance.fromJson(data));
  }

    @override
    Future<ResponseDataObject<Upload>> uploadImage(int? index) async {
      final response = await AttendanceAPI.uploadImage(index).request();
      return ResponseDataObject<Upload>.fromJson(response, (data) => Upload.fromJson(data));
    }

    @override
    Future<ResponseNoData> update() async {
      final response = await AttendanceAPI.update().request();
      return ResponseNoData.fromJson(response);
    }

    @override
    Future<ResponseNoData> updateCheckOut() async {
      final response = await AttendanceAPI.updateCheckOut().request();
      return ResponseNoData.fromJson(response);
    }

    @override
    Future<ResponseDataObject<ListChild>> getHygiene() async {
      final response = await AttendanceAPI.getHygiene().request();
      return ResponseDataObject<ListChild>.fromJson(response, (data) => ListChild.fromJson(data));
    }

    @override
    Future<ResponseNoData> updateHygiene() async {
      final response = await AttendanceAPI.updateHygiene().request();
      return ResponseNoData.fromJson(response);
    }

    @override
    Future<ResponseDataObject<ListChild>> getSleep() async {
      final response = await AttendanceAPI.getSleep().request();
      return ResponseDataObject<ListChild>.fromJson(response, (data) => ListChild.fromJson(data));
    }

    @override
    Future<ResponseNoData> updateSleep() async {
      final response = await AttendanceAPI.updateSleep().request();
      return ResponseNoData.fromJson(response);
    }

    @override
    Future<ResponseNoData> confirm(String groupName, String childId, String attendanceDetailId) async {
      final response = await AttendanceAPI.confirm( groupName, childId, attendanceDetailId).request();
      return ResponseNoData.fromJson(response);
    }
}
