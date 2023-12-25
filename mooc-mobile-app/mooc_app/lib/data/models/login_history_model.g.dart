// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginHistoryModel _$LoginHistoryModelFromJson(Map<String, dynamic> json) =>
    LoginHistoryModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => LogInfo.fromJson(e as Map<String, dynamic>?))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : PagingMooc.fromJson(json['pagination'] as Map<String, dynamic>?),
      code: json['code'] as int?,
    );

Map<String, dynamic> _$LoginHistoryModelToJson(LoginHistoryModel instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'pagination': instance.pagination?.toJson(),
      'code': instance.code,
    };
