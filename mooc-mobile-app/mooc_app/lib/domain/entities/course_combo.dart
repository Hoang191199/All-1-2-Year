import 'package:mooc_app/domain/entities/course.dart';

class CourseCombo {
  CourseCombo({
    required this.id,
    this.thumbnailFileUrl,
    required this.name,
    required this.title,
    this.image_url,
    required this.sale_price,
    required this.price,
    required this.sellingPrice,
    required this.slug,
    required this.totalCourses,
    required this.totalTeachers,
    required this.istrial,
    required this.expLearnMonths,
    required this.expLearnType,
    required this.courses,
    this.registered,
  });

  int id;
  String name;
  String title;
  String slug;
  String? image_url;
  String? thumbnailFileUrl;
  double price;
  double sellingPrice;
  double sale_price;
  int? totalCourses;
  int? totalTeachers;
  bool? istrial;
  int? expLearnMonths;
  int? expLearnType;
  List<CourseCombo>? courses;
  bool? registered;

  factory CourseCombo.fromJson(Map<String, dynamic>? json) {
    return CourseCombo(
      id: json?['id'] as int,
      name: json?['name'] == null ? '' : json?['name'] as String,
      title: json?['title'] == null ? '' : json?['title'] as String,
      price: json?['price'] == null ? 0.0 : json?['price'].toDouble(),
      thumbnailFileUrl: json?['thumbnailFileUrl'] == null
          ? ''
          : json?['thumbnailFileUrl'] as String,
      image_url: json?['image_url'] == null
          ? ''
          : json?['image_url'] as String,
      sale_price: json?['sale_price'] == null ? 0 : json?['sale_price'].toDouble(),
      sellingPrice: json?['sellingPrice'] == null ? 0 : json?['sellingPrice'].toDouble(),
      slug: json?['slug'] == null ? '' : json?['slug'] as String,
      totalCourses:
          json?['totalCourses'] == null ? 0 : json?['totalCourses'] as int,
      totalTeachers:
          json?['totalTeachers'] == null ? 0 : json?['totalTeachers'] as int,
      expLearnMonths:
          json?['expLearnMonths'] == null ? 0 : json?['expLearnMonths'] as int,
      expLearnType:
          json?['expLearnType'] == null ? 0 : json?['expLearnType'] as int,
      istrial: json?['istrial'] == null ? false : json?['istrial'] as bool,
      courses: json?['courses'] == null
          ? null
          : List<CourseCombo>.from(json?["courses"].map((x) => CourseCombo.fromJson(x))),
      registered:
          json?["registered"] == null ? false : json?['registered'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'name': name,
        'slug': slug,
        'image_url': image_url,
        'thumbnailFileUrl': thumbnailFileUrl,
        'price': price,
        'sale_price': sale_price,
        'sellingPrice': sellingPrice,
        'totalCourses': totalCourses,
        'totalTeachers': totalTeachers,
        'istrial': istrial,
        'expLearnMonths': expLearnMonths,
        'expLearnType': expLearnType,
        'courses': courses,
        'registered': registered,
      };

  Course parseCourse({
    int? id,
    String? title,
    String? slug,
    String? image_url,
    double? price,
    double? sale_price,
    int? idPackage
  }) =>
      Course(
        id: id ?? this.id,
        idPackage: id ?? this.id,
        title: name,
        slug: slug ?? this.slug,
        image_url: thumbnailFileUrl ?? thumbnailFileUrl,
        price: price ?? this.price,
        sale_price: sellingPrice,
      );
}
