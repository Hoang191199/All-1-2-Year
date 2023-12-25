import 'package:qltv/app/core/usecases/no_param_usecase.dart';
import 'package:qltv/domain/entities/profile_info.dart';
import 'package:qltv/domain/entities/reader_info.dart';
import 'package:qltv/domain/entities/response_data.dart';
import 'package:qltv/domain/repositories/profile_repository.dart';
import '../entities/response_data_object.dart';

class ProfileUseCase extends NoParamUseCase<ResponseDataObject<ProfileInfo>> {
  ProfileUseCase(this.profileRepository);

  final ProfileRepository profileRepository;

  @override
  Future<ResponseDataObject<ProfileInfo>> execute() {
    return profileRepository.fetchProfile();
  }

  @override
  Future<ResponseDataObject<ReaderInfo>> executeRd(int id) {
    return profileRepository.fetchReader(id);
  }

  @override
  Future<ResponseData> executeUp(String fullname, String email, String phone,
      String birthday, int gender, String description, String avatar_url) {
    return profileRepository.updateProfile(
        fullname, email, phone, birthday, gender, description, avatar_url);
  }
}
