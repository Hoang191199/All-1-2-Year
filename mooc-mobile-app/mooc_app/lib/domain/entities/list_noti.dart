import 'noti.dart';

class ListNoti {
  ListNoti({
    this.error,
    this.message,
    this.notifications,
    this.status,
  });

  bool? error;
  String? message;
  Noti? notifications;
  bool? status;

  factory ListNoti.fromJson(Map<String, dynamic>? json) {
    return ListNoti(
      error: json?["error"] == null ? null : json?['error'] as bool,
      message: json?["message"] == null ? null : json?['message'] as String,
      notifications: json?["notifications"] == null ? null : Noti.fromJson(json?["notifications"]),
      status: json?["status"] == null ? null : json?['status'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "notifications": notifications,
    "status": status
  };
}