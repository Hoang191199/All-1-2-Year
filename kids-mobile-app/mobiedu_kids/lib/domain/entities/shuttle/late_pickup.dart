import 'package:flutter/material.dart';
import 'package:mobiedu_kids/domain/entities/shuttle/data_student.dart';
import 'package:mobiedu_kids/domain/entities/shuttle/service_shuttle.dart';

class LatePickup {
  LatePickup({
    this.services,
    this.class_id,
    this.child_id,
    this.child_name,
    this.description,
    this.group_title,
    this.pickup_at,
    this.late_pickup_fee,
    this.pickup_id,
    this.pickup_child_id,
    this.birthday,
    this.status,
    this.pickup_class_id
    });

  List<ServiceShuttle>? services;
  String? class_id;
  String? child_id;
  String? child_name;
  String? description;
  String? group_title;
  String? pickup_at;
  String? late_pickup_fee;
  String? pickup_id;
  String? pickup_child_id;
  String? birthday;
  String? status;
  String? pickup_class_id;

  factory LatePickup.fromJson(Map<String, dynamic>? json) {
    return LatePickup(
      services:json?['services'] == null ? null : List<ServiceShuttle>.from(json?["services"].map((x) => ServiceShuttle.fromJson(x))),
      class_id: json?["class_id"] == null ? null : json?['class_id'] as String,
      child_id: json?["child_id"] == null ? null : json?['child_id'] as String,
      child_name: json?["child_name"] == null ? null : json?['child_name'] as String,
      description: json?["description"] == null ? null : json?['description'] as String,
      group_title: json?["group_title"] == null ? null : json?['group_title'] as String,
      pickup_at: json?["pickup_at"] == null ? null : json?['pickup_at'] as String,
      late_pickup_fee: json?["late_pickup_fee"] == null ? null : json?['late_pickup_fee'] as String,
      pickup_id: json?["pickup_id"] == null ? null : json?['pickup_id'] as String,
      pickup_child_id: json?["pickup_child_id"] == null ? null : json?['pickup_child_id'] as String,
      birthday: json?["birthday"] == null ? null : json?['birthday'] as String,
      status: json?["status"] == null ? null : json?['status'] as String,
      pickup_class_id: json?["pickup_class_id"] == null ? null : json?['pickup_class_id'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'services': services,
    'class_id': class_id,
    'child_id': child_id,
    'child_name': child_name,
    'description': description,
    'group_title': group_title,
    'pickup_at': pickup_at,
    'late_pickup_fee': late_pickup_fee,
    'pickup_id': pickup_id,
    'pickup_child_id': pickup_child_id,
    'birthday': birthday,
    'status': status,
    'pickup_class_id': pickup_class_id,
  };

  DataStudent parseToData({
    String? child_id,
    TextEditingController? description,
    bool? check,
    String? exist
  }) {
    return DataStudent(
      child_id: this.child_id,
      description: description  ?? TextEditingController(text: this.description),
      student: this,
      check: true,
      exist: pickup_class_id,
    );
  }
}
