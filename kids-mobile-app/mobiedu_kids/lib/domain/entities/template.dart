class Template {
  Template(
      {this.id,
      this.checked_user_id,
      this.type,
      this.title,
      this.content,
      this.source_file,
      this.file_name,
      this.class_id,
      this.school_id,
      this.arena,
      this.created_at,
      this.updated_at});

  String? id;
  String? checked_user_id;
  String? type;
  String? title;
  String? content;
  String? source_file;
  String? file_name;
  String? class_id;
  String? school_id;
  String? arena;
  String? created_at;
  String? updated_at;

  factory Template.fromJson(Map<String, dynamic>? json) {
    return Template(
      id: json?['id'] == null ? null : json?['id'] as String,
      checked_user_id: json?['checked_user_id'] == null
          ? null
          : json?['checked_user_id'] as String,
      type: json?['type'] == null ? null : json?['type'] as String,
      title: json?['title'] == null ? null : json?['title'] as String,
      content: json?['content'] == null ? null : json?['content'] as String,
      source_file:
          json?['source_file'] == null ? null : json?['source_file'] as String,
      file_name:
          json?['file_name'] == null ? null : json?['file_name'] as String,
      class_id: json?['class_id'] == null ? null : json?['class_id'] as String,
      school_id:
          json?['school_id'] == null ? null : json?['school_id'] as String,
      arena: json?['arena'] == null ? null : json?['arena'] as String,
      created_at:
          json?['created_at'] == null ? null : json?['created_at'] as String,
      updated_at:
          json?['updated_at'] == null ? null : json?['updated_at'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "checked_user_id": checked_user_id,
        "type": type,
        "title": title,
        "content": content,
        "source_file": source_file,
        "file_name": file_name,
        "class_id": class_id,
        "school_id": school_id,
        "arena": arena,
        "created_at": created_at,
        "updated_at": updated_at
      };
}
