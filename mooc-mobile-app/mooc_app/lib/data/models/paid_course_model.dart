import 'package:json_annotation/json_annotation.dart';
import 'package:mooc_app/domain/entities/collection.dart';
import 'package:mooc_app/domain/entities/paid_course.dart';
import 'package:mooc_app/domain/entities/paid_course_details.dart';
import 'package:mooc_app/domain/entities/slide_show.dart';

import '../../domain/entities/paging_mooc.dart';
part 'paid_course_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PaidCourseModel extends PaidCourse {
  PaidCourseModel({
    this.data,
    this.pagination,
    this.code
  }): super(data: data,pagination: pagination);

  List<PaidCourseDetails>? data;
  PagingMooc? pagination;
  int? code;
  factory PaidCourseModel.fromJson(Map<String, dynamic> json) =>
      _$PaidCourseModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaidCourseModelToJson(this);
}