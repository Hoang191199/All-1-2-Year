import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/login_history.dart';
import '../../domain/entities/login_info.dart';
import '../../domain/entities/paging_mooc.dart';
part 'login_history_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginHistoryModel extends LoginHistory{
  LoginHistoryModel({
    this.data,
    this.pagination,
    this.code,
  }): super(data: data,pagination: pagination);

  List<LogInfo>? data;
  PagingMooc? pagination;
  int? code;
  factory LoginHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$LoginHistoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginHistoryModelToJson(this);
}