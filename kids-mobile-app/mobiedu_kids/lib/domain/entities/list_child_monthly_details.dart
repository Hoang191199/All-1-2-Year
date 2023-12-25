class ListChildMonthlyDetails {
  ListChildMonthlyDetails(
      {this.child_id,
      this.begin_at,
      this.end_at,
      this.status,
      this.description,
      this.child_name,
      this.first_name,
      this.last_name,
      this.birthday,
      this.gender,
      this.child_picture,
      this.address,
      this.name_for_sort,
      this.type,
      this.date_begin,
      this.date_end,
      this.template_id,
      this.title,
      this.content,
      this.metadata,
      this.source_file_cert,
      this.file_name_cert});

  String? child_id;
  String? begin_at;
  String? end_at;
  String? status;
  String? description;
  String? child_name;
  String? first_name;
  String? last_name;
  String? birthday;
  String? gender;
  String? child_picture;
  String? address;
  String? name_for_sort;
  String? type;
  String? date_begin;
  String? date_end;
  String? template_id;
  String? title;
  String? content;
  String? metadata;
  String? source_file_cert;
  String? file_name_cert;

  factory ListChildMonthlyDetails.fromJson(Map<String, dynamic>? json) {
    return ListChildMonthlyDetails(
      child_id: json?["child_id"] == null ? null : json?['child_id'] as String,
      begin_at: json?["begin_at"] == null ? null : json?['begin_at'] as String,
      end_at: json?["end_at"] == null ? null : json?['end_at'] as String,
      status: json?["status"] == null ? null : json?['status'] as String,
      description:
          json?["description"] == null ? null : json?['description'] as String,
      child_name:
          json?["child_name"] == null ? null : json?['child_name'] as String,
      first_name:
          json?["first_name"] == null ? null : json?['first_name'] as String,
      last_name:
          json?["last_name"] == null ? null : json?['last_name'] as String,
      birthday: json?["birthday"] == null ? null : json?['birthday'] as String,
      gender: json?["gender"] == null ? null : json?['gender'] as String,
      child_picture: json?["child_picture"] == null
          ? null
          : json?['child_picture'] as String,
      address: json?["address"] == null ? null : json?['address'] as String,
      name_for_sort: json?["name_for_sort"] == null
          ? null
          : json?['name_for_sort'] as String,
      type: json?["type"] == null ? null : json?['type'] as String,
      date_begin:
          json?["date_begin"] == null ? null : json?['date_begin'] as String,
      date_end: json?["date_end"] == null ? null : json?['date_end'] as String,
      template_id:
          json?["template_id"] == null ? null : json?['template_id'] as String,
      title: json?["title"] == null ? null : json?['title'] as String,
      content: json?["content"] == null ? null : json?['content'] as String,
      metadata: json?["metadata"] == null ? null : json?['metadata'] as String,
      source_file_cert: json?["source_file_cert"] == null
          ? null
          : json?['source_file_cert'] as String,
      file_name_cert: json?["file_name_cert"] == null
          ? null
          : json?['file_name_cert'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "child_id": child_id,
        "begin_at": begin_at,
        "end_at": end_at,
        "status": status,
        "description": description,
        "child_name": child_name,
        "first_name": first_name,
        "last_name": last_name,
        "birthday": birthday,
        "gender": gender,
        "child_picture": child_picture,
        "address": address,
        "name_for_sort": name_for_sort,
        "type": type,
        "date_begin": date_begin,
        "date_end": date_end,
        "template_id": template_id,
        "title": title,
        "content": content,
        "metadata": metadata,
        "source_file_cert": source_file_cert,
        "file_name_cert": file_name_cert
      };
}
