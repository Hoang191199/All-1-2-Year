import 'package:dartz/dartz.dart';
import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';
import 'package:mobiedu_kids/domain/repositories/social_repository.dart';

class EditPostUseCase extends ParamUseCase<ResponseNoData, Tuple3<String, String, String>> {
  EditPostUseCase(this.socialRepository);

  final SocialRepository socialRepository;

  @override
  Future<ResponseNoData> execute(Tuple3 params) {
    return socialRepository.editPost(params.value1, params.value2, params.value3);
  }
}