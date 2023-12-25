import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/role/role_user.dart';

abstract class RoleUserRepository {
  Future<ResponseDataObject<RoleUser>> fetchData();
}
