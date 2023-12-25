import 'package:qltv/data/providers/network/apis/login_api.dart';
import 'package:qltv/domain/entities/response_data_object.dart';
import 'package:qltv/domain/entities/user_data.dart';
import 'package:qltv/domain/repositories/login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {
  @override
  Future<ResponseDataObject<UserData>> login(String username, String password) async {
    final response = await LoginAPI.login(username, password).request();
    return ResponseDataObject<UserData>.fromJson(response, (data) => UserData.fromJson(data));
  }
}
