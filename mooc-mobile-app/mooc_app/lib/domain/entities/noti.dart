import 'package:mooc_app/domain/entities/noti_data.dart';

class Noti {
  Noti({
   this.data,
   required this.total,
   required this.unread,
  });

  List<NotiData>? data;
  int total;
  int unread;

  factory Noti.fromJson(Map<String, dynamic>? json) {
    return Noti(
      data: json?["data"] == null ? null : List<NotiData>.from(json?["data"].map((x) => NotiData.fromJson(x))),
      total: json?["total"] as int,
      unread: json?["unread"] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data,
    "total": total,
    "unread": unread,
  };
}