class SubCategory {
  SubCategory({
    required this.id,
    required this.key,
    required this.label,
  });

  int id;
  String key;
  String label;

  factory SubCategory.fromJson(Map<String, dynamic>? json) {
    return SubCategory(
      id: json?['id'] as int,
      key: json?['key'] as String,
      label: json?['label'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'key': key,
    'label': label,
  };
}