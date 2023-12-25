import 'package:dartz/dartz.dart';
import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/content_media.dart';
import 'package:mobiedu_kids/domain/entities/media_categories.dart';
import 'package:mobiedu_kids/domain/entities/media_info_details.dart';
import 'package:mobiedu_kids/domain/entities/media_posts.dart';
import 'package:mobiedu_kids/domain/entities/media_sub1.dart';
import 'package:mobiedu_kids/domain/entities/media_sub2.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/repositories/media_repository.dart';

class MediaSupportUseCase extends ParamUseCase<
    ResponseDataObject<MediaCategories<MediaSub1<MediaSub2<MediaInfoDetails>>>>,
    String> {
  MediaSupportUseCase(this.mediaRepository);

  final MediaRepository mediaRepository;

  @override
  Future<
      ResponseDataObject<
          MediaCategories<MediaSub1<MediaSub2<MediaInfoDetails>>>>> execute(
      params) {
    return mediaRepository.support(params);
  }
}

class MediaComicUseCase extends ParamUseCase<
    ResponseDataObject<MediaCategories<MediaSub1<MediaInfoDetails>>>, String> {
  MediaComicUseCase(this.mediaRepository);

  final MediaRepository mediaRepository;

  @override
  Future<ResponseDataObject<MediaCategories<MediaSub1<MediaInfoDetails>>>>
      execute(params) {
    return mediaRepository.comic(params);
  }
}

class MediaVideoUseCase extends ParamUseCase<ResponseDataObject<MediaPosts>,
    Tuple3<String, String, int>> {
  MediaVideoUseCase(this.mediaRepository);

  final MediaRepository mediaRepository;

  @override
  Future<ResponseDataObject<MediaPosts>> execute(Tuple3 params) {
    return mediaRepository.video(params.value1, params.value2, params.value3);
  }
}

class DetailMediaUseCase extends ParamUseCase<ContentMedia, String> {
  DetailMediaUseCase(this.mediaRepository);

  final MediaRepository mediaRepository;

  @override
  Future<ContentMedia> execute(params) {
    return mediaRepository.detail(params);
  }
}
