import 'package:get/get.dart';
import 'package:mooc_app/presentation/controllers/profile/fetch_profile_controller.dart';
import 'package:mooc_app/presentation/controllers/profile/update_profile_controller.dart';

import '../../../data/repositories/profile_repository_impl.dart';
import '../../../domain/usecases/fetch_profile_use_case.dart';
import '../../../domain/usecases/update_profile_use_case.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileRepositoryImpl());
    Get.lazyPut(() => UpdateProfileUseCase(Get.find<ProfileRepositoryImpl>()));
    Get.lazyPut(() => FetchProfileUseCase(Get.find<ProfileRepositoryImpl>()));
    Get.lazyPut(() => UpdateProfileController(Get.find()));
    Get.lazyPut(() => FetchProfileController(Get.find()));
  }
}