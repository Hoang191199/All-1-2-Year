import 'package:get/get.dart';
import 'package:mooc_app/data/repositories/list_noti_mooc_repository_impl.dart';
import 'package:mooc_app/domain/usecases/list_noti_mooc_use_case.dart';
import 'package:mooc_app/presentation/controllers/notifications/read_controller.dart';

import '../../../data/repositories/detail_noti_repository_impl.dart';
import '../../../data/repositories/read_repository_impl.dart';
import '../../../domain/usecases/detail_noti_use_case.dart';
import '../../../domain/usecases/list_unread_use_case.dart';
import '../../../domain/usecases/read_all_use_case.dart';
import 'detail_noti_controller.dart';
import 'list_noti_controller.dart';

class NotiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ListNotiMoocRepositoryImpl());
    Get.lazyPut(() => DetailNotiRepositoryImpl());
    Get.lazyPut(() => ReadRepositoryImpl());
    Get.lazyPut(
        () => ListNotiMoocUseCase(Get.find<ListNotiMoocRepositoryImpl>()));
    Get.lazyPut(() => DetailNotiUseCase(Get.find<DetailNotiRepositoryImpl>()));
    Get.lazyPut(() => ReadAllUseCase(Get.find<ReadRepositoryImpl>()));
    Get.lazyPut(() => UnreadUseCase(Get.find<ReadRepositoryImpl>()));
    Get.lazyPut(() => ListNotiController(Get.find()));
    Get.lazyPut(() => DetailNotiController(Get.find()));
    Get.lazyPut(() => ReadController(Get.find(),Get.find()));
  }
}
