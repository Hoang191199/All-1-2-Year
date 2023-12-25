class NotiData {
  NotiData({
    this.id,
    this.created_at,
    this.title,
    this.content,
    this.description,
    this.sent_date,
    this.status
  });

  int? id;
  String? created_at;
  String? title;
  String? content;
  String? description;
  String? sent_date;
  int? status;

  factory NotiData.fromJson(Map<String, dynamic>? json) {
    return NotiData(
      id: json?["id"] == null ? null : json?["id"] as int,
      created_at: json?["created_at"] == null ? null : json?["created_at"] as String,
      title: json?["title"] == null ? null : json?["title"] as String,
      content: json?["content"] == null ? null : json?["content"] as String,
      description: json?["description"] == null ? null : json?["description"] as String,
      sent_date: json?["sent_date"] == null ? null : json?["sent_date"] as String,
      status: json?["status"] == null ? null : json?["status"] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "description": description,
    "created_at": created_at,
    "sent_date": sent_date,
    "status": status
  };
}