import 'package:flutter/cupertino.dart';
import 'package:mobiedu_kids/domain/entities/shuttle/late_pickup.dart';

class DataStudent {
  DataStudent({
    this.child_id,
    this.description,
    this.check,
    this.student,
    this.exist
  });

  String? child_id;
  TextEditingController? description;
  bool? check;
  LatePickup? student;
  String? exist;
}