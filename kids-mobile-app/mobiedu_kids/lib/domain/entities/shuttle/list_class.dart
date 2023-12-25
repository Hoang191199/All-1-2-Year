class ListClass {
  ListClass({
    this.group_name,
    this.group_id,
    this.group_title,
  });

  String? group_name;
  String? group_id;
  String? group_title;

  factory ListClass.fromJson(Map<String, dynamic>? json) {
    return ListClass(
      group_name: json?["group_name"] == null ? null : json?['group_name'] as String,
      group_id: json?["group_id"] == null ? null : json?['group_id'] as String,
      group_title: json?["group_title"] == null ? null : json?['group_title'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'group_name': group_name,
    'group_id': group_id,
    'group_title': group_title,
  };
}
