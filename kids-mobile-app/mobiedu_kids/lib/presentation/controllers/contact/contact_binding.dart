import 'package:get/get.dart';
import 'package:mobiedu_kids/data/repositories/contact_repository_impl.dart';
import 'package:mobiedu_kids/domain/usecases/contact_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/contact/contact_controller.dart';

class ContactBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContactRepositoryImpl());
    Get.lazyPut(() => ContactUseCase(Get.find<ContactRepositoryImpl>()));
    Get.lazyPut(() => ContactController(Get.find()));
  }
}
