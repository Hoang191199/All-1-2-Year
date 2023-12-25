class ResponseDataArrayObjectPageless<T> {
  ResponseDataArrayObjectPageless({
    this.message,
    this.code,
    this.error,
    this.data,
  });

  String? message;
  int? code;
  bool? error;
  List<T>? data;

  factory ResponseDataArrayObjectPageless.fromJson(
      Map<String, dynamic>? json, Function(Map<String, dynamic>) create) {
    return ResponseDataArrayObjectPageless<T>(
      message: json?['message'] == null ? null : json?['message'] as String,
      code: json?['code'] == null ? null : json?['code'] as int,
      error: json?['error'] == null ? false : json?['error'] as bool,
      data: json?['data'] == null
          ? null
          : List<T>.from(json?["data"].map((x) => create(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'code': code,
        'error': error,
        'data': data,
      };
}
