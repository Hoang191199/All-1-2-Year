import 'package:json_annotation/json_annotation.dart';
import 'package:mooc_app/domain/entities/detail_noti.dart';
import 'package:mooc_app/domain/entities/noti_mooc.dart';
import '../../domain/entities/noti.dart';
part 'detail_noti_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DetailNotiModel extends DetailNoti {
  DetailNotiModel({
    this.error,
    this.message,
    this.data,
    this.code,
  }) : super(
          error: error,
          message: message,
          data: data,
          code: code,
        );

  bool? error;
  String? message;
  NotiMooc? data;
  int? code;

  factory DetailNotiModel.fromJson(Map<String, dynamic> json) =>
      _$DetailNotiModelFromJson(json);
  Map<String, dynamic> toJson() => _$DetailNotiModelToJson(this);
}
