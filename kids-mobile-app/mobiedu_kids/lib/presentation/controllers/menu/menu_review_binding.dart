import 'package:get/get.dart';
import 'package:mobiedu_kids/data/repositories/review_repository_impl.dart';
import 'package:mobiedu_kids/domain/usecases/review_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/menu/menu_review_controller.dart';

class MenuReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReviewRepositoryImpl());
    Get.lazyPut(() => MenuReviewUseCase(Get.find<ReviewRepositoryImpl>()));
    Get.lazyPut(() => MenuFetchReviewUseCase(Get.find<ReviewRepositoryImpl>()));
    Get.lazyPut(() => MenuReviewController(Get.find(), Get.find()));
  }
}
