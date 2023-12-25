class Borrowing {
  Borrowing({
    this.publications,
    this.document,
  });

  int? publications;
  int? document;

  factory Borrowing.fromJson(Map<String, dynamic>? json) {
    return Borrowing(
      publications:
          json?["publications"] == null ? null : json?['publications'] as int,
      document: json?["document"] == null ? null : json?['document'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'publications': publications,
        'document': document,
      };
}
