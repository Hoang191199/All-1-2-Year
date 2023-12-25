import 'package:get/get.dart';
import 'package:mooc_app/presentation/controllers/search_api_controller/search_controller.dart';

import '../../../data/repositories/search_recommend_repository_impl.dart';
import '../../../domain/usecases/search_recommmend_use_case.dart';

class RecommendBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchRCMRepositoryImpl());
    Get.lazyPut(() => SearchRCMUseCase(Get.find<SearchRCMRepositoryImpl>()));
    Get.lazyPut(() => SearchFetchController(Get.find()));
  }
}
