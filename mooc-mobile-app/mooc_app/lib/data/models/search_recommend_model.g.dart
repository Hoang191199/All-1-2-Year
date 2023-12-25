// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_recommend_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchRecommendModel _$SearchRecommendModelFromJson(
        Map<String, dynamic> json) =>
    SearchRecommendModel(
      id: json['id'] as int,
      title: json['title'] as String,
      image_url: json['image_url'] as String?,
      price: (json['price'] as num).toDouble(),
      sale_price: (json['sale_price'] as num).toDouble(),
      slug: json['slug'] as String,
      owner: json['owner'] == null
          ? null
          : Owner.fromJson(json['owner'] as Map<String, dynamic>?),
      review: json['review'] == null
          ? null
          : Review.fromJson(json['review'] as Map<String, dynamic>?),
      lesson: (json['lesson'] as List<dynamic>?)
          ?.map((e) => Lesson.fromJson(e as Map<String, dynamic>?))
          .toList(),
      teacher: json['teacher'] == null
          ? null
          : Teacher.fromJson(json['teacher'] as Map<String, dynamic>?),
    )
      ..short_description = json['short_description'] as String?
      ..description = json['description'] as String?
      ..student = json['student'] as int?
      ..learn_what = json['learn_what'] as String?
      ..video_url = json['video_url'] as String?
      ..number_lesson = json['number_lesson'] as int?
      ..isMapping = json['isMapping'] as bool?
      ..idPackage = json['idPackage'] as int?;

Map<String, dynamic> _$SearchRecommendModelToJson(
        SearchRecommendModel instance) =>
    <String, dynamic>{
      'short_description': instance.short_description,
      'description': instance.description,
      'student': instance.student,
      'learn_what': instance.learn_what,
      'video_url': instance.video_url,
      'number_lesson': instance.number_lesson,
      'isMapping': instance.isMapping,
      'idPackage': instance.idPackage,
      'id': instance.id,
      'title': instance.title,
      'image_url': instance.image_url,
      'price': instance.price,
      'sale_price': instance.sale_price,
      'slug': instance.slug,
      'owner': instance.owner?.toJson(),
      'review': instance.review?.toJson(),
      'lesson': instance.lesson?.map((e) => e.toJson()).toList(),
      'teacher': instance.teacher?.toJson(),
    };
