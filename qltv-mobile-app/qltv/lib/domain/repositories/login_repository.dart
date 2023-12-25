import 'package:qltv/domain/entities/response_data_object.dart';
import 'package:qltv/domain/entities/user_data.dart';

abstract class LoginRepository {
  Future<ResponseDataObject<UserData>> login(String username, String password);
}