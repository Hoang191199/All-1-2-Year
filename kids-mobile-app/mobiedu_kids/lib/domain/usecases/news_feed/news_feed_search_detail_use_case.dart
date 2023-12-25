import 'package:dartz/dartz.dart';
import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/data_search_news_feed.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/repositories/news_feed_repository.dart';

class NewsFeedSearchDetailUseCase extends ParamUseCase<ResponseDataObject<DataSearchNewsFeed>, Tuple4<String, String, int, String?>> {
  NewsFeedSearchDetailUseCase(this.newsFeedRepository);

  final NewsFeedRepository newsFeedRepository;

  @override
  Future<ResponseDataObject<DataSearchNewsFeed>> execute(Tuple4 params) {
    return newsFeedRepository.searchDetail(params.value1, params.value2, params.value3, params.value4);
  }
}