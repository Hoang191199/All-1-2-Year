import 'package:qltv/domain/entities/punishment.dart';
import 'package:qltv/domain/entities/subject.dart';

class MetaDataProfile {
  MetaDataProfile({
    this.gender,
    this.birthday,
    this.end_year,
    this.fullname,
    this.start_year,
    this.expired_date,
    this.organization,
    this.subject_groups,
    this.avatar_url,
    this.punishment
  });

  int? gender;
  String? birthday;
  int? end_year;
  String? fullname;
  int? start_year;
  String? expired_date;
  String? organization;
  List<Subject>? subject_groups;
  String? avatar_url;
  List<Punishment>? punishment;

  factory MetaDataProfile.fromJson(Map<String, dynamic>? json) {
    return MetaDataProfile(
      gender: json?["gender"] == null ? null : json?["gender"] as int,
      birthday: json?["birthday"] == null ? null : json?["birthday"] as String,
      fullname: json?["fullname"] == null ? null : json?["fullname"] as String,
      end_year: json?["end_year"] == null ? null : json?["end_year"] as int,
      start_year:
          json?["start_year"] == null ? null : json?["start_year"] as int,
      expired_date: json?["expired_date"] == null
          ? null
          : json?["expired_date"] as String,
      organization:
      json?["organization"] == null ? null : json?["organization"] as String,
      subject_groups: json?["subject_groups"] == null
          ? null
          : List<Subject>.from(json?["subject_groups"].map((x) => Subject.fromJson(x))),
      avatar_url:
      json?["avatar_url"] == null ? null : json?["avatar_url"] as String,
      punishment: json?["punishment"] == null
          ? null
          : List<Punishment>.from(json?["punishment"].map((x) => Punishment.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "gender": gender,
        "birthday": birthday,
        "end_year": end_year,
        "fullname": fullname,
        "start_year": start_year,
        "expired_date": expired_date,
        "organization": organization,
        "subject_groups": subject_groups,
        "avatar_url": avatar_url,
        "punishment": punishment
      };
}
