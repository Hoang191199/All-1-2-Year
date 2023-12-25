import 'package:mobiedu_kids/domain/entities/prescription/details.dart';

class Medicines {
  Medicines({
    this.medicine_id,
    this.child_id,
    this.medicine_list,
    this.guide,
    this.child_name,
    this.end,
    this.birthday,
    this.details,
    this.source_file,
    this.time_per_day,
    this.child_picture
  });

  String? medicine_id;
  String? child_id;
  String? medicine_list;
  String? guide;
  String? child_name;
  String? end;
  String? birthday;
  List<Details>? details;
  String? source_file;
  String? time_per_day;
  String? child_picture;


  factory Medicines.fromJson(Map<String, dynamic>? json) {
    return Medicines(
      medicine_id: json?["medicine_id"] == null ? null : json?['medicine_id'] as String,
      child_id: json?["child_id"] == null ? null : json?['child_id'] as String,
      medicine_list: json?["medicine_list"] == null ? null : json?['medicine_list'] as String,
      end: json?["end"] == null ? null : json?['end'] as String,
      birthday: json?["birthday"] == null ? null : json?['birthday'] as String,
      details:json?['details'] == null ? null : List<Details>.from(json?["details"].map((x) => Details.fromJson(x))),
      source_file: json?["source_file"] == null ? null : json?['source_file'] as String,
      child_name: json?["child_name"] == null ? null : json?['child_name'] as String,
      guide: json?["guide"] == null ? null : json?['guide'] as String,
      time_per_day: json?["time_per_day"] == null ? null : json?['time_per_day'] as String,
      child_picture: json?["child_picture"] == null ? null : json?['child_picture'] as String
    );
  }

  Map<String, dynamic> toJson() => {
    'medicine_id': medicine_id,
    'child_id': child_id,
    'medicine_list': medicine_list,
    'end': end,
    'birthday': birthday,
    'details': details,
    'source_file': source_file,
    'child_name': child_name,
    'guide': guide,
    'time_per_day': time_per_day,
    'child_picture': child_picture
  };
}
