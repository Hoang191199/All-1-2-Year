class ListChildDailyDetails {
  ListChildDailyDetails(
      {this.type,
      this.child_id,
      this.source_file,
      this.file_name,
      this.birthday,
      this.child_name,
      this.child_picture,
      this.content,
      this.title,
      this.source_file_cert,
      this.file_name_cert,
      this.date_begin,
      this.date_end,
      this.template_id,
      this.metadata});

  String? type;
  String? child_id;
  String? source_file;
  String? file_name;
  String? birthday;
  String? child_name;
  String? child_picture;
  String? content;
  String? title;
  String? source_file_cert;
  String? file_name_cert;
  String? date_begin;
  String? date_end;
  String? template_id;
  String? metadata;

  factory ListChildDailyDetails.fromJson(Map<String, dynamic>? json) {
    return ListChildDailyDetails(
      type: json?["type"] == null ? null : json?['type'] as String,
      child_id: json?["child_id"] == null ? null : json?['child_id'] as String,
      source_file:
          json?["source_file"] == null ? null : json?['source_file'] as String,
      file_name:
          json?["file_name"] == null ? null : json?['file_name'] as String,
      birthday: json?["birthday"] == null ? null : json?['birthday'] as String,
      child_name:
          json?["child_name"] == null ? null : json?['child_name'] as String,
      child_picture: json?["child_picture"] == null
          ? null
          : json?['child_picture'] as String,
      content: json?["content"] == null ? null : json?['content'] as String,
      title: json?["title"] == null ? null : json?['title'] as String,
      source_file_cert: json?["source_file_cert"] == null
          ? null
          : json?['source_file_cert'] as String,
      file_name_cert: json?["file_name_cert"] == null
          ? null
          : json?['file_name_cert'] as String,
      date_begin:
          json?["date_begin"] == null ? null : json?['date_begin'] as String,
      date_end: json?["date_end"] == null ? null : json?['date_end'] as String,
      template_id:
          json?["template_id"] == null ? null : json?['template_id'] as String,
      metadata: json?["metadata"] == null ? null : json?['metadata'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "child_id": child_id,
        "source_file": source_file,
        "file_name": file_name,
        "birthday": birthday,
        "child_name": child_name,
        "child_picture": child_picture,
        "content": content,
        "title": title,
        "source_file_cert": source_file_cert,
        "file_name_cert": file_name_cert,
        "date_begin": date_begin,
        "date_end": date_end,
        "template_id": template_id,
        "metadata": metadata
      };
}
