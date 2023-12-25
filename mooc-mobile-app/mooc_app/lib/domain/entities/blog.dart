import 'package:mooc_app/domain/entities/blog_info.dart';
import 'package:mooc_app/domain/entities/paging_mooc.dart';

class Blog {
  Blog({
    this.data,
    this.pagination,
    this.status
  });

  List<BlogInfo>? data;
  PagingMooc? pagination;
  bool? status;
  factory Blog.fromJson(Map<String, dynamic>? json) {
    return Blog(
      data: json?["data"] == null ? null : List<BlogInfo>.from(json?["data"].map((x) => BlogInfo.fromJson(x))),
      pagination: PagingMooc.fromJson(json?['pagination']),
      status: json?['status'] == null ? null : json?['status'] as bool
    );
  }

  Map<String, dynamic> toJson() => {
    'data': data,
    'pagination': pagination,
    'status': status,
  };
}