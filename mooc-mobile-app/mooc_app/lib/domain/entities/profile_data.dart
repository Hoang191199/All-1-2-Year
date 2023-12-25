import 'package:mooc_app/domain/entities/profile.dart';

class ProfileData {
  ProfileData({
    required this.data
  });
  Profile data;
  factory ProfileData.fromJson(Map<String, dynamic>? json) {
    return ProfileData(
      data: Profile.fromJson(json?['data']),
    );
  }

  Map<String, dynamic> toJson() => {
    'data': data,
  };
}