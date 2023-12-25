class InfoChildReview {
  InfoChildReview({
    this.child_id,
    this.type,
    this.review_date,
    this.metadata,
    this.note,
  });

    String? child_id;
    String? type;
    String? review_date;
    String? metadata;
    String? note;

  factory InfoChildReview.fromJson(Map<String, dynamic>? json) {
    return InfoChildReview(
      child_id: json?["child_id"] == null ? null : json?['child_id'] as String,
      type: json?["type"] == null ? null : json?['type'] as String,
      review_date: json?["review_date"] == null ? null : json?['review_date'] as String,
      metadata: json?["metadata"] == null ? null : json?['metadata'] as String,
      note: json?["note"] == null ? null : json?['note'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'child_id': child_id,
    'type': type,
    'review_date': review_date,
    'metadata': metadata,
    'note': note,
  };
}