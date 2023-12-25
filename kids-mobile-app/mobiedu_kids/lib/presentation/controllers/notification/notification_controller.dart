import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/domain/entities/attendance/attendance_class.dart';
import 'package:mobiedu_kids/domain/entities/notification/data_notification.dart';
import 'package:mobiedu_kids/domain/entities/notification/friend_request.dart';
import 'package:mobiedu_kids/domain/entities/notification/notification.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';
import 'package:mobiedu_kids/domain/usecases/social/friend_connect_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/notification/notifications_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/notification/set_count_notifications_use_case.dart';

class NotificationController extends GetxController {
  NotificationController(
    this.notificationsUseCase,
    this.friendConnectUseCase,
    this.setCountNotificationUseCase,
    this.notificationsDetailUseCase
  );

  final NotificationsUseCase notificationsUseCase;
  final FriendConnectUseCase friendConnectUseCase;
  final SetCountNotificationUseCase setCountNotificationUseCase;
  final NotificationsDetailUseCase notificationsDetailUseCase;

  final isLoading = false.obs;
  final isLoadMore = false.obs;
  final isLoadingDetail = false.obs;
  int page = 0;
  var responseData = Rx<ResponseDataObject<DataNotification>?>(null);
  var friendRequestsData = RxList<FriendRequest?>([]);
  var notificationsData = RxList<NotificationEntity?>([]);
  var responseAcceptFriend = Rx<ResponseNoData?>(null);
  var responseDetail = Rx<ResponseDataObject<AttendenceClass>?>(null);
  final isLoadingAcceptFriend = false.obs;

  fetchData() async {
    isLoading(true);
    page = 0;
    notificationsData.value = [];
    final response = await notificationsUseCase.execute(page);
    responseData.value = response;
    friendRequestsData.assignAll(response.data?.friend_requests ?? []);
    notificationsData.assignAll(response.data?.notifications ?? []);
    isLoading(false);
  }

  loadMore() async {
    if (isLoadMore.value) return;
    isLoadMore(true);
    page += 1;
    final response = await notificationsUseCase.execute(page);
    responseData.value = response;
    if (response.code == 200) {
      notificationsData.addAll(response.data?.notifications ?? []);
    } else {
      page -= 1;
    }
    isLoadMore(false);
  }

  setCountNotifications() {
    setCountNotificationUseCase.execute();
  }

  friendsConnect(String friendId, String actionFriend) async {
    isLoadingAcceptFriend(true);
    final response = await friendConnectUseCase.execute(Tuple2(friendId, actionFriend));
    responseAcceptFriend.value = response;
    if (response.code == 200) {
      friendRequestsData.removeWhere((friend) => friend?.user_id == friendId);
    }
    isLoadingAcceptFriend(false);
  }

  detail(String action, String nodeUrl,String nodeType ,String extra1,String extra2 ,String extra3) async {
    isLoadingDetail(true);
      final response = await notificationsDetailUseCase.execute(Tuple6(action,  nodeUrl, nodeType , extra1, extra2 , extra3));
      responseDetail.value = response;
    isLoadingDetail(false);
  }
}