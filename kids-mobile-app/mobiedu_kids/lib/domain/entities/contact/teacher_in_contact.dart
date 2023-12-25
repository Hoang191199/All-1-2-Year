import 'package:mobiedu_kids/domain/entities/contact/data_teacher.dart';

class TeacherInContact {
  TeacherInContact({
    this.teacher
  });

  List<DataTeacher>? teacher;

    factory TeacherInContact.fromJson(Map<String, dynamic>? json) {
    return TeacherInContact(
      teacher:json?['teacher'] == null ? null : List<DataTeacher>.from(json?["teacher"].map((x) => DataTeacher.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'teacher': teacher,
  };
}