import 'package:get/get.dart';
import 'package:mobiedu_kids/data/repositories/social_repository_impl.dart';
import 'package:mobiedu_kids/domain/usecases/news_feed/get_album_social_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/news_feed/get_all_photo_albums_video_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/photo_video_controller.dart';

class PhotoVideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SocialRepositoryImpl());
    Get.lazyPut(() => GetAllPhotoAlbumsVideoUseCase(Get.find<SocialRepositoryImpl>()));
    Get.lazyPut(() => GetAlbumSocialUseCase(Get.find<SocialRepositoryImpl>()));
    Get.lazyPut(() => PhotoVideoController(Get.find(), Get.find()));
  }
}