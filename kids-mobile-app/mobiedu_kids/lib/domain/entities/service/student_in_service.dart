import 'package:mobiedu_kids/domain/entities/service/cb_service.dart';
import 'package:mobiedu_kids/domain/entities/service/item_child.dart';
import 'package:mobiedu_kids/domain/entities/service/item_child_service.dart';

class StudentInService{
  StudentInService({
    this.child_id,
    this.child_name,
    this.cb_services,
    this.child_picture
  });

  String? child_id;
  String? child_name;
  String? child_picture;
  List<CbService>? cb_services;

    factory StudentInService.fromJson(Map<String, dynamic>? json) {
    return StudentInService(
      cb_services:json?['cb_services'] == null ? null : List<CbService>.from(json?["cb_services"].map((x) => CbService.fromJson(x))),
      child_id: json?["child_id"] == null ? null : json?['child_id'] as String,
      child_name: json?["child_name"] == null ? null : json?['child_name'] as String,
      child_picture: json?["child_picture"] == null ? null : json?['child_picture'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
      'child_id': child_id,
      'child_name': child_name,
      'cb_services': cb_services,
      'child_picture': child_picture
  };

  ItemChild parseToItemChild({
    String? child_id,
    String? child_name,
    List<ItemChildService>? service,
    String? child_picture
  }) {
    return ItemChild(
      child_id: this.child_id,
      child_name: this.child_name,
      child_picture: this.child_picture,
      service: cb_services?.map((e) => e.parseToItemChildService()).toList()
    );
  }
  
}