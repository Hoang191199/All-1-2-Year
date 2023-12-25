import 'package:get/get.dart';
import 'package:mobiedu_kids/data/repositories/media_repository_impl.dart';
import 'package:mobiedu_kids/domain/usecases/media_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/media/media_controller.dart';

class MediaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MediaRepositoryImpl());
    Get.lazyPut(() => MediaSupportUseCase(Get.find<MediaRepositoryImpl>()));
    Get.lazyPut(() => MediaComicUseCase(Get.find<MediaRepositoryImpl>()));
    Get.lazyPut(() => MediaVideoUseCase(Get.find<MediaRepositoryImpl>()));
    Get.lazyPut(() => DetailMediaUseCase(Get.find<MediaRepositoryImpl>()));
    Get.lazyPut(
        () => MediaController(Get.find(), Get.find(), Get.find(), Get.find()));
  }
}
