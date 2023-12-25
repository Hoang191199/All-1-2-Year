import 'package:get/get.dart';

import 'package:mooc_app/app/services/local_storage.dart';
import 'package:mooc_app/data/repositories/auth_repository_Impl.dart';
import 'package:mooc_app/data/repositories/course_repository_impl.dart';
import 'package:mooc_app/data/repositories/home_repository_impl.dart';
import 'package:mooc_app/presentation/controllers/notifications/connect_noti_binding.dart';

class DependencyCreator {
  static init() {
    Get.lazyPut(() => AuthenticationRepositoryImpl());
    // Get.lazyPut(() => CourseRepositoryIml());
    Get.lazyPut(() => HomeRepositoryImpl());
    ConnectNotiBinding().dependencies();
  }

  static initServices() async {
    print('starting services ...');
    await Get.putAsync(() => LocalStorageService().init());
    print('All services started...');
  }
}
