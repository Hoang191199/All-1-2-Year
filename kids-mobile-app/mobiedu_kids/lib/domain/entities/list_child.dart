class ListChild<T> {
  ListChild({
    this.listChild,
  });

  List<T>? listChild;

  factory ListChild.fromJson(
      Map<String, dynamic>? json, Function(Map<String, dynamic>) create) {
    return ListChild<T>(
      listChild: json?['listChild'] == null
          ? null
          : List<T>.from(json?["listChild"].map((x) => create(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'listChild': listChild,
      };
}
