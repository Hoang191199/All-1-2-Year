class ListChildDetails {
  ListChildDetails(
      {this.type,
      this.note,
      this.metadata,
      this.child_id,
      this.source_file,
      this.file_name,
      this.birthday,
      this.child_name,
      this.child_picture});

  String? type;
  String? note;
  String? metadata;
  String? child_id;
  String? source_file;
  String? file_name;
  String? birthday;
  String? child_name;
  String? child_picture;

  factory ListChildDetails.fromJson(Map<String, dynamic>? json) {
    return ListChildDetails(
      type: json?["type"] == null ? null : json?['type'] as String,
      note: json?["note"] == null ? null : json?['note'] as String,
      metadata: json?["metadata"] == null ? null : json?['metadata'] as String,
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
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "note": note,
        "metadata": metadata,
        "child_id": child_id,
        "source_file": source_file,
        "file_name": file_name,
        "birthday": birthday,
        "child_name": child_name,
        "child_picture": child_picture
      };
}
