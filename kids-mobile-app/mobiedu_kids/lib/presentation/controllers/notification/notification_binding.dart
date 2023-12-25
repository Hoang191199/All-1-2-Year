import 'package:get/get.dart';
import 'package:mobiedu_kids/data/repositories/notification_repository_impl.dart';
import 'package:mobiedu_kids/data/repositories/social_repository_impl.dart';
import 'package:mobiedu_kids/domain/usecases/social/friend_connect_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/notification/notifications_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/notification/set_count_notifications_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/notification/notification_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationRepositoryImpl());
    Get.lazyPut(() => SocialRepositoryImpl());
    Get.lazyPut(() => NotificationsUseCase(Get.find<NotificationRepositoryImpl>()));
    Get.lazyPut(() => FriendConnectUseCase(Get.find<SocialRepositoryImpl>()));
    Get.lazyPut(() => SetCountNotificationUseCase(Get.find<NotificationRepositoryImpl>()));
    Get.lazyPut(() => NotificationsDetailUseCase(Get.find<NotificationRepositoryImpl>()));
    Get.lazyPut(() => NotificationController(Get.find(), Get.find(), Get.find(), Get.find()));
  }
  
}