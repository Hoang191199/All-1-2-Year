import 'package:mooc_app/domain/entities/sub_category.dart';

class Category {
  Category({
    required this.id,
    required this.key,
    required this.label,
    this.children,
  });

  int id;
  String key;
  String label;
  List<SubCategory>? children;

  factory Category.fromJson(Map<String, dynamic>? json) {
    return Category(
      id: json?['id'] as int,
      key: json?['key'] as String,
      label: json?['label'] as String,
      children: json?["children"] == null ? null : List<SubCategory>.from(json?["children"]?.map((x) => SubCategory.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'key': key,
        'label': label,
        'children': children
  };
}