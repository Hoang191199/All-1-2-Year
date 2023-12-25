class ReviewStudent {
  ReviewStudent({
    this.title,
    this.content
  });

  String? title;
  String? content;

  factory ReviewStudent.fromJson(Map<String, dynamic>? json) {
    return ReviewStudent(
      title: json?["title"] == null ? null : json?['title'] as String,
      content: json?["content"] == null ? null : json?['content'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'content': content,
  };
}