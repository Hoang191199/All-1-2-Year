class MessengerConversationsFirebase {
  MessengerConversationsFirebase({
    this.content,
    this.time,
    this.type,
    this.userId
  });

  String? content;
  String? time;
  String?  type;
  String? userId;


  factory MessengerConversationsFirebase.fromJson(Map<String, dynamic>? json) {
    return MessengerConversationsFirebase(
      content: json?["content"] == null ? null : json?['content'] as String,
      time: json?["time"] == null ? null : json?['time'] as String,
      type: json?["type"] == null ? null : json?['type'] as String,
      userId: json?["userId"] == null ? null : json?['userId'] as String,
    );
  }

   Map<String, dynamic> toJson() => {
    "content": content,
    "time": time,
    "type": type,
    "userId": userId,
  };
}