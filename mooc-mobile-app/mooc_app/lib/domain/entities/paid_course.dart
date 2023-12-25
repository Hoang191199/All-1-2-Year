import 'package:mooc_app/domain/entities/paging_mooc.dart';
import 'package:mooc_app/domain/entities/paid_course_details.dart';

class PaidCourse {
  PaidCourse({
    this.data,
    this.pagination,
    this.code
  });
  List<PaidCourseDetails>? data;
  PagingMooc? pagination;
  int? code;
  factory PaidCourse.fromJson(Map<String, dynamic>? json) {
    return PaidCourse(
      data: json?["data"] == null ? null : List<PaidCourseDetails>.from(json?["data"].map((x) => PaidCourseDetails.fromJson(x))),
      pagination: PagingMooc.fromJson(json?['pagination']),
      code: json?["code"] == null ? null : json?["code"] as int
    );
  }

  Map<String, dynamic> toJson() => {
    'data': data,
    'pagination': pagination,
    'code' : code
  };
}