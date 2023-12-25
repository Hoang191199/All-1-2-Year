import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/data_search_news_feed.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/repositories/news_feed_repository.dart';

class NewsFeedSearchUseCase extends ParamUseCase<ResponseDataObject<DataSearchNewsFeed>, String> {
  NewsFeedSearchUseCase(this.newsFeedRepository);

  final NewsFeedRepository newsFeedRepository;

  @override
  Future<ResponseDataObject<DataSearchNewsFeed>> execute(String params) {
    return newsFeedRepository.search(params);
  }
}