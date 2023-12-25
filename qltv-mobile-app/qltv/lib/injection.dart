import 'package:get/get.dart';
import 'package:qltv/app/services/local_storage.dart';

class DependencyCreator {
  static init() {
    // Get.lazyPut(() => HomeRepositoryImpl());
  }

  static initServices() async {
    await Get.putAsync(() => LocalStorageService().init());
  }
}
