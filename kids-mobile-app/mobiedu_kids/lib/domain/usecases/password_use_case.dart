import 'package:dartz/dartz.dart';
import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/response_data.dart';
import 'package:mobiedu_kids/domain/repositories/password_repository.dart';

class ForgetPasswordUseCase extends ParamUseCase<ResponseData, String> {
  ForgetPasswordUseCase(this.passwordRepository);

  final PasswordRepository passwordRepository;

  @override
  Future<ResponseData> execute(String params) {
    return passwordRepository.forget(params);
  }
}

class RetrievePasswordUseCase
    extends ParamUseCase<ResponseData, Tuple4<String, String, String, String>> {
  RetrievePasswordUseCase(this.passwordRepository);

  final PasswordRepository passwordRepository;

  @override
  Future<ResponseData> execute(Tuple4 params) {
    return passwordRepository.retrieve(
        params.value1, params.value2, params.value3, params.value4);
  }
}