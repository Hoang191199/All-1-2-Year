import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/data_response.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/repositories/social_repository.dart';

class CreatePostUseCase extends ParamUseCase<ResponseDataObject<DataResponse>, Tuple7<String, String, String, String, List<Uint8List>?, String?, String?>> {
  CreatePostUseCase(this.socialRepository);

  final SocialRepository socialRepository;

  @override
  Future<ResponseDataObject<DataResponse>> execute(Tuple7 params) {
    return socialRepository.createPost(params.value1, params.value2, params.value3, params.value4, params.value5, params.value6, params.value7);
  }
}