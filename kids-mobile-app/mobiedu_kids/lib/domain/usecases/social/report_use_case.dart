import 'package:dartz/dartz.dart';
import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';
import 'package:mobiedu_kids/domain/repositories/social_repository.dart';

class ReportUseCase extends ParamUseCase<ResponseNoData, Tuple2<String, int>> {
  ReportUseCase(this.socialRepository);

  final SocialRepository socialRepository;

  @override
  Future<ResponseNoData> execute(Tuple2 params) {
    return socialRepository.report(params.value1, params.value2);
  }
}