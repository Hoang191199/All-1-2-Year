import 'package:get/get.dart';
import 'package:mooc_app/data/repositories/search_repository_impl.dart';
import 'package:mooc_app/domain/usecases/search_use_case.dart';
import 'package:mooc_app/presentation/controllers/search_api_controller/search_controller.dart';

class SearchFetchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchRepositoryImpl());
    Get.lazyPut(() => SearchUseCase(Get.find<SearchRepositoryImpl>()));
    Get.lazyPut(() => SearchFetchController(Get.find()));
  }
}
