import 'package:mobiedu_kids/domain/entities/attendance/attendance_class.dart';
import 'package:mobiedu_kids/domain/entities/notification/data_notification.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';

abstract class NotificationRepository {
  Future<ResponseDataObject<DataNotification>> getListNotifications(int page);

  Future<ResponseNoData> setCountNotifications();

  Future<ResponseDataObject<AttendenceClass>> detail(String action, String nodeUrl,String nodeType ,String extra1,String extra2 ,String extra3);
}