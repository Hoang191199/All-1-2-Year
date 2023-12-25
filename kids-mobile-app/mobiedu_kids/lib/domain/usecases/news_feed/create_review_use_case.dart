import 'package:dartz/dartz.dart';
import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';
import 'package:mobiedu_kids/domain/repositories/news_feed_repository.dart';

class CreateReviewUseCase extends ParamUseCase<ResponseNoData, Tuple4<String, String, int, String>> {
  CreateReviewUseCase(this.newsFeedRepository);

  final NewsFeedRepository newsFeedRepository;

  @override
  Future<ResponseNoData> execute(Tuple4 params) {
    return newsFeedRepository.createReview(params.value1, params.value2, params.value3, params.value4);
  }
}