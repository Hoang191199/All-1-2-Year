import 'package:dartz/dartz.dart';
import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/data_photo_album_video.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/repositories/social_repository.dart';

class GetAlbumSocialUseCase extends ParamUseCase<ResponseDataObject<DataPhotoAlbumVideo>, Tuple4<String, String, String, int>> {
  GetAlbumSocialUseCase(this.socialRepository);

  final SocialRepository socialRepository;

  @override
  Future<ResponseDataObject<DataPhotoAlbumVideo>> execute(Tuple4 params) {
    return socialRepository.getAlbum(params.value1, params.value2, params.value3, params.value4);
  }
}