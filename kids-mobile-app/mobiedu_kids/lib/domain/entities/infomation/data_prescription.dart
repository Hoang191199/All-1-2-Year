import 'package:mobiedu_kids/domain/entities/prescription/details.dart';

class DataPrescription {
  DataPrescription({
    this.medicine_list,
    this.guide,
    this.end,
    this.detail
  });

  String? medicine_list;
  String? guide;
  String? end;
  List<Details>? detail;

factory DataPrescription.fromJson(Map<String, dynamic>? json) {
    return DataPrescription(
      medicine_list: json?["medicine_list"] == null ? null : json?['medicine_list'] as String,
      guide: json?["guide"] == null ? null : json?['guide'] as String,
      end: json?["end"] == null ? null : json?['end'] as String,
      detail:json?['detail'] == null ? null : List<Details>.from(json?["detail"].map((x) => Details.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'medicine_list': medicine_list,
    'guide': guide,
    'end': end,
    'detail': detail,
  };
}