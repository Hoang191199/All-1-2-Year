import 'package:dartz/dartz.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/data_photo_album_video.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/repositories/social_repository.dart';

class GetAllPhotoAlbumsVideoUseCase extends ParamUseCase<ResponseDataObject<DataPhotoAlbumVideo>, Tuple4<String, String, String, int>> {
  GetAllPhotoAlbumsVideoUseCase(this.socialRepository);

  final SocialRepository socialRepository;

  @override
  Future<ResponseDataObject<DataPhotoAlbumVideo>> execute(Tuple4 params) {
    if (params.value1 == PhotoType.photo) {
      return socialRepository.getAllPhoto(params.value2, params.value3, params.value4);
    } else if (params.value1 == PhotoType.album) {
      return socialRepository.getAlbums(params.value2, params.value3, params.value4);
    } else {
      return socialRepository.getAllVideo(params.value2, params.value3, params.value4);
    }
  }
}