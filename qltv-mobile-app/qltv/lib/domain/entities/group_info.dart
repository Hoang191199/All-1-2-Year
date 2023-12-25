class GroupInfo {
  GroupInfo({
    this.name,
    this.id,
  });

  String? name;
  int? id;

  factory GroupInfo.fromJson(Map<String, dynamic>? json) {
    return GroupInfo(
      name: json?["name"] == null ? null : json?["name"] as String,
      id: json?["id"] == null ? null : json?["id"] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}
