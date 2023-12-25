import 'package:dartz/dartz.dart';
import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/response_post.dart';
import 'package:mobiedu_kids/domain/repositories/news_feed_repository.dart';

class GetPostUseCase extends ParamUseCase<ResponsePost, Tuple2<String, int>> {
  GetPostUseCase(this.newsFeedRepository);

  final NewsFeedRepository newsFeedRepository;

  @override
  Future<ResponsePost> execute(Tuple2 params) {
    return newsFeedRepository.getPost(params.value1, params.value2);
  }
}