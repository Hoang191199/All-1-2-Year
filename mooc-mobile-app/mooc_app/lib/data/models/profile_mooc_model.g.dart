// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_mooc_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileMoocModel _$ProfileMoocModelFromJson(Map<String, dynamic> json) =>
    ProfileMoocModel(
      code: json['code'] as int?,
      message: json['message'] as String?,
      error: json['error'] as bool?,
      data: json['data'] == null
          ? null
          : ProfileMooc.fromJson(json['data'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$ProfileMoocModelToJson(ProfileMoocModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'error': instance.error,
      'data': instance.data?.toJson(),
    };
