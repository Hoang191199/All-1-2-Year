// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'read_all_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReadAllModel _$ReadAllModelFromJson(Map<String, dynamic> json) => ReadAllModel(
      message: json['message'] as String?,
      status: json['status'] as bool?,
      error: json['error'] as bool?,
      row_affected: json['row_affected'] as int?,
    );

Map<String, dynamic> _$ReadAllModelToJson(ReadAllModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'error': instance.error,
      'row_affected': instance.row_affected,
    };
