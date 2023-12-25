import 'package:get/get.dart';
import 'package:mooc_app/data/repositories/connect_noti_repository_impl.dart';
import 'package:mooc_app/domain/usecases/connect_noti_usecase.dart';
import 'package:mooc_app/presentation/controllers/notifications/connect_noti_controller.dart';


class ConnectNotiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ConnectNotiRepositoryImpl());
    Get.lazyPut(() => ConnectNotiUseCase(Get.find<ConnectNotiRepositoryImpl>()));
    Get.lazyPut(() => ConnectNotiController(Get.find()));
  }
}
