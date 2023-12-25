class ChildData {
  ChildData({
    this.child_id,
    this.child_name,
  });

  String? child_id;
  String? child_name;

  factory ChildData.fromJson(Map<String, dynamic>? json) {
    return ChildData(
      child_id: json?["child_id"] == null ? null : json?['child_id'] as String,
      child_name:
          json?["child_name"] == null ? null : json?['child_name'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "child_id": child_id,
        "child_name": child_name,
      };
}
