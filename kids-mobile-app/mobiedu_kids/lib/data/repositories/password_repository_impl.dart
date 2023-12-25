import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/data/providers/network/apis/password_api.dart';
import 'package:mobiedu_kids/domain/entities/response_data.dart';
import 'package:mobiedu_kids/domain/repositories/password_repository.dart';

class PasswordRepositoryImpl extends PasswordRepository {
  @override
  Future<ResponseData> forget(String email) async {
    final response = await PasswordAPI.forget(email).request();
    return ResponseData.fromJson(response, DataType.typeObject);
  }

  @override
  Future<ResponseData> retrieve(
      String email, String otp, String newPw, String rePw) async {
    final response =
        await PasswordAPI.retrieve(email, otp, newPw, rePw).request();
    return ResponseData.fromJson(response, DataType.typeObject);
  }
}
