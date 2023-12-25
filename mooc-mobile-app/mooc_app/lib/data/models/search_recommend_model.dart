import 'package:json_annotation/json_annotation.dart';
import 'package:mooc_app/domain/entities/course.dart';
import 'package:mooc_app/domain/entities/lesson.dart';
import 'package:mooc_app/domain/entities/owner.dart';
import 'package:mooc_app/domain/entities/review.dart';
import 'package:mooc_app/domain/entities/teacher.dart';
part 'search_recommend_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchRecommendModel extends Course {
  SearchRecommendModel({
    required this.id,
    required this.title,
    this.image_url,
    required this.price,
    required this.sale_price,
    required this.slug,
    required this.owner,
    required this.review,
    this.lesson,
    this.teacher,
  }) : super(
          id: id,
          title: title,
          image_url: image_url,
          price: price,
          sale_price: sale_price,
          slug: slug,
          owner: owner,
          review: review,
          lesson: lesson,
          teacher: teacher,
        );

  int id;
  String title;
  String? image_url;
  double price;
  double sale_price;
  String slug;
  Owner? owner;
  Review? review;
  List<Lesson>? lesson;
  Teacher? teacher;

  factory SearchRecommendModel.fromJson(Map<String, dynamic> json) =>
      _$SearchRecommendModelFromJson(json);
  Map<String, dynamic> toJson() => _$SearchRecommendModelToJson(this);
}
