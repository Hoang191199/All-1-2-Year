import 'package:mobiedu_kids/domain/entities/response_data.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/user_data.dart';

abstract class LogRepository {
  Future<ResponseDataObject<UserData>> login(String username, String password);
  Future<ResponseData> logout();
}
