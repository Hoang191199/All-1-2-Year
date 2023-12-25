import 'package:get/get.dart';
import 'package:mooc_app/data/repositories/auth_repository_Impl.dart';
import 'package:mooc_app/domain/usecases/signin_sso_use_case.dart';
import 'package:mooc_app/presentation/controllers/auth/auth_controller.dart';


class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SigninSSOUseCase(Get.find<AuthenticationRepositoryImpl>()));
    Get.put(AuthController(Get.find()), permanent: true);
  }
}
