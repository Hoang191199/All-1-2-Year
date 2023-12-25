import 'package:dartz/dartz.dart';
import 'package:mooc_app/app/core/usecases/pram_usecase.dart';
import 'package:mooc_app/domain/entities/response_data_object.dart';
import 'package:mooc_app/domain/entities/user_sso.dart';
import 'package:mooc_app/domain/repositories/auth_repository.dart';

class SigninSSOUseCase extends ParamUseCase<ResponseDataObject<UserSSO>, Tuple2<String, String>> {
  SigninSSOUseCase(this.authRepository);

  final AuthenticationRepository authRepository;

  @override
  Future<ResponseDataObject<UserSSO>> execute(Tuple2 params) {
    return authRepository.signinSSO(params.value1, params.value2);
  }
}
