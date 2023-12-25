import 'package:dartz/dartz.dart';
import 'package:mooc_app/app/core/usecases/no_param_usecase.dart';
import 'package:mooc_app/app/core/usecases/pram_usecase.dart';
import 'package:mooc_app/domain/entities/response_info.dart';
import 'package:mooc_app/domain/repositories/profile_repository.dart';

import '../entities/profile_data.dart';
import '../entities/response_data.dart';
import '../entities/response_data_array_object_pageless.dart';

class UpdateProfileUseCase extends ParamUseCase<
    ResponseDataArrayObjectPageless<ResponseInfo>,
    Tuple8<String, String, String?, String?, String?, String, String, String>> {
  UpdateProfileUseCase(this.profileRepository);

  final ProfileRepository profileRepository;

  @override
  Future<ResponseDataArrayObjectPageless<ResponseInfo>> execute(Tuple8 params) {
    return profileRepository.updateProfile(
        params.value1,
        params.value2,
        params.value3,
        params.value4,
        params.value5,
        params.value6,
        params.value7,
        params.value8);
  }
}
