import 'package:mobiedu_kids/domain/entities/tuitions/data_tuitions.dart';

class Tuitions {
  Tuitions({this.tuitions});

  List<DataTuitions>? tuitions;

  factory Tuitions.fromJson(Map<String, dynamic>? json) {
    return Tuitions(
      tuitions:json?['tuitions'] == null ? null : List<DataTuitions>.from(json?["tuitions"].map((x) => DataTuitions.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'tuitions': tuitions,
      };
}
