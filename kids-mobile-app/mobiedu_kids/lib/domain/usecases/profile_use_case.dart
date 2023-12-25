import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:mobiedu_kids/app/usecases/no_param_usecase.dart';
import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/info_profile.dart';
import 'package:mobiedu_kids/domain/entities/profile.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/repositories/profile_repository.dart';

class ProfileUseCase
    extends ParamUseCase<ResponseDataObject<InfoProfile>, Tuple2<String, int>> {
  ProfileUseCase(this.profileRepository);

  final ProfileRepository profileRepository;

  @override
  Future<ResponseDataObject<InfoProfile>> execute(Tuple2 params) {
    return profileRepository.profile(params.value1, params.value2);
  }
}

class DetailProfileUseCase
    extends ParamUseCase<ResponseDataObject<Profile>, String> {
  DetailProfileUseCase(this.profileRepository);

  final ProfileRepository profileRepository;

  @override
  Future<ResponseDataObject<Profile>> execute(params) {
    return profileRepository.detail(params);
  }
}

class EditProfileUseCase
    extends ParamUseCase<ResponseDataObject<Object>, Tuple2<String, String>> {
  EditProfileUseCase(this.profileRepository);

  final ProfileRepository profileRepository;

  @override
  Future<ResponseDataObject<Object>> execute(Tuple2 params) {
    return profileRepository.edit(params.value1, params.value2);
  }
}

class UpdateUseCase extends ParamUseCase<
    ResponseDataObject<Profile>,
    Tuple17<
        String,
        String,
        String,
        String,
        String,
        String,
        String,
        String,
        String,
        String,
        String,
        String,
        String,
        String,
        String,
        String,
        Uint8List>> {
  UpdateUseCase(this.profileRepository);

  final ProfileRepository profileRepository;

  @override
  Future<ResponseDataObject<Profile>> execute(Tuple17 params) {
    return profileRepository.update(
        params.value1,
        params.value2,
        params.value3,
        params.value4,
        params.value5,
        params.value6,
        params.value7,
        params.value8,
        params.value9,
        params.value10,
        params.value11,
        params.value12,
        params.value13,
        params.value14,
        params.value15,
        params.value16,
        params.value17);
  }
}

class EditPasswordUseCase extends ParamUseCase<ResponseDataObject<Object>,
    Tuple3<String, String, String>> {
  EditPasswordUseCase(this.profileRepository);

  final ProfileRepository profileRepository;

  @override
  Future<ResponseDataObject<Object>> execute(Tuple3 params) {
    return profileRepository.password(
        params.value1, params.value2, params.value3);
  }
}

class ResendEmailUseCase extends NoParamUseCase<ResponseDataObject<Object>> {
  ResendEmailUseCase(this.profileRepository);

  final ProfileRepository profileRepository;

  @override
  Future<ResponseDataObject<Object>> execute() {
    return profileRepository.resend();
  }
}
