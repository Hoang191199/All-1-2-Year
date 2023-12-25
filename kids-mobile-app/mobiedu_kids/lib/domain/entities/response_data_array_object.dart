class ResponseDataArrayObject<T> {
  ResponseDataArrayObject({
    this.message,
    this.code,
    // this.error,
    this.data,
  });

  String? message;
  int? code;
  // bool? error;
  List<T>? data;

  factory ResponseDataArrayObject.fromJson(
      Map<String, dynamic>? json, Function(Map<String, dynamic>) create) {
    return ResponseDataArrayObject<T>(
      message: json?['message'] == null ? null : json?['message'] as String,
      code: json?['code'] == null ? null : json?['code'] as int,
      // error: json?['error'] == null ? false : json?['error'] as bool,
      // data: json?['data'] == null ? null : DataArrayObject.fromJson(json?['data'], create),
      data: json?['data'] == null
          ? null
          : List<T>.from(json?["data"].map((x) => create(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'code': code,
        // 'error': error,
        'data': data,
      };
}
