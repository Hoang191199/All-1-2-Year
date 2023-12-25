import 'package:get/get.dart';
import 'package:qltv/data/repositories/search_repository_impl.dart';
import 'package:qltv/domain/usecases/add_to_bookcase_use_case.dart';
import 'package:qltv/domain/usecases/interactives_use_case.dart';
import 'package:qltv/domain/usecases/register_publication.dart';
import 'package:qltv/domain/usecases/search_user_case.dart';
import 'package:qltv/presentation/controllers/search/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchRepositoryImpl());
    Get.lazyPut(() => SearchUseCase(Get.find<SearchRepositoryImpl>()));
    Get.lazyPut(() => AddToBookCaseUseCase(Get.find<SearchRepositoryImpl>()));
    Get.lazyPut(() => RegisterPublicationUseCase(Get.find<SearchRepositoryImpl>()));
    Get.lazyPut(() => InteractivesUseCase(Get.find<SearchRepositoryImpl>()));
    Get.lazyPut(() => SearchController(Get.find(), Get.find(), Get.find(), Get.find()));
  }
}
