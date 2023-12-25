import 'package:mobiedu_kids/domain/entities/activity.dart';

class DetailSchedule {
  DetailSchedule({
    this.details
  });

  List<Activity>? details;

  factory DetailSchedule.fromJson(Map<String, dynamic>? json) {
    return DetailSchedule(
      details:json?['details'] == null ? null : List<Activity>.from(json?["details"].map((x) => Activity.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'details': details,
  };
}