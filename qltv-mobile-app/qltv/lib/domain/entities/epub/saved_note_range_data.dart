class SavedNoteRangeData {
  int startNodeIndex;
  int startOffset;
  int endNodeIndex;
  int endOffset;

  SavedNoteRangeData({
    required this.startNodeIndex,
    required this.startOffset,
    required this.endNodeIndex,
    required this.endOffset,
  });

  factory SavedNoteRangeData.fromJson(Map<String, dynamic> json) {
    return SavedNoteRangeData(
      startNodeIndex: json['startNodeIndex'] as int,
      startOffset: json['startOffset'] as int,
      endNodeIndex: json['endNodeIndex'] as int,
      endOffset: json['endOffset'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startNodeIndex': startNodeIndex,
      'startOffset': startOffset,
      'endNodeIndex': endNodeIndex,
      'endOffset': endOffset,
    };
  }
}