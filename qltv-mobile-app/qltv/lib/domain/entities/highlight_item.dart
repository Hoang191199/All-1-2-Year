class HighlightItem {
  HighlightItem({
    this.title,
    this.highlightText,
    this.description,
    this.color,
    this.page,
    this.startNodeIndex,
    this.endNodeIndex,
    this.startOffset,
    this.endOffset,
  });

  String? title;
  String? highlightText;
  String? description;
  String? color;
  int? page;
  int? startNodeIndex;
  int? endNodeIndex;
  int? startOffset;
  int? endOffset;

  factory HighlightItem.fromJson(Map<String, dynamic>? json) {
    return HighlightItem(
      title: json?["title"] == null ? null : json?['title'] as String,
      highlightText: json?["highlightText"] == null ? null : json?['highlightText'] as String,
      description: json?["description"] == null ? null : json?['description'] as String,
      color: json?["color"] == null ? null : json?['color'] as String,
      page: json?["page"] == null ? null : json?['page'] as int,
      startNodeIndex: json?["startNodeIndex"] == null ? null : json?['startNodeIndex'] as int,
      endNodeIndex: json?["endNodeIndex"] == null ? null : json?['endNodeIndex'] as int,
      startOffset: json?["startOffset"] == null ? null : json?['startOffset'] as int,
      endOffset: json?["endOffset"] == null ? null : json?['endOffset'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'highlightText': highlightText,
    'description': description,
    'color': color,
    'page': page,
    'startNodeIndex': startNodeIndex,
    'endNodeIndex': endNodeIndex,
    'startOffset': startOffset,
    'endOffset': endOffset,
  };
}