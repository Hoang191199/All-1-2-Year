import 'package:json_annotation/json_annotation.dart';
import 'package:mooc_app/domain/entities/read_all_response.dart';
part 'read_all_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ReadAllModel extends ReadAll{
  ReadAllModel({
    this.message,
    this.status,
    this.error,
    this.row_affected,
  }): super(message: message,status: status,error: error,row_affected: row_affected);

  String? message;
  bool? status;
  bool? error;
  int? row_affected;
  factory ReadAllModel.fromJson(Map<String, dynamic> json) =>
      _$ReadAllModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReadAllModelToJson(this);
}