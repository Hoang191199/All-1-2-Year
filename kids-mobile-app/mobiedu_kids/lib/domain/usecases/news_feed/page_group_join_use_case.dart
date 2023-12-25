import 'package:mobiedu_kids/app/usecases/no_param_usecase.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/page_group.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/repositories/news_feed_repository.dart';

class PageGroupJoinUseCase extends NoParamUseCase<ResponseDataObject<PageGroup>> {
  PageGroupJoinUseCase(this.newsFeedRepository);

  final NewsFeedRepository newsFeedRepository;

  @override
  Future<ResponseDataObject<PageGroup>> execute() {
    return newsFeedRepository.getPageGroupJoined();
  }
}