
import 'package:mooc_app/domain/entities/paging_mooc.dart';

class ResponseDataArrayObject<T> {
  ResponseDataArrayObject({
    this.message,
    this.code,
    this.error,
    this.data,
    this.pagination,
  });
  
  String? message;
  int? code;
  bool? error;
  List<T>? data;
  PagingMooc? pagination;

  factory ResponseDataArrayObject.fromJson(Map<String, dynamic>? json, Function(Map<String, dynamic>) create) {
    return ResponseDataArrayObject<T>(
      message: json?['message'] == null ? null : json?['message'] as String,
      code: json?['code'] == null ? null : json?['code'] as int,
      error: json?['error'] == null ? false : json?['error'] as bool,
      data: json?['data'] == null ? null : List<T>.from(json?["data"].map((x) => create(x))),
      pagination: json?['pagination'] == null ? null : PagingMooc.fromJson(json?['pagination']),
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'code': code,
    'error': error,
    'data': data,
    'pagination': pagination,
  };
}