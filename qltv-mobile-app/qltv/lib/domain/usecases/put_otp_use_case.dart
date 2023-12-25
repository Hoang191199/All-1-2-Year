import 'package:dartz/dartz.dart';
import 'package:qltv/app/core/usecases/pram_usecase.dart';
import 'package:qltv/domain/entities/response_data.dart';
import 'package:qltv/domain/repositories/password_repository.dart';

class PutOTPUseCase
    extends ParamUseCase<ResponseData, Tuple3<String, String, String>> {
  PutOTPUseCase(this.passwordRepository);

  final PasswordRepository passwordRepository;

  @override
  Future<ResponseData> execute(Tuple3 params) {
    return passwordRepository.change(
        params.value1, params.value2, params.value3);
  }
}
