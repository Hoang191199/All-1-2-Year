import 'package:get/get.dart';
import 'package:qltv/data/repositories/profile_repository_impl.dart';
import 'package:qltv/domain/usecases/profile_use_case.dart';
import 'package:qltv/presentation/controllers/profile/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileRepositoryImpl());
    Get.lazyPut(() => ProfileUseCase(Get.find<ProfileRepositoryImpl>()));
    Get.lazyPut(() => ProfileController(Get.find()));
  }
}
