import 'package:dartz/dartz.dart';
import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/attendance/attendance_class.dart';
import 'package:mobiedu_kids/domain/entities/notification/data_notification.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/repositories/notification_repository.dart';

class NotificationsUseCase extends ParamUseCase<ResponseDataObject<DataNotification>, int> {
  NotificationsUseCase(this.notificationRepository);

  final NotificationRepository notificationRepository;

  @override
  Future<ResponseDataObject<DataNotification>> execute(int params) {
    return notificationRepository.getListNotifications(params);
  }
}

class NotificationsDetailUseCase extends ParamUseCase<ResponseDataObject<AttendenceClass>, Tuple6<String, String, String, String, String, String>> {
  NotificationsDetailUseCase(this.notificationRepository);

  final NotificationRepository notificationRepository;

  @override
  Future<ResponseDataObject<AttendenceClass>> execute(Tuple6 params) {
    return notificationRepository.detail(params.value1, params.value2, params.value3, params.value4, params.value5, params.value6);
  }
}