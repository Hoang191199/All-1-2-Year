class ChildrenInHistory{
  ChildrenInHistory({
    this.child_name
  });

  String? child_name;

  factory ChildrenInHistory.fromJson(Map<String, dynamic>? json) {
    return ChildrenInHistory(
      child_name: json?["child_name"] == null ? null : json?['child_name'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
      'child_name': child_name,
  };
}