import 'package:get/get.dart';
import 'package:mobiedu_kids/data/repositories/album_repository_impl.dart';
import 'package:mobiedu_kids/domain/usecases/album_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/album/album_controller.dart';

class AlbumBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AlbumRepositoryImpl());
    Get.lazyPut(() => GetAlbumUseCase(Get.find<AlbumRepositoryImpl>()));
    Get.lazyPut(() => DetailAlbumUseCase(Get.find<AlbumRepositoryImpl>()));
    Get.lazyPut(() => AddAlbumUseCase(Get.find<AlbumRepositoryImpl>()));
    Get.lazyPut(() => AddPhotoUseCase(Get.find<AlbumRepositoryImpl>()));
    Get.lazyPut(() => EditCaptionUseCase(Get.find<AlbumRepositoryImpl>()));
    Get.lazyPut(() => DeletePhotoUseCase(Get.find<AlbumRepositoryImpl>()));
    Get.lazyPut(() => DeleteAlbumUseCase(Get.find<AlbumRepositoryImpl>()));
    Get.lazyPut(() => GetAlbumChildUseCase(Get.find<AlbumRepositoryImpl>()));
    Get.lazyPut(() => DetailAlbumChildUseCase(Get.find<AlbumRepositoryImpl>()));
    Get.lazyPut(() => AddAlbumChildUseCase(Get.find<AlbumRepositoryImpl>()));
    Get.lazyPut(() => AddPhotoChildUseCase(Get.find<AlbumRepositoryImpl>()));
    Get.lazyPut(() => EditCaptionChildUseCase(Get.find<AlbumRepositoryImpl>()));
    Get.lazyPut(() => DeletePhotoChildUseCase(Get.find<AlbumRepositoryImpl>()));
    Get.lazyPut(() => DeleteAlbumChildUseCase(Get.find<AlbumRepositoryImpl>()));
    Get.lazyPut(() => AlbumController(
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
          Get.find(),
          Get.find(),
          Get.find(),
        ));
  }
}
