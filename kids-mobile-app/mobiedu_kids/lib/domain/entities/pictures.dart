class Pictures {
  Pictures({
    this.child_journal_album_id,
    this.child_journal_id,
    this.file_name,
    this.source_file,
    this.source_file_path,
  });

  String? child_journal_album_id;
  String? child_journal_id;
  String? file_name;
  String? source_file;
  String? source_file_path;

  factory Pictures.fromJson(Map<String, dynamic>? json) {
    return Pictures(
      child_journal_album_id: json?["child_journal_album_id"] == null
          ? null
          : json?['child_journal_album_id'] as String,
      child_journal_id: json?["child_journal_id"] == null
          ? null
          : json?['child_journal_id'] as String,
      file_name:
          json?["file_name"] == null ? null : json?['file_name'] as String,
      source_file:
          json?["source_file"] == null ? null : json?['source_file'] as String,
      source_file_path: json?["source_file_path"] == null
          ? null
          : json?['source_file_path'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'child_journal_album_id': child_journal_album_id,
        'child_journal_id': child_journal_id,
        'file_name': file_name,
        'source_file': source_file,
        'source_file_path': source_file_path,
      };
}
