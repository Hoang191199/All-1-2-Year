import 'package:get/get.dart';
import 'package:qltv/data/repositories/password_repository_impl.dart';
import 'package:qltv/domain/usecases/password_use_case.dart';
import 'package:qltv/domain/usecases/put_otp_use_case.dart';
import 'package:qltv/presentation/controllers/password/password_controller.dart';

class PasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PasswordRepositoryImpl());
    Get.lazyPut(
        () => ForgotPasswordUseCase(Get.find<PasswordRepositoryImpl>()));
    Get.lazyPut(() => PutOTPUseCase(Get.find<PasswordRepositoryImpl>()));
    Get.lazyPut(() => PasswordController(Get.find(), Get.find()));
  }
}
