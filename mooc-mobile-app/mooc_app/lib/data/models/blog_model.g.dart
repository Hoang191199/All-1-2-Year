// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogModel _$BlogModelFromJson(Map<String, dynamic> json) => BlogModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => BlogInfo.fromJson(e as Map<String, dynamic>?))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : PagingMooc.fromJson(json['pagination'] as Map<String, dynamic>?),
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$BlogModelToJson(BlogModel instance) => <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'pagination': instance.pagination?.toJson(),
      'status': instance.status,
    };
