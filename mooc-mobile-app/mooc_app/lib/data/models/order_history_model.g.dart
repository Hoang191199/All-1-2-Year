// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderHistoryModel _$OrderHistoryModelFromJson(Map<String, dynamic> json) =>
    OrderHistoryModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => OrderHistory.fromJson(e as Map<String, dynamic>?))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : PagingMooc.fromJson(json['pagination'] as Map<String, dynamic>?),
      code: json['code'] as int?,
    )..status = json['status'] as bool?;

Map<String, dynamic> _$OrderHistoryModelToJson(OrderHistoryModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'pagination': instance.pagination?.toJson(),
      'code': instance.code,
    };
