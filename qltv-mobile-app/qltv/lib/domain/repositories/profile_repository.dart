import 'package:qltv/domain/entities/profile_info.dart';
import 'package:qltv/domain/entities/reader_info.dart';
import 'package:qltv/domain/entities/response_data.dart';
import 'package:qltv/domain/entities/response_data_object.dart';

abstract class ProfileRepository {
  Future<ResponseDataObject<ProfileInfo>> fetchProfile();
  Future<ResponseDataObject<ReaderInfo>> fetchReader(int id);
  Future<ResponseData> updateProfile(
      String fullname,
      String email,
      String phone,
      String birthday,
      int gender,
      String description,
      String avatar_url);
}
