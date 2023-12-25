import 'package:get/get.dart';
import 'package:qltv/data/repositories/s3_repository_impl.dart';
import 'package:qltv/domain/usecases/s3_get_url_use_case.dart';
import 'package:qltv/domain/usecases/s3_sign_url_use_case.dart';
import 'package:qltv/presentation/controllers/s3/s3_controller.dart';

class S3Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => S3RepositoryImpl());
    Get.lazyPut(() => S3GetUrlUseCase(Get.find<S3RepositoryImpl>()));
    Get.lazyPut(() => S3SignUrlUseCase(Get.find<S3RepositoryImpl>()));
    Get.lazyPut(() => S3Controller(Get.find(), Get.find()));
  }
}
