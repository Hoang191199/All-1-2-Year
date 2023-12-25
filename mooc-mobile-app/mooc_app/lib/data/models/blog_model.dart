import 'package:json_annotation/json_annotation.dart';
import 'package:mooc_app/domain/entities/blog.dart';
import 'package:mooc_app/domain/entities/blog_info.dart';
import 'package:mooc_app/domain/entities/paging_mooc.dart';
part 'blog_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BlogModel extends Blog {
  BlogModel({
    this.data,
    this.pagination,
    this.status
  }): super(data: data,pagination: pagination,status: status);

  List<BlogInfo>? data;
  PagingMooc? pagination;
  bool? status;

  factory BlogModel.fromJson(Map<String, dynamic> json) =>
      _$BlogModelFromJson(json);
  Map<String, dynamic> toJson() => _$BlogModelToJson(this);
}