import 'package:json_annotation/json_annotation.dart';
import 'package:mooc_app/domain/entities/list_noti_mooc.dart';
import 'package:mooc_app/domain/entities/noti_mooc.dart';
import 'package:mooc_app/domain/entities/paging_mooc.dart';
part 'list_noti_mooc_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ListNotiMoocModel extends ListNotiMooc {
  ListNotiMoocModel(
      {this.error, this.message, this.data, this.code, this.pagination})
      : super(
            error: error,
            message: message,
            data: data,
            code: code,
            pagination: pagination);

  bool? error;
  String? message;
  List<NotiMooc>? data;
  int? code;
  PagingMooc? pagination;

  factory ListNotiMoocModel.fromJson(Map<String, dynamic> json) =>
      _$ListNotiMoocModelFromJson(json);
  Map<String, dynamic> toJson() => _$ListNotiMoocModelToJson(this);
}
