import 'package:mooc_app/domain/entities/cart.dart';
import 'package:mooc_app/domain/entities/lesson.dart';
import 'package:mooc_app/domain/entities/owner.dart';
import 'package:mooc_app/domain/entities/review.dart';
import 'package:mooc_app/domain/entities/review_data.dart';
import 'package:mooc_app/domain/entities/teacher.dart';

class Course {

  Course({
    required this.id,
    required this.title,
    this.short_description,
    this.description,
    this.student,
    this.learn_what,
    this.image_url,
    this.video_url,
    required this.price,
    required this.sale_price,
    required this.slug,
    this.owner,
    this.review,
    this.lesson,
    this.teacher,
    this.number_lesson,
    this.isMapping,
    this.courseReviews,
    this.idPackage,
  });

  int id;
  String title;
  String? short_description;
  String? description;
  int? student;
  String? learn_what;
  String? image_url;
  String? video_url;
  double price;
  double sale_price;
  String slug;
  Owner? owner;
  Review? review;
  List<Lesson>? lesson;
  Teacher? teacher;
  int? number_lesson;
  bool? isMapping;
  List<ReviewData>? courseReviews;
  int? idPackage;

  factory Course.fromJson(Map<String, dynamic>? json) {
    return Course(
      id: json?['id'] as int,
      title: json?['title'] == null ? '' : json?['title'] as String,
      short_description: json?["short_description"] == null ? null : json?['short_description'] as String,
      description: json?["description"] == null ? null : json?['description'] as String,
      student: json?["student"] == null ? null : json?['student'] as int,
      learn_what: json?["learn_what"] == null ? null : json?['learn_what'] as String,
      image_url: json?['image_url'] == null ? '' : json?['image_url'] as String,
      video_url: json?["video_url"] == null ? null : json?['video_url'] as String,
      price: json?['price'] == null ? 0.0 : json?['price'].toDouble(),
      sale_price: json?['sale_price'] == null ? 0.0 : json?['sale_price'].toDouble(),
      slug: json?['slug'] == null ? '' : json?['slug'] as String,
      owner: json?['owner'] == null ? null : Owner.fromJson(json?['owner']),
      review: json?['review'] == null ? null : Review.fromJson(json?['review']),
      lesson: json?["lesson"] == null ? null : List<Lesson>.from(json?["lesson"].map((x) => Lesson.fromJson(x))),
      teacher: json?['teacher'] == null ? null : Teacher.fromJson(json?['teacher']),
      number_lesson: json?['number_lesson'] == null ? null : json?['number_lesson'] as int,
      isMapping: json?["isMapping"] == null ? false : json?['isMapping'] as bool,
      courseReviews: json?["courseReviews"] == null ? null : List<ReviewData>.from(json?["courseReviews"].map((x) => ReviewData.fromJson(x))),
      idPackage: json?['idPackage'] == null ? null : json?['idPackage'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'short_description': short_description,
        'description': description,
        'student': student,
        'learn_what': learn_what,
        'image_url': image_url,
        'video_url': video_url,
        'price': price,
        'sale_price': sale_price,
        'slug': slug,
        'owner': owner,
        'review': review,
        'lesson': lesson,
        'teacher': teacher,
        'number_lesson': number_lesson,
        'isMapping': isMapping,
        'courseReviews': courseReviews,
        'idPackage': idPackage,
      };

  Cart parseCart({
    int? id,
    int? course_id,
    int? user_id,
  }) =>
      Cart(
        id: id,
        course_id: course_id ?? this.id,
        user_id: user_id,
      );
}
