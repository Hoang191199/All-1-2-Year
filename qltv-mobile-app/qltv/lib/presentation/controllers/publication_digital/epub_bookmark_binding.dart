import 'package:get/get.dart';
import 'package:qltv/data/repositories/bookcase_repository_impl.dart';
import 'package:qltv/domain/usecases/bookmark_add_use_case.dart';
import 'package:qltv/domain/usecases/bookmark_delete_use_case.dart';
import 'package:qltv/domain/usecases/bookmark_list_use_case.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_bookmark_controller.dart';

class EpubBookmarkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookcaseRepositoryImpl());
    Get.lazyPut(() => BookmarkListUseCase(Get.find<BookcaseRepositoryImpl>()));
    Get.lazyPut(() => BookmarkAddUseCase(Get.find<BookcaseRepositoryImpl>()));
    Get.lazyPut(() => BookmarkDeleteUseCase(Get.find<BookcaseRepositoryImpl>()));
    Get.lazyPut(() => EpubBookmarkController(Get.find(), Get.find(), Get.find()));
  }
}
