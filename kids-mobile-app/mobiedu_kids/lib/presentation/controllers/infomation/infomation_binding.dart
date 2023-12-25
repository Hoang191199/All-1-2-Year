import 'package:get/get.dart';
import 'package:mobiedu_kids/data/repositories/information_repository_impl.dart';
import 'package:mobiedu_kids/domain/usecases/infomation_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/infomation/infomation_controller.dart';

class InformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InfomationRepositoryImpl());
    Get.lazyPut(() => InfomationUseCase(Get.find<InfomationRepositoryImpl>()));
    Get.lazyPut(() => GetMenuInfoUseCase(Get.find<InfomationRepositoryImpl>()));
    Get.lazyPut(() => GetScheduleInfoUseCase(Get.find<InfomationRepositoryImpl>()));
    Get.lazyPut(() => NewPostInfoUseCase(Get.find<InfomationRepositoryImpl>()));
    Get.lazyPut(() => ActionLikeUseCase(Get.find<InfomationRepositoryImpl>()));
    Get.lazyPut(() => ActionCommentUseCase(Get.find<InfomationRepositoryImpl>()));
    Get.lazyPut(() => PostDetailUseCase(Get.find<InfomationRepositoryImpl>()));
    Get.lazyPut(() => InformationController(Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find()));
  }
}
