import 'package:mobiedu_kids/app/usecases/no_param_usecase.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';
import 'package:mobiedu_kids/domain/repositories/notification_repository.dart';

class SetCountNotificationUseCase extends NoParamUseCase<ResponseNoData> {
  SetCountNotificationUseCase(this.notificationRepository);

  final NotificationRepository notificationRepository;

  @override
  Future<ResponseNoData> execute() {
    return notificationRepository.setCountNotifications();
  }
}