import 'package:qltv/app/config/app_constants.dart';
import 'package:qltv/data/providers/network/apis/profile_api.dart';
import 'package:qltv/data/providers/network/apis/profile_reader_api.dart';
import 'package:qltv/data/providers/network/apis/update_profile_api.dart';
import 'package:qltv/domain/entities/profile_info.dart';
import 'package:qltv/domain/entities/reader_info.dart';
import 'package:qltv/domain/entities/response_data.dart';
import 'package:qltv/domain/entities/response_data_object.dart';
import 'package:qltv/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  @override
  Future<ResponseDataObject<ProfileInfo>> fetchProfile() async {
    final response = await ProfileAPI.fetchProfile().request();
    print(response);
    return ResponseDataObject<ProfileInfo>.fromJson(
        response, (data) => ProfileInfo.fromJson(data));
  }

  @override
  Future<ResponseDataObject<ReaderInfo>> fetchReader(int id) async {
    final response = await ReaderProfileAPI.fetchReader(id).request();
    print(response);
    return ResponseDataObject<ReaderInfo>.fromJson(
        response, (data) => ReaderInfo.fromJson(data));
  }

  @override
  Future<ResponseData> updateProfile(
      String fullname,
      String email,
      String phone,
      String birthday,
      int gender,
      String description,
      String avatar_url) async {
    final response = await UpdateProfileAPI.updateProfile(
            fullname, email, phone, birthday, gender, description, avatar_url)
        .request();
    print(response);
    return ResponseData.fromJson(response, DataType.typeString);
  }
}
