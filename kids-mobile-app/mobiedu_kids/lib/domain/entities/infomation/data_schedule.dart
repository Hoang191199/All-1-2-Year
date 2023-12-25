import 'package:mobiedu_kids/domain/entities/activity.dart';

class DataSchedule {
  DataSchedule({
    this.schedule_name,
    this.description,
    this.details
  });

  List<Activity>? details;
  String? description;
  String? schedule_name;

  factory DataSchedule.fromJson(Map<String, dynamic>? json) {
    return DataSchedule(
       details:json?['details'] == null ? null : List<Activity>.from(json?["details"].map((x) => Activity.fromJson(x))),
       description: json?["description"] == null ? null : json?['description'] as String,
       schedule_name: json?["schedule_name"] == null ? null : json?['schedule_name'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'details': details,
    'schedule_name': schedule_name,
    'description': description
  };
}