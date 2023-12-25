class NotiMooc {
  NotiMooc({
    this.id,
    this.created_at,
    this.title,
    this.content,
    this.creator_id,
    this.read_at,
    this.creator_name,
    this.ref_data,
    this.ttl_times,
    this.ex_user_id,
  });
  String? id;
  String? created_at;
  String? title;
  String? content;
  String? creator_id;
  String? read_at;
  String? creator_name;
  String? ref_data;
  int? ttl_times;
  String? ex_user_id;

  factory NotiMooc.fromJson(Map<String, dynamic>? json) {
    return NotiMooc(
      id: json?["id"] == null ? null : json?["id"] as String,
      created_at:
          json?["created_at"] == null ? null : json?["created_at"] as String,
      title: json?["title"] == null ? null : json?["title"] as String,
      content: json?["content"] == null ? null : json?["content"] as String,
      creator_id:
          json?["creator_id"] == null ? null : json?["creator_id"] as String,
      read_at: json?["read_at"] == null ? null : json?["read_at"] as String,
      creator_name: json?["creator_name"] == null
          ? null
          : json?["creator_name"] as String,
      ref_data: json?["ref_data"] == null ? null : json?["ref_data"] as String,
      ttl_times: json?["ttl_times"] == null ? null : json?["ttl_times"] as int,
      ex_user_id:
          json?["ex_user_id"] == null ? null : json?["ex_user_id"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": created_at,
        "title": title,
        "content": content,
        "creator_id": creator_id,
        "read_at": read_at,
        "creator_name": creator_name,
        "ref_data": ref_data,
        "ttl_times": ttl_times,
        "ex_user_id": ex_user_id,
      };
}
