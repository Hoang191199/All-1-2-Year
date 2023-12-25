// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogDetailModel _$BlogDetailModelFromJson(Map<String, dynamic> json) =>
    BlogDetailModel(
      message: json['message'] as String?,
      code: json['code'] as int?,
      error: json['error'] as bool?,
      data: json['data'] == null
          ? null
          : BlogDetailInfo.fromJson(json['data'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$BlogDetailModelToJson(BlogDetailModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'error': instance.error,
      'data': instance.data?.toJson(),
    };
