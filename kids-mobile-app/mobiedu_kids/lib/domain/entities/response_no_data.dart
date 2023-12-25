class ResponseNoData {
  ResponseNoData({
    this.message,
    this.code,
    this.error,

  });

  String? message;
  int? code;
  bool? error;

  factory ResponseNoData.fromJson(Map<String, dynamic>? json) {
    return ResponseNoData(
      message: json?['message'] == null ? null : json?['message'] as String,
      code: json?['code'] == null ? null : json?['code'] as int,
      error: json?['error'] == null ? false : json?['error'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'code': code,
        'error': error,
      };
}
