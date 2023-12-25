import 'package:get/get.dart';
import 'package:mobiedu_kids/data/repositories/profile_repository_impl.dart';
import 'package:mobiedu_kids/domain/usecases/profile_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/profile/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileRepositoryImpl());
    Get.lazyPut(() => ProfileUseCase(Get.find<ProfileRepositoryImpl>()));
    Get.lazyPut(() => DetailProfileUseCase(Get.find<ProfileRepositoryImpl>()));
    Get.lazyPut(() => EditProfileUseCase(Get.find<ProfileRepositoryImpl>()));
    Get.lazyPut(() => EditPasswordUseCase(Get.find<ProfileRepositoryImpl>()));
    Get.lazyPut(() => UpdateUseCase(Get.find<ProfileRepositoryImpl>()));
    Get.lazyPut(() => ResendEmailUseCase(Get.find<ProfileRepositoryImpl>()));
    Get.lazyPut(() => ProfileController(Get.find(), Get.find(), Get.find(),
        Get.find(), Get.find(), Get.find()));
  }
}
