import 'package:get/get.dart';
import 'package:mobiedu_kids/data/repositories/news_feed_repository_impl.dart';
import 'package:mobiedu_kids/domain/usecases/news_feed/news_feed_search_detail_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/news_feed/news_feed_search_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/news_feed_search_controller.dart';

class NewsFeedSearchBinding extends Bindings {
  
  @override
  void dependencies() {
    Get.lazyPut(() => NewsFeedRepositoryImpl());
    Get.lazyPut(() => NewsFeedSearchUseCase(Get.find<NewsFeedRepositoryImpl>()));
    Get.lazyPut(() => NewsFeedSearchDetailUseCase(Get.find<NewsFeedRepositoryImpl>()));
    Get.lazyPut(() => NewsFeedSearchController(Get.find(), Get.find()));
  }
}