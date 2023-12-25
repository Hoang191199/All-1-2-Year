import 'package:qltv/app/core/usecases/pram_usecase.dart';
import 'package:qltv/domain/entities/response_data.dart';
import 'package:qltv/domain/repositories/password_repository.dart';

class ForgotPasswordUseCase extends ParamUseCase<ResponseData, String> {
  ForgotPasswordUseCase(this.passwordRepository);

  final PasswordRepository passwordRepository;

  @override
  Future<ResponseData> execute(String params) {
    return passwordRepository.forget(params);
  }
}
