import 'package:mooc_app/app/config/app_constants.dart';
import 'package:mooc_app/data/models/profile_model.dart';
import 'package:mooc_app/data/providers/network/apis/profile_api.dart';
import 'package:mooc_app/domain/entities/profile_mooc.dart';
import 'package:mooc_app/domain/entities/profile_mooc_data.dart';
import 'package:mooc_app/domain/entities/response_data.dart';
import 'package:mooc_app/domain/entities/response_info.dart';
import 'package:mooc_app/domain/repositories/profile_repository.dart';

import '../../domain/entities/response_data_array_object_pageless.dart';
import '../models/profile_mooc_model.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  @override
  Future<ProfileMoocData> fetchProfile() async {
    final response = await ProfileAPI.fetchProfile().request();
    print(response);
    return ProfileMoocModel.fromJson(response);
  }

  @override
  Future<ResponseDataArrayObjectPageless<ResponseInfo>> updateProfile(
      String fullname,
      String email,
      String? phone,
      String? dob,
      String? avatar,
      String address,
      String gender,
      String city) async {
    final response = await ProfileAPI.updateProfile(
            fullname, email, phone, dob, avatar, address, gender, city)
        .request();
    print(response);
    return ResponseDataArrayObjectPageless<ResponseInfo>.fromJson(
        response, (d) => ResponseInfo.fromJson(d));
  }
}
