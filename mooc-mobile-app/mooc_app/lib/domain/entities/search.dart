import 'package:mooc_app/domain/entities/course.dart';

class Search {
  Search({
    required this.items,
  });

  final List<Course?> items;

  factory Search.fromJson(Map<String, dynamic>? json) {
    return Search(
      items: List<Course>.from(json?["items"]?.map((x) => Course.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'items': List<dynamic>.from(items.map((x) => x?.toJson())),
      };
}
