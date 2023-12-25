import 'package:qltv/app/config/app_constants.dart';

class ResponseData {
  ResponseData({
    this.message,
    this.code,
    this.error,
    this.data,
  });
  
  String? message;
  int? code;
  bool? error;
  Object? data;

  factory ResponseData.fromJson(Map<String, dynamic>? json, String dataType) {
    var data;
    switch (dataType) {
      case DataType.typeString:
        data = json?['data'] == null ? null : json?['data'] as String;
        break;
      case DataType.typeInt:
        data = json?['data'] == null ? null : json?['data'] as int;
        break;
      case DataType.typeDouble:
        data = json?['data'] == null ? 0.0 : json?['data'].toDouble();
        break;
      case DataType.typeBool:
        data = json?['data'] == null ? false : json?['data'] as bool;
        break;
      default:
        break;
    }
    return ResponseData(
      message: json?['message'] == null ? null : json?['message'] as String,
      code: json?['code'] == null ? null : json?['code'] as int,
      error: json?['error'] == null ? true : json?['error'] as bool,
      data: data,
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'code': code,
    'error': error,
    'data': data,
  };
}