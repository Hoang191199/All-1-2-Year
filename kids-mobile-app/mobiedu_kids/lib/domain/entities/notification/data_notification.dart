import 'package:mobiedu_kids/domain/entities/notification/friend_request.dart';
import 'package:mobiedu_kids/domain/entities/notification/notification.dart';

class DataNotification {
  DataNotification({
    this.friend_requests,
    this.notifications,
    this.count_notification
  });

  List<FriendRequest>? friend_requests;
  List<NotificationEntity>? notifications;
  String? count_notification;

  factory DataNotification.fromJson(Map<String, dynamic>? json) {
    return DataNotification(
      friend_requests: json?["friend_requests"] == [] ? [] : List<FriendRequest>.from(json?["friend_requests"].map((x) => FriendRequest.fromJson(x))),
      notifications: json?["notifications"] == [] ? [] : List<NotificationEntity>.from(json?["notifications"].map((x) => NotificationEntity.fromJson(x))),
      count_notification: json?["count_notification"] == null ? null : json?['count_notification'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'friend_requests': friend_requests,
    'notifications': notifications,
    'count_notification': count_notification
  };
}