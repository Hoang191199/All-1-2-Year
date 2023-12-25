import 'package:qltv/app/config/app_constants.dart';
import 'package:qltv/data/providers/network/apis/password_api.dart';
import 'package:qltv/domain/entities/response_data.dart';
import 'package:qltv/domain/repositories/password_repository.dart';

class PasswordRepositoryImpl extends PasswordRepository {
  @override
  Future<ResponseData> change(String email, String otp, String newpass) async {
    final response = await PasswordAPI.change(email, otp, newpass).request();
    return ResponseData.fromJson(response, DataType.typeString);
  }

  @override
  Future<ResponseData> forget(String email) async {
    final response = await PasswordAPI.forget(email).request();
    return ResponseData.fromJson(response, DataType.typeString);
  }
}
