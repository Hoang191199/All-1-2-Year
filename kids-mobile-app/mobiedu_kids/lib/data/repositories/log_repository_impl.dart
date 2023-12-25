import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/data/providers/network/apis/log_api.dart';
import 'package:mobiedu_kids/domain/entities/response_data.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/user_data.dart';
import 'package:mobiedu_kids/domain/repositories/log_repository.dart';

class LogRepositoryImpl extends LogRepository {
  @override
  Future<ResponseDataObject<UserData>> login(
      String username, String password) async {
    final response = await LogAPI.login(username, password).request();
    return ResponseDataObject<UserData>.fromJson(
        response, (data) => UserData.fromJson(data));
  }

  @override
  Future<ResponseData> logout() async {
    final response = await LogAPI.logout().request();
    return ResponseData.fromJson(response, DataType.typeObject);
  }
}
