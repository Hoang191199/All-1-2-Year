import 'package:mobiedu_kids/domain/entities/contact/class_in_contact.dart';
import 'package:mobiedu_kids/domain/entities/contact/data_child.dart';
import 'package:mobiedu_kids/domain/entities/contact/data_teacher.dart';
import 'package:mobiedu_kids/domain/entities/contact/school_in_contact.dart';

class ContactData {
  ContactData({
    this.school,
    this.classContact,
    this.teacher,
    this.child_list
  });

  SchoolInContact? school;
  ClassInContact? classContact;
  List<DataTeacher>? teacher;
  List<DataChild>? child_list;

    factory ContactData.fromJson(Map<String, dynamic>? json) {
    return ContactData(
      school: json?["school"] == null ? null : SchoolInContact.fromJson(json?['school']),
      classContact: json?["class"] == null ? null : ClassInContact.fromJson(json?['class']),
      teacher:json?['teacher'] == null ? null : List<DataTeacher>.from(json?["teacher"].map((x) => DataTeacher.fromJson(x))),
      child_list:json?['child_list'] == null ? null : List<DataChild>.from(json?["child_list"].map((x) => DataChild.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'school': school,
    'class': classContact,
    'teacher': teacher,
    'child_list': child_list
  };
}
