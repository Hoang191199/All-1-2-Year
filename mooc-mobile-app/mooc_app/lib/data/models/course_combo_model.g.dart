// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_combo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseComboModel _$CourseComboModelFromJson(Map<String, dynamic> json) =>
    CourseComboModel(
      id: json['id'] as int,
      name: json['name'] as String,
      title: json['title'] as String,
      image_url: json['image_url'] as String?,
      sale_price: (json['sale_price'] as num).toDouble(),
      thumbnailFileUrl: json['thumbnailFileUrl'] as String?,
      price: (json['price'] as num).toDouble(),
      sellingPrice: (json['sellingPrice'] as num).toDouble(),
      slug: json['slug'] as String,
      totalCourses: json['totalCourses'] as int?,
      totalTeachers: json['totalTeachers'] as int?,
      istrial: json['istrial'] as bool?,
      expLearnMonths: json['expLearnMonths'] as int?,
      expLearnType: json['expLearnType'] as int?,
      courses: (json['courses'] as List<dynamic>?)
          ?.map((e) => CourseCombo.fromJson(e as Map<String, dynamic>?))
          .toList(),
      registered: json['registered'] as bool?,
    );

Map<String, dynamic> _$CourseComboModelToJson(CourseComboModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'title': instance.title,
      'image_url': instance.image_url,
      'slug': instance.slug,
      'thumbnailFileUrl': instance.thumbnailFileUrl,
      'price': instance.price,
      'sellingPrice': instance.sellingPrice,
      'sale_price': instance.sale_price,
      'totalCourses': instance.totalCourses,
      'totalTeachers': instance.totalTeachers,
      'istrial': instance.istrial,
      'expLearnMonths': instance.expLearnMonths,
      'expLearnType': instance.expLearnType,
      'courses': instance.courses?.map((e) => e.toJson()).toList(),
      'registered': instance.registered,
    };
