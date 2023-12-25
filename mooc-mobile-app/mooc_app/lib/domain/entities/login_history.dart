import 'package:mooc_app/domain/entities/login_info.dart';
import 'package:mooc_app/domain/entities/paging_mooc.dart';

class LoginHistory {
  LoginHistory({
    this.data,
    this.pagination,
    this.code,
  });
  List<LogInfo>? data;
  PagingMooc? pagination;
  int? code;
  factory LoginHistory.fromJson(Map<String, dynamic>? json) {
    return LoginHistory(
      data: json?["data"] == null ? null : List<LogInfo>.from(json?["data"].map((x) => LogInfo.fromJson(x))),
      pagination: PagingMooc.fromJson(json?['pagination']),
    );
  }

  Map<String, dynamic> toJson() => {
    'data': data,
    'pagination': pagination
  };
}