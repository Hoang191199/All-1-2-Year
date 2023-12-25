import 'package:mobiedu_kids/app/usecases/no_param_usecase.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/role/role_user.dart';
import 'package:mobiedu_kids/domain/repositories/role_user_repository.dart';

class RoleUserUseCase extends NoParamUseCase<ResponseDataObject<RoleUser>> {
  RoleUserUseCase(this.roleUserRepository);

  final RoleUserRepository roleUserRepository;

  @override
  Future<ResponseDataObject<RoleUser>> execute() {
    return roleUserRepository.fetchData();
  }
}
