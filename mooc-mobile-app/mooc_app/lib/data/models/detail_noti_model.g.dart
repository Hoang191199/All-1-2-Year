// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_noti_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailNotiModel _$DetailNotiModelFromJson(Map<String, dynamic> json) =>
    DetailNotiModel(
      error: json['error'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : NotiMooc.fromJson(json['data'] as Map<String, dynamic>?),
      code: json['code'] as int?,
    );

Map<String, dynamic> _$DetailNotiModelToJson(DetailNotiModel instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'data': instance.data?.toJson(),
      'code': instance.code,
    };
