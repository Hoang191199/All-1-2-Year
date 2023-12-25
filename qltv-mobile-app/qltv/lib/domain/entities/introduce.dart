class Introduce {
  Introduce({
    this.title,
    this.content,
    this.visible,
  });

  String? title;
  String? content;
  bool? visible;
  String? position;

  factory Introduce.fromJson(Map<String, dynamic>? json) {
    return Introduce(
      title: json?["title"] == null ? null : json?['title'] as String,
      content: json?["content"] == null ? null : json?['content'] as String,
      visible: json?["visible"] == null ? false : json?['visible'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'content': content,
    'visible': visible,
  };
}