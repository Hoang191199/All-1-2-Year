import 'package:get/get.dart';
import 'package:mobiedu_kids/domain/usecases/growth_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/growth/growth_controller.dart';

import '../../../data/repositories/growth_repository_impl.dart';

class GrowthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GrowthRepositoryImpl());
    Get.lazyPut(() => GetGrowthUseCase(Get.find<GrowthRepositoryImpl>()));
    Get.lazyPut(() => AddGrowthUseCase(Get.find<GrowthRepositoryImpl>()));
    Get.lazyPut(() => EditGrowthUseCase(Get.find<GrowthRepositoryImpl>()));
    // Get.lazyPut(() => EditGrowthAltUseCase(Get.find<GrowthRepositoryImpl>()));
    Get.lazyPut(() => DeleteGrowthUseCase(Get.find<GrowthRepositoryImpl>()));
    Get.lazyPut(() => GetGrowthChildUseCase(Get.find<GrowthRepositoryImpl>()));
    Get.lazyPut(() => AddGrowthChildUseCase(Get.find<GrowthRepositoryImpl>()));
    Get.lazyPut(() => EditGrowthChildUseCase(Get.find<GrowthRepositoryImpl>()));
    // Get.lazyPut(
    // () => EditGrowthAltChildUseCase(Get.find<GrowthRepositoryImpl>()));
    Get.lazyPut(
        () => DeleteGrowthChildUseCase(Get.find<GrowthRepositoryImpl>()));
    Get.lazyPut(() => GrowthController(
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
          // Get.find(),
          // Get.find()
        ));
  }
}
