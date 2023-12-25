import 'package:dartz/dartz.dart';
import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/data_show_page_group.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/repositories/news_feed_repository.dart';

class ShowPageGroupUseCase extends ParamUseCase<ResponseDataObject<DataShowPageGroup>, Tuple4<String, String, int?, String>> {
  ShowPageGroupUseCase(this.newsFeedRepository);

  final NewsFeedRepository newsFeedRepository;

  @override
  Future<ResponseDataObject<DataShowPageGroup>> execute(Tuple4 params) {
    if (params.value1 == 'page') {
      return newsFeedRepository.showPage(params.value2, params.value3, params.value4);
    } else {
      return newsFeedRepository.showGroup(params.value2, params.value3, params.value4);
    }
  }
}