import 'package:get/get.dart';
import 'package:mobiedu_kids/data/repositories/review_repository_impl.dart';
import 'package:mobiedu_kids/domain/usecases/review_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/remark/remark_controller.dart';

class RemarkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReviewRepositoryImpl());
    Get.lazyPut(() => DailyFetchUseCase(Get.find<ReviewRepositoryImpl>()));
    Get.lazyPut(() => DailyReviewUseCase(Get.find<ReviewRepositoryImpl>()));
    Get.lazyPut(() => MonthlyFetchUseCase(Get.find<ReviewRepositoryImpl>()));
    Get.lazyPut(() => MonthlyReviewUseCase(Get.find<ReviewRepositoryImpl>()));
    Get.lazyPut(() => UploadUseCase(Get.find<ReviewRepositoryImpl>()));
    Get.lazyPut(() => FetchTemplateUseCase(Get.find<ReviewRepositoryImpl>()));
    Get.lazyPut(() => RemarkController(Get.find(), Get.find(), Get.find(),
        Get.find(), Get.find(), Get.find()));
  }
}
