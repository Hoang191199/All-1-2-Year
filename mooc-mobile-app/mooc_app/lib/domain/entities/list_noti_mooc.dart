import 'package:mooc_app/domain/entities/paging_mooc.dart';
import 'noti_mooc.dart';

class ListNotiMooc {
  ListNotiMooc(
      {this.error, this.message, this.data, this.code, this.pagination});

  bool? error;
  String? message;
  List<NotiMooc>? data;
  int? code;
  PagingMooc? pagination;

  factory ListNotiMooc.fromJson(Map<String, dynamic>? json) {
    return ListNotiMooc(
      error: json?["error"] == null ? null : json?['error'] as bool,
      message: json?["message"] == null ? null : json?['message'] as String,
      data: json?["data"] == null
          ? null
          : List<NotiMooc>.from(json?["data"].map((x) => NotiMooc.fromJson(x))),
      code: json?["code"] == null ? null : json?['code'] as int,
      pagination: json?["pagination"] == null
          ? null
          : PagingMooc.fromJson(json?['pagination']),
    );
  }

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "code": code,
        "data": data,
        "pagination": pagination
      };
}
