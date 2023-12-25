import 'package:mobiedu_kids/domain/entities/children_data.dart';
import 'package:mobiedu_kids/domain/entities/role/classes_data.dart';
import 'package:mobiedu_kids/domain/entities/role/schools_data.dart';

class RoleUser {
  RoleUser({
    this.classes,
    this.schools,
    this.children,
  });

  List<ClassesData>? classes;
  List<SchoolsData>? schools;
  List<ChildrenData>? children;

  factory RoleUser.fromJson(Map<String, dynamic>? json) {
    return RoleUser(
      classes:json?['classes'] == null ? null : List<ClassesData>.from(json?["classes"].map((x) => ClassesData.fromJson(x))),
      schools:json?['schools'] == null ? null : List<SchoolsData>.from(json?["schools"].map((x) => SchoolsData.fromJson(x))),
      children:json?['children'] == null ? null : List<ChildrenData>.from(json?["children"].map((x) => ChildrenData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "classes": classes,
        "schools": schools,
        "children": children,
      };
}
