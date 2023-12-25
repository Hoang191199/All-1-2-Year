import 'package:get/get.dart';
import 'package:mooc_app/data/repositories/s3_repository_impl.dart';
import 'package:mooc_app/domain/usecases/put_file_s3_use_case.dart';
import 'package:mooc_app/domain/usecases/s3_insert_use_case.dart';
import 'package:mooc_app/domain/usecases/s3_url_use_case.dart';
import 'package:mooc_app/presentation/controllers/s3/s3_controller.dart';

class S3Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => S3RepositoryImpl());
    Get.lazyPut(() => S3UrlUseCase(Get.find<S3RepositoryImpl>()));
    Get.lazyPut(() => S3InsertUseCase(Get.find<S3RepositoryImpl>()));
    Get.lazyPut(() => S3PutUseCase(Get.find<S3RepositoryImpl>()));
    Get.lazyPut(() => S3Controller(Get.find(), Get.find(), Get.find()));
    // Get.lazyPut(() => S3Controller(Get.find(), Get.find()));
  }
}
