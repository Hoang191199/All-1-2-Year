import 'package:get/get.dart';
import 'package:mobiedu_kids/data/repositories/password_repository_impl.dart';
import 'package:mobiedu_kids/domain/usecases/password_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/password/password_controller.dart';

class PasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PasswordRepositoryImpl());
    Get.lazyPut(
        () => ForgetPasswordUseCase(Get.find<PasswordRepositoryImpl>()));
    Get.lazyPut(
        () => RetrievePasswordUseCase(Get.find<PasswordRepositoryImpl>()));
    Get.lazyPut(() => PasswordController(Get.find(), Get.find()));
  }
}
