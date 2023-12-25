class CompleteLessonResponseData {
  
  CompleteLessonResponseData({
    required this.isPass,
    required this.message,
  });

  bool? isPass;
  String? message;

  factory CompleteLessonResponseData.fromJson(Map<String, dynamic>? json) {
    return CompleteLessonResponseData(
      isPass: json?["isPass"] == null ? false : json?['isPass'] as bool,
      message: json?["message"] == null ? null : json?['message'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'isPass': isPass,
    'message': message,
  };
}