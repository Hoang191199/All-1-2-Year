import 'package:mobiedu_kids/domain/entities/tuitions/data_tuition_detail.dart';

class TuitionDetail {
  TuitionDetail({this.tuition_detail});

  List<DataTuitionDetail>? tuition_detail;

  factory TuitionDetail.fromJson(Map<String, dynamic>? json) {
    return TuitionDetail(
      tuition_detail:json?['tuition_detail'] == null ? null : List<DataTuitionDetail>.from(json?["tuition_detail"].map((x) => DataTuitionDetail.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'tuition_detail': tuition_detail,
  };
}
