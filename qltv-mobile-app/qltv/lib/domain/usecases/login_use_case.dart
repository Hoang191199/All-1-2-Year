import 'package:dartz/dartz.dart';
import 'package:qltv/app/core/usecases/pram_usecase.dart';
import 'package:qltv/domain/entities/response_data_object.dart';
import 'package:qltv/domain/entities/user_data.dart';
import 'package:qltv/domain/repositories/login_repository.dart';

class LoginUseCase extends ParamUseCase<ResponseDataObject<UserData>, Tuple2<String, String>> {
  LoginUseCase(this.loginRepository);

  final LoginRepository loginRepository;

  @override
  Future<ResponseDataObject<UserData>> execute(Tuple2 params) {
    return loginRepository.login(params.value1, params.value2);
  }
}
