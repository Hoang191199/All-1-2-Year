import 'package:mooc_app/domain/entities/course.dart';

class Collection {
  Collection({
    required this.title,
    required this.order,
    required this.courses,
  });

  String title;
  int order;
  List<Course> courses;

  factory Collection.fromJson(Map<String, dynamic>? json) {
    return Collection(
      title: json?['title'] as String,
      order: json?['order'] as int,
      courses: List<Course>.from(json?["courses"].map((x) => Course.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'order': order,
        'courses': List<dynamic>.from(courses.map((x) => x.toJson())),
      };
}
