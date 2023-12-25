import 'package:flutter/widgets.dart';
import 'package:mobiedu_kids/domain/entities/attendance/hygiene.dart';

class HygieneTemp {
  HygieneTemp({
    this.id,
    this.metadata,
    this.note,
    this.student,
    this.check
  });
  String? id;
  String? metadata;
  TextEditingController? note;
  Hygiene? student;
  bool? check;
}