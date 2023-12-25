// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_noti_mooc_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListNotiMoocModel _$ListNotiMoocModelFromJson(Map<String, dynamic> json) =>
    ListNotiMoocModel(
      error: json['error'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => NotiMooc.fromJson(e as Map<String, dynamic>?))
          .toList(),
      code: json['code'] as int?,
      pagination: json['pagination'] == null
          ? null
          : PagingMooc.fromJson(json['pagination'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$ListNotiMoocModelToJson(ListNotiMoocModel instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'code': instance.code,
      'pagination': instance.pagination?.toJson(),
    };
