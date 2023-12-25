class NotiData {
  NotiData({
    this.id,
    this.created_at,
    this.title,
    this.content,
    this.creator_id,
    this.read_at,
  });
  String? id;
  String? created_at;
  String? title;
  String? content;
  String? creator_id;
  String? read_at;
  factory NotiData.fromJson(Map<String, dynamic>? json) {
    return NotiData(
      id: json?["id"] == null ? null : json?["id"] as String,
      created_at: json?["created_at"] == null ? null : json?["created_at"] as String,
      title: json?["title"] == null ? null : json?["title"] as String,
      content: json?["content"] == null ? null : json?["content"] as String,
      creator_id: json?["creator_id"] == null ? null : json?["creator_id"] as String,
      read_at: json?["read_at"] == null ? null : json?["read_at"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": created_at,
    "title": title,
    "content": content,
    "creator_id": creator_id,
    "read_at": read_at
  };
}