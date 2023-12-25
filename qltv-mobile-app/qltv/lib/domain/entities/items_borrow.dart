class ItemsBorrow {
  ItemsBorrow({this.author, this.title});

  String? title;
  String? author;

  factory ItemsBorrow.fromJson(Map<String, dynamic>? json) {
    return ItemsBorrow(
      title: json?["title"] == null ? null : json?['title'] as String,
      author: json?["author"] == null ? null : json?['author'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'author': author,
      };
}
