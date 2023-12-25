class BookmarkItem {
  BookmarkItem({
    this.page,
    this.inner_page,
    this.content,
  });

  int? page;
  int? inner_page;
  String? content;

  factory BookmarkItem.fromJson(Map<String, dynamic>? json) {
    return BookmarkItem(
      page: json?["page"] == null ? null : json?['page'] as int,
      inner_page: json?["inner_page"] == null ? null : json?['inner_page'] as int,
      content: json?["content"] == null ? null : json?['content'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'page': page,
    'inner_page': inner_page,
    'content': content,
  };
}