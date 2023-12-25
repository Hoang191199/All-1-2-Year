import 'package:mooc_app/domain/entities/course.dart';

class CoursePaging {
  CoursePaging({
    required this.total,
    required this.item,
  });

  int? total;
  List<Course>? item;

  factory CoursePaging.fromJson(Map<String, dynamic>? json) {
    return CoursePaging(
      total: json?['total'] == null ? null : json?['total'] as int,
      item: json?["item"] == null ? null : List<Course>.from(json?["item"].map((x) => Course.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'total': total,
    'item': item
  };
}