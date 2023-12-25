// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paid_course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaidCourseModel _$PaidCourseModelFromJson(Map<String, dynamic> json) =>
    PaidCourseModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PaidCourseDetails.fromJson(e as Map<String, dynamic>?))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : PagingMooc.fromJson(json['pagination'] as Map<String, dynamic>?),
      code: json['code'] as int?,
    );

Map<String, dynamic> _$PaidCourseModelToJson(PaidCourseModel instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'pagination': instance.pagination?.toJson(),
      'code': instance.code,
    };
