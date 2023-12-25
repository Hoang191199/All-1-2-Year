import 'package:json_annotation/json_annotation.dart';

import 'package:mooc_app/domain/entities/profile_mooc_data.dart';

import '../../domain/entities/profile_mooc.dart';
part 'profile_mooc_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProfileMoocModel extends ProfileMoocData {
  ProfileMoocModel({
    this.code,
    this.message,
    this.error,
    this.data
  }): super(
  );

  String? message;
  int? code;
  bool? error;
  ProfileMooc? data;

  factory ProfileMoocModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileMoocModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileMoocModelToJson(this);
}