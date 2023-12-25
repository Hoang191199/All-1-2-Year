import 'package:dartz/dartz.dart';
import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';
import 'package:mobiedu_kids/domain/repositories/social_repository.dart';

class FriendConnectUseCase extends ParamUseCase<ResponseNoData, Tuple2<String, String>> {
  FriendConnectUseCase(this.socialRepository);

  final SocialRepository socialRepository;

  @override
  Future<ResponseNoData> execute(Tuple2 params) {
    return socialRepository.friendsConnect(params.value1, params.value2);
  }
}