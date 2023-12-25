import 'package:get/get.dart';
import 'package:mooc_app/domain/usecases/blog_detail_use_case.dart';

import '../../../data/repositories/blog_repository_impl.dart';
import '../../../domain/usecases/blog_use_case.dart';
import 'blog_controller.dart';
import 'blog_detail_controller.dart';

class BlogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BlogRepositoryImpl());
    Get.lazyPut(() => BlogDetailUseCase(Get.find<BlogRepositoryImpl>()));
    Get.lazyPut(() => BlogUseCase(Get.find<BlogRepositoryImpl>()));
    Get.lazyPut(() => BlogController(Get.find()));
    Get.lazyPut(() => BlogDetailController(Get.find()));
  }
}