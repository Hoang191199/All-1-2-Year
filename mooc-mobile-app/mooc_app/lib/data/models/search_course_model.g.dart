// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchCourseModel _$SearchCourseModelFromJson(Map<String, dynamic> json) =>
    SearchCourseModel(
      items: (json['items'] as List<dynamic>)
          .map((e) =>
              e == null ? null : Course.fromJson(e as Map<String, dynamic>?))
          .toList(),
    );

Map<String, dynamic> _$SearchCourseModelToJson(SearchCourseModel instance) =>
    <String, dynamic>{
      'items': instance.items.map((e) => e?.toJson()).toList(),
    };
