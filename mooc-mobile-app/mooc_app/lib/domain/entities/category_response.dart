import 'category.dart';

class CategoryResponse {
  CategoryResponse(
      {required this.status, required this.items, required this.total});

  final bool status;
  final List<Category>? items;
  final int total;

  factory CategoryResponse.fromJson(Map<String, dynamic>? json) {
    return CategoryResponse(
      status: json?['status'] == null ? false : json?['status'] as bool,
      items: json?["items"] == null
          ? null
          : List<Category>.from(
              json?["items"].map((x) => Category.fromJson(x))),
      total: json?['total'] == null ? 0 : json?['total'] as int,
    );
  }

  Map<String, dynamic> toJson() =>
      {'status': status, 'items': items, 'total': total};
}
