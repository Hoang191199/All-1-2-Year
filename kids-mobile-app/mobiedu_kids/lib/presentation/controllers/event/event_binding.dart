import 'package:get/get.dart';
import 'package:mobiedu_kids/data/repositories/event_repository_impl.dart';
import 'package:mobiedu_kids/domain/usecases/event_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/event/event_controller.dart';

class EventBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EventRepositoryImpl());
    Get.lazyPut(() => GetEventUseCase(Get.find<EventRepositoryImpl>()));
    Get.lazyPut(() => GetChildEventUseCase(Get.find<EventRepositoryImpl>()));
    Get.lazyPut(() => DetailEventUseCase(Get.find<EventRepositoryImpl>()));
    Get.lazyPut(() => GetSchoolEventUseCase(Get.find<EventRepositoryImpl>()));
    Get.lazyPut(
        () => DetailSchoolEventUseCase(Get.find<EventRepositoryImpl>()));
    Get.lazyPut(
        () => CreateSchoolEventUseCase(Get.find<EventRepositoryImpl>()));
    Get.lazyPut(() => EditSchoolEventUseCase(Get.find<EventRepositoryImpl>()));
    Get.lazyPut(
        () => DeleteSchoolEventUseCase(Get.find<EventRepositoryImpl>()));
    Get.lazyPut(() => FetchRegisterUseCase(Get.find<EventRepositoryImpl>()));
    Get.lazyPut(() => SaveRegisterUseCase(Get.find<EventRepositoryImpl>()));
    Get.lazyPut(
        () => SaveChildRegisterUseCase(Get.find<EventRepositoryImpl>()));
    Get.lazyPut(() => EventController(
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
        ));
  }
}
