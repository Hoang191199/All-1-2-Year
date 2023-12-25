import 'package:get/get.dart';
import 'package:mobiedu_kids/data/repositories/review_repository_impl.dart';
import 'package:mobiedu_kids/domain/usecases/review_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/schedule/schedule_review_controller.dart';

class ScheduleReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReviewRepositoryImpl());
    Get.lazyPut(() => ScheduleReviewUseCase(Get.find<ReviewRepositoryImpl>()));
    Get.lazyPut(
        () => ScheduleFetchReviewUseCase(Get.find<ReviewRepositoryImpl>()));
    Get.lazyPut(() => ScheduleReviewController(Get.find(), Get.find()));
  }
}
