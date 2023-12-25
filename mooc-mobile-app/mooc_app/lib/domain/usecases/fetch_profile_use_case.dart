import 'package:dartz/dartz.dart';
import 'package:mooc_app/app/core/usecases/no_param_usecase.dart';
import 'package:mooc_app/domain/entities/profile_mooc_data.dart';
import 'package:mooc_app/domain/repositories/profile_repository.dart';

import '../entities/profile_data.dart';

class FetchProfileUseCase extends NoParamUseCase<ProfileMoocData> {
  FetchProfileUseCase(this.profileRepository);

  final ProfileRepository profileRepository;

  @override
  Future<ProfileMoocData> execute() {
    return profileRepository.fetchProfile();
  }
}