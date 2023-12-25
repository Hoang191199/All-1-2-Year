import 'package:mobiedu_kids/domain/entities/tuitions/data_tuition_childs.dart';

class TuitionChilds {
  TuitionChilds({this.tuition_child});

  List<DataTuitionChilds>? tuition_child;

  factory TuitionChilds.fromJson(Map<String, dynamic>? json) {
    return TuitionChilds(
      tuition_child:json?['tuition_child'] == null ? null : List<DataTuitionChilds>.from(json?["tuition_child"].map((x) => DataTuitionChilds.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'tuition_child': tuition_child,
  };
}
