class ResponseInfo {
  ResponseInfo({
    this.name,
    this.message,
  });

  String? name;
  String? message;

  factory ResponseInfo.fromJson(Map<String, dynamic>? json) {
    return ResponseInfo(
      name: json?['name'] == null ? null : json?['name'] as String,
      message: json?['message'] == null ? null : json?['message'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'message': message,
      };
}
