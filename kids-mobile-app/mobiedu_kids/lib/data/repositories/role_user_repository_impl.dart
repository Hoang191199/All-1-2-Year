import 'package:mobiedu_kids/data/providers/network/apis/role_user_api.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/role/role_user.dart';
import 'package:mobiedu_kids/domain/repositories/role_user_repository.dart';

class RoleUserRepositoryImpl extends RoleUserRepository {
  @override
  Future<ResponseDataObject<RoleUser>> fetchData() async {
    final response = await RoleUserApi.fetchData().request();
    return ResponseDataObject<RoleUser>.fromJson(
        response, (data) => RoleUser.fromJson(data));
  }
}
