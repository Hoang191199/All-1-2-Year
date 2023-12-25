class NotificationEntity {
  NotificationEntity({
    this.notification_id,
    this.from_user_id,
    this.to_user_id,
    this.action,
    this.node_type,
    this.time,
    this.seen,
    this.message,
    this.user_fullname,
    this.user_picture,
    this.extra1,
    this.extra2,
    this.extra3,
    this.notify_id,
    this.node_url,
  });

  String? notification_id;
  String? from_user_id;
  String? to_user_id;
  String? action;
  String? node_type;
  String? time;
  String? seen;
  String? message;
  String? user_fullname;
  String? user_picture;
  String? extra1;
  String? extra2;
  String? extra3;
  String? notify_id;
  String? node_url;

  factory NotificationEntity.fromJson(Map<String, dynamic>? json) {
    return NotificationEntity(
      notification_id: json?["notification_id"] == null ? null : json?['notification_id'] as String,
      from_user_id: json?["from_user_id"] == null ? null : json?['from_user_id'] as String,
      to_user_id: json?["to_user_id"] == null ? null : json?['to_user_id'] as String,
      action: json?["action"] == null ? null : json?['action'] as String,
      node_type: json?["node_type"] == null ? null : json?['node_type'] as String,
      time: json?["time"] == null ? null : json?['time'] as String,
      seen: json?["seen"] == null ? null : json?['seen'] as String,
      message: json?["message"] == null ? null : json?['message'] as String,
      user_fullname: json?["user_fullname"] == null ? null : json?['user_fullname'] as String,
      user_picture: json?["user_picture"] == null ? null : json?['user_picture'] as String,
      extra1: json?["extra1"] == null ? null : json?['extra1'] as String,
      extra2: json?["extra2"] == null ? null : json?['extra2'] as String,
      extra3: json?["extra3"] == null ? null : json?['extra3'] as String,
      notify_id: json?["notify_id"] == null ? null : json?['notify_id'] as String,
      node_url: json?["node_url"] == null ? null : json?['node_url'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'notification_id': notification_id,
    'from_user_id': from_user_id,
    'to_user_id': to_user_id,
    'action': action,
    'node_type': node_type,
    'time': time,
    'seen': seen,
    'message': message,
    'user_fullname': user_fullname,
    'user_picture': user_picture,
    'extra1': extra1,
    'extra2': extra2,
    'extra3': extra3,
    'notify_id': notify_id,
    'node_url': node_url
  };
}