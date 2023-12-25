import 'package:mobiedu_kids/data/providers/network/apis/notification_api.dart';
import 'package:mobiedu_kids/domain/entities/attendance/attendance_class.dart';
import 'package:mobiedu_kids/domain/entities/notification/data_notification.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';
import 'package:mobiedu_kids/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl extends NotificationRepository {

  @override
  Future<ResponseDataObject<DataNotification>> getListNotifications(int page) async {
    final response = await NotificationAPI.getListNotifications(page).request();
    return ResponseDataObject<DataNotification>.fromJson(response, (data) => DataNotification.fromJson(data));
  }

  @override
  Future<ResponseNoData> setCountNotifications() async {
    final response = await NotificationAPI.setCountNotifications().request();
    return ResponseNoData.fromJson(response);
  }

  @override
  Future<ResponseDataObject<AttendenceClass>> detail(String action, String nodeUrl,String nodeType ,String extra1,String extra2 ,String extra3) async {
    final response = await NotificationAPI.detail(action, nodeUrl, nodeType, extra1, extra2, extra3).request();
    return ResponseDataObject<AttendenceClass>.fromJson(response, (data) => AttendenceClass.fromJson(data));
  }
  
}