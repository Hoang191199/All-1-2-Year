import 'package:dartz/dartz.dart';
import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/data_home_page.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/repositories/news_feed_repository.dart';

class HomePageUseCase extends ParamUseCase<ResponseDataObject<DataHomePage>, Tuple3<String, int?, String>> {
  HomePageUseCase(this.newsFeedRepository);

  final NewsFeedRepository newsFeedRepository;

  @override
  Future<ResponseDataObject<DataHomePage>> execute(Tuple3 params) {
    return newsFeedRepository.homePage(params.value1, params.value2, params.value3);
  }
}