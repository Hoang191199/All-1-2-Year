// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_noti_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListNotiModel _$ListNotiModelFromJson(Map<String, dynamic> json) =>
    ListNotiModel(
      error: json['error'] as bool?,
      message: json['message'] as String?,
      notifications: json['notifications'] == null
          ? null
          : Noti.fromJson(json['notifications'] as Map<String, dynamic>?),
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$ListNotiModelToJson(ListNotiModel instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'notifications': instance.notifications?.toJson(),
      'status': instance.status,
    };
