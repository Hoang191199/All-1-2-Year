import 'package:get/get.dart';
import 'package:mobiedu_kids/data/repositories/feedback_repository_impl.dart';
import 'package:mobiedu_kids/domain/usecases/feedback_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/feedback/feedback_controller.dart';

class FeedbackBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FbRepositoryImpl());
    Get.lazyPut(() => FbCreateUseCase(Get.find<FbRepositoryImpl>()));
    Get.lazyPut(() => FeedbackController(Get.find()));
  }
}
