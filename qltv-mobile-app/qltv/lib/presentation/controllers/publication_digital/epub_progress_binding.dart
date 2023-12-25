import 'package:get/get.dart';
import 'package:qltv/data/repositories/bookcase_repository_impl.dart';
import 'package:qltv/domain/usecases/bookcase_progress_use_case.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_progress_controller.dart';

class EpubProgressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookcaseRepositoryImpl());
    Get.lazyPut(() => BookcaseProgressUseCase(Get.find<BookcaseRepositoryImpl>()));
    Get.lazyPut(() => EpubProgressController(Get.find()));
  }
}
