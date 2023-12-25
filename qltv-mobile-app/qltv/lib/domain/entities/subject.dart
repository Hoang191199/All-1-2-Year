class Subject {
  Subject({this.id, this.title});

  int? id;
  String? title;

  factory Subject.fromJson(Map<String, dynamic>? json) {
    return Subject(
      id: json?["id"] == null ? null : json?["id"] as int,
      title: json?["title"] == null ? null : json?["title"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };

  @override
  String toString() {
    return title ?? '';
  }
}
