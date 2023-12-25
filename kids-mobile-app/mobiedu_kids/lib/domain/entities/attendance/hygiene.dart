import 'package:flutter/material.dart';
import 'package:mobiedu_kids/domain/entities/attendance/hygiene_temp.dart';

class Hygiene {
  Hygiene({
    this.type,
    this.note,
    this.child_id,
    this.child_picture,
    this.child_name,
    this.metadata
  });
  String? type;
  String? note;
  String? child_id;
  String? child_picture;
  String? child_name;
  String? metadata;

  factory Hygiene.fromJson(Map<String, dynamic>? json) {
    var status = json?['status'];

    if (status is String) {
    } else if (status is int) {
    }
    
    return Hygiene(
      child_id: json?["child_id"] == null ? null : json?['child_id'] as String,
      child_name: json?["child_name"] == null ? null : json?['child_name'] as String,
      child_picture: json?["child_picture"] == null ? null : json?['child_picture'] as String,
      type: json?["type"] == null ? null : json?['type'] as String,
      note: json?["note"] == null ? null : json?['note'] as String,
      metadata: json?["metadata"] == null ? null : json?['metadata'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'child_id': child_id,
    'child_name': child_name,
    'child_picture': child_picture,
    'type': type,
    'note': note,
    'metadata': metadata,
  };

  HygieneTemp parseToHygieneTemp({
    String? metadata,
    TextEditingController? note,
    bool? check
  }) {
    return HygieneTemp(
      id: child_id,
      metadata: metadata  ?? this.metadata,
      note: note ?? TextEditingController(text: this.note),
      student: this,
      check: check ?? false
    );
  }

}