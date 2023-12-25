import 'package:get/get.dart';
import 'package:qltv/data/repositories/bookcase_repository_impl.dart';
import 'package:qltv/domain/usecases/highlight_add_use_case.dart';
import 'package:qltv/domain/usecases/highlight_delete_use_case.dart';
import 'package:qltv/domain/usecases/highlight_list_use_case.dart';
import 'package:qltv/domain/usecases/highlight_update_use_case.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_highlight_controller.dart';

class EpubHighlightBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookcaseRepositoryImpl());
    Get.lazyPut(() => HighlightListUseCase(Get.find<BookcaseRepositoryImpl>()));
    Get.lazyPut(() => HighlightAddUseCase(Get.find<BookcaseRepositoryImpl>()));
    Get.lazyPut(() => HighlightUpdateUseCase(Get.find<BookcaseRepositoryImpl>()));
    Get.lazyPut(() => HighlightDeleteUseCase(Get.find<BookcaseRepositoryImpl>()));
    Get.lazyPut(() => EpubHighlightController(Get.find(), Get.find(), Get.find(), Get.find()));
  }
}
