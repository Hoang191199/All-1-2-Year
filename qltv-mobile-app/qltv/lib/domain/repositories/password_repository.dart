import 'package:qltv/domain/entities/response_data.dart';

abstract class PasswordRepository {
  Future<ResponseData> change(String email, String otp, String newpass);

  Future<ResponseData> forget(String email);
}
