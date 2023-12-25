import 'package:get/get.dart';
import 'package:mooc_app/data/repositories/category_repository_impl.dart';
import 'package:mooc_app/domain/usecases/category_use_case.dart';
import 'package:mooc_app/presentation/controllers/category/category_controller.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryRepositoryImpl());
    Get.lazyPut(() => CategoryUseCase(Get.find<CategoryRepositoryImpl>()));
    Get.lazyPut(() => CategoryController(Get.find()));
  }

}