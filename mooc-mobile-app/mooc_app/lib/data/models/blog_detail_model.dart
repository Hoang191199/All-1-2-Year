import 'package:json_annotation/json_annotation.dart';
import 'package:mooc_app/domain/entities/blog_details.dart';

import '../../domain/entities/blog_details_info.dart';
part 'blog_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BlogDetailModel extends BlogDetails {
  BlogDetailModel({
    this.message,
    this.code,
    this.error,
    this.data,
  }): super(data: data,error: error,code: code,message: message);

  String? message;
  int? code;
  bool? error;
  BlogDetailInfo? data;

  factory BlogDetailModel.fromJson(Map<String, dynamic> json) =>
      _$BlogDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$BlogDetailModelToJson(this);
}