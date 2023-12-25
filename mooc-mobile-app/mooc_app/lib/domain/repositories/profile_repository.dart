import 'package:mooc_app/domain/entities/profile_mooc_data.dart';
import 'package:mooc_app/domain/entities/response_data_array_object_pageless.dart';
import 'package:mooc_app/domain/entities/response_info.dart';

abstract class ProfileRepository {
  Future<ProfileMoocData> fetchProfile();
  Future<ResponseDataArrayObjectPageless<ResponseInfo>> updateProfile(
      String fullname,
      String email,
      String? phone,
      String? dob,
      String? avatar,
      String address,
      String gender,
      String city);
}
