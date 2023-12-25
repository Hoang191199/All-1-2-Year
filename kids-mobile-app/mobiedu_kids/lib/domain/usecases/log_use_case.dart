import 'package:dartz/dartz.dart';
import 'package:mobiedu_kids/app/usecases/no_param_usecase.dart';
import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/response_data.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/user_data.dart';
import 'package:mobiedu_kids/domain/repositories/log_repository.dart';

class LoginUseCase
    extends ParamUseCase<ResponseDataObject<UserData>, Tuple2<String, String>> {
  LoginUseCase(this.logRepository);

  final LogRepository logRepository;

  @override
  Future<ResponseDataObject<UserData>> execute(Tuple2 params) {
    return logRepository.login(params.value1, params.value2);
  }
}

class LogoutUseCase extends NoParamUseCase<ResponseData> {
  LogoutUseCase(this.logRepository);

  final LogRepository logRepository;

  @override
  Future<ResponseData> execute() {
    return logRepository.logout();
  }
}
