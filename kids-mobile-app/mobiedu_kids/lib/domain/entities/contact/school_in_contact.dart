import 'package:mobiedu_kids/domain/entities/contact/admin_in_school.dart';

class SchoolInContact{
  SchoolInContact({
    this.page_name,
    this.page_title,
    this.telephone,
    this.admin,
  });

  String? page_name;
  String? page_title;
  String? telephone;
  AdminInSchool? admin;

  factory SchoolInContact.fromJson(Map<String, dynamic>? json) {
    return SchoolInContact(
      page_name: json?["page_name"] == null ? null : json?['page_name'] as String,
      page_title: json?["page_title"] == null ? null : json?['page_title'] as String,
      telephone: json?["telephone"] == null ? null : json?['telephone'] as String,
      admin: json?["admin"] == null ? null : AdminInSchool.fromJson(json?['admin']),
    );
  }

  Map<String, dynamic> toJson() => {
    'page_name': page_name,
    'page_title': page_title,
    'telephone': telephone,
    'admin': admin,
  };
}