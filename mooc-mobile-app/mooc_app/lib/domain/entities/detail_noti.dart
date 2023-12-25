import 'package:mooc_app/domain/entities/noti_mooc.dart';

class DetailNoti {
  DetailNoti({
    this.message,
    this.code,
    this.error,
    this.data,
  });

  String? message;
  int? code;
  bool? error;
  NotiMooc? data;

  factory DetailNoti.fromJson(Map<String, dynamic>? json) {
    return DetailNoti(
      message: json?['message'] == null ? null : json?['message'] as String,
      code: json?['code'] == null ? null : json?['code'] as int,
      error: json?['error'] == null ? null : json?['error'] as bool,
      data: json?['data'] == null ? null : NotiMooc.fromJson(json?['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'code': code,
        'error': error,
        'data': data,
      };
}
