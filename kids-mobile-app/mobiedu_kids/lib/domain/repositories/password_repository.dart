import 'package:mobiedu_kids/domain/entities/response_data.dart';

abstract class PasswordRepository {
  Future<ResponseData> forget(String email);
  Future<ResponseData> retrieve(
      String email, String otp, String newPw, String rePw);
}
