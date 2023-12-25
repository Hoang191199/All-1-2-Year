// ignore_for_file: overridden_fields
import 'package:json_annotation/json_annotation.dart';
import 'package:mooc_app/domain/entities/course_combo.dart';
part 'course_combo_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CourseComboModel extends CourseCombo {
  CourseComboModel({
    required super.id,
    required this.name,
    required this.title,
    this.image_url,
    required this.sale_price,
    this.thumbnailFileUrl,
    required this.price,
    required this.sellingPrice,
    required this.slug,
    required this.totalCourses,
    required this.totalTeachers,
    required this.istrial,
    required this.expLearnMonths,
    required this.expLearnType,
    required this.courses,
    required this.registered,
  }) : super(
          name: name,
          title: title,
          image_url: image_url,
          sale_price: sale_price,
          thumbnailFileUrl: thumbnailFileUrl,
          price: price,
          sellingPrice: sellingPrice,
          slug: slug,
          totalCourses: totalCourses,
          totalTeachers: totalTeachers,
          istrial: istrial,
          expLearnMonths: expLearnMonths,
          expLearnType: expLearnType,
          courses: courses,
          registered: registered
        );

  @override
  String name;
  @override
  String title;
  @override
  String? image_url;
  @override
  String slug;
  @override
  String? thumbnailFileUrl;
  @override
  double price;
  @override
  double sellingPrice;
  @override
  double sale_price;
  @override
  int? totalCourses;
  @override
  int? totalTeachers;
  @override
  bool? istrial;
  @override
  int? expLearnMonths;
  @override
  int? expLearnType;
  @override
  List<CourseCombo>? courses;
  @override
  bool? registered;

  factory CourseComboModel.fromJson(Map<String, dynamic> json) =>
      _$CourseComboModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CourseComboModelToJson(this);
}
