import 'package:mooc_app/data/providers/network/apis/auth_api.dart';
import 'package:mooc_app/domain/entities/response_data_object.dart';
import 'package:mooc_app/domain/entities/user_sso.dart';
import 'package:mooc_app/domain/repositories/auth_repository.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  @override
  Future<ResponseDataObject<UserSSO>> signinSSO(String code, String idDevice) async {
    final response = await AuthAPI.login(code, idDevice).request();
    return ResponseDataObject<UserSSO>.fromJson(response, (data) => UserSSO.fromJson(data));
  }
}
