import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/data_news_feed.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/repositories/news_feed_repository.dart';

class NewsFeedUseCase extends ParamUseCase<ResponseDataObject<DataNewsFeed>, int> {
  NewsFeedUseCase(this.newsFeedRepository);

  final NewsFeedRepository newsFeedRepository;

  @override
  Future<ResponseDataObject<DataNewsFeed>> execute(int params) {
    return newsFeedRepository.getNewsFeed(params);
  }
}