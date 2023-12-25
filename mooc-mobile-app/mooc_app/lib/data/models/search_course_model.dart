import 'package:json_annotation/json_annotation.dart';
import 'package:mooc_app/domain/entities/course.dart';
import 'package:mooc_app/domain/entities/search.dart';
part 'search_course_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchCourseModel extends Search {
  SearchCourseModel({
    required this.items,
  }) : super(
          items: items,
        );

  List<Course?> items;

  factory SearchCourseModel.fromJson(Map<String, dynamic> json) =>
      _$SearchCourseModelFromJson(json);
  Map<String, dynamic> toJson() => _$SearchCourseModelToJson(this);
}
