import 'package:mooc_app/domain/entities/response_data_object.dart';
import 'package:mooc_app/domain/entities/user_sso.dart';

abstract class AuthenticationRepository {
  Future<ResponseDataObject<UserSSO>> signinSSO(String code, String idDevice);
}