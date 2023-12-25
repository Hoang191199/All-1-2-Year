import 'package:get/get.dart';
import 'package:mobiedu_kids/data/repositories/child_repository_impl.dart';
import 'package:mobiedu_kids/domain/usecases/child_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/list_student/child_controller.dart';

class ChildBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChildRepositoryImpl());
    Get.lazyPut(() => GetChildUseCase(Get.find<ChildRepositoryImpl>()));
    Get.lazyPut(() => DetailChildUseCase(Get.find<ChildRepositoryImpl>()));
    Get.lazyPut(
        () => DetailChildParentUseCase(Get.find<ChildRepositoryImpl>()));
    Get.lazyPut(() => AddChildUseCase(Get.find<ChildRepositoryImpl>()));
    Get.lazyPut(() => InfoChildUseCase(Get.find<ChildRepositoryImpl>()));
    Get.lazyPut(() => EditChildUseCase(Get.find<ChildRepositoryImpl>()));
    Get.lazyPut(() => EditChildParentUseCase(Get.find<ChildRepositoryImpl>()));
    Get.lazyPut(() => UploadAvatarUseCase(Get.find<ChildRepositoryImpl>()));
    Get.lazyPut(() => SearchUserUseCase(Get.find<ChildRepositoryImpl>()));
    Get.lazyPut(() => SearchCodeUseCase(Get.find<ChildRepositoryImpl>()));
    Get.lazyPut(() => OverViewUseCase(Get.find<ChildRepositoryImpl>()));
    Get.lazyPut(() => ChildController(
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find()
        ));
  }
}
