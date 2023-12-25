import 'package:json_annotation/json_annotation.dart';
import 'package:mooc_app/domain/entities/profile.dart';
import 'package:mooc_app/domain/entities/profile_data.dart';
part 'profile_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProfileModel extends ProfileData{
  ProfileModel({
    required this.data,
  }): super(data: data);

  Profile data;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}