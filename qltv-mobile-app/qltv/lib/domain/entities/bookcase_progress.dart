class BookcaseProgress {
  BookcaseProgress({
    this.item_id,
    this.chapter,
    this.progress,
    this.page,
    this.inner_page,
    this.words_per_page,
    this.font_family,
    this.font_size_multiplier,
  });

  int? item_id;
  String? chapter;
  int? progress;
  int? page;
  int? inner_page;
  int? words_per_page;
  String? font_family;
  double? font_size_multiplier;

  factory BookcaseProgress.fromJson(Map<String, dynamic>? json) {
    return BookcaseProgress(
      item_id: json?["item_id"] == null ? null : json?['item_id'] as int,
      chapter: json?["chapter"] == null ? null : json?['chapter'] as String,
      progress: json?["progress"] == null ? null : json?['progress'] as int,
      page: json?["page"] == null ? null : json?['page'] as int,
      inner_page: json?["inner_page"] == null ? null : json?['inner_page'] as int,
      words_per_page: json?["words_per_page"] == null ? null : json?['words_per_page'] as int,
      font_family: json?["font_family"] == null ? null : json?['font_family'] as String,
      font_size_multiplier: json?['font_size_multiplier'] == null ? 0.0 : json?['font_size_multiplier'].toDouble(), 
    );
  }

  Map<String, dynamic> toJson() => {
    'item_id': item_id,
    'chapter': chapter,
    'progress': progress,
    'page': page,
    'inner_page': inner_page,
    'words_per_page': words_per_page,
    'font_family': font_family,
    'font_size_multiplier': font_size_multiplier,
  };
}