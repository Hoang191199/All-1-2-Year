import 'package:flutter/material.dart';
import 'package:mobiedu_kids/domain/entities/attendance/detail.dart';

class DetailTemp {
  DetailTemp({
    this.id,
    this.check,
    this.permission,
    this.reason,
    this.image,
    this.student,
    this.show,
    this.status,
    this.status_back,
    this.check_back,
    this.time_back,
    this.came_back_note,
    this.source_file,
    this.fileName,
  });

  String? id;
  bool? check;
  int? permission;
  TextEditingController? reason;
  String? image;
  bool? show;
  Detail? student;
  String? status;
  String? status_back;
  String? time_back;
  bool? check_back;
  TextEditingController? came_back_note;
  String? source_file;
  String? fileName;
}
