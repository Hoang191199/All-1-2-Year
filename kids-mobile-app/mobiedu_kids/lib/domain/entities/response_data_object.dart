class ResponseDataObject<T> {
  ResponseDataObject({
    this.message,
    this.code,
    // this.error,
    this.data,
  });

  String? message;
  int? code;
  // bool? error;
  T? data;

  factory ResponseDataObject.fromJson(
      Map<String, dynamic>? json, Function(Map<String, dynamic>) create) {
    return ResponseDataObject<T>(
      message: json?['message'] == null ? null : json?['message'] as String,
      code: json?['code'] == null ? null : json?['code'] as int,
      // error: json?['error'] == null ? false : json?['error'] as bool,
      data: json?['data'] == null ? null : create(json?['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'code': code,
        // 'error': error,
        'data': data,
      };
}
