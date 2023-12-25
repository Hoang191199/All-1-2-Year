import 'package:get/get.dart';
import 'package:mobiedu_kids/data/repositories/news_feed_repository_impl.dart';
import 'package:mobiedu_kids/data/repositories/social_repository_impl.dart';
import 'package:mobiedu_kids/domain/usecases/news_feed/create_comment_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/news_feed/get_post_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/news_feed/show_page_group_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/social/create_post_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/social/edit_post_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/social/friend_connect_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/social/group_connect_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/social/post_action_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/social/report_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_group_controller.dart';

class ShowGroupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewsFeedRepositoryImpl());
    Get.lazyPut(() => SocialRepositoryImpl());
    Get.lazyPut(() => ShowPageGroupUseCase(Get.find<NewsFeedRepositoryImpl>()));
    Get.lazyPut(() => ReportUseCase(Get.find<SocialRepositoryImpl>()));
    Get.lazyPut(() => PostActionUseCase(Get.find<SocialRepositoryImpl>()));
    Get.lazyPut(() => CreateCommentUseCase(Get.find<NewsFeedRepositoryImpl>()));
    Get.lazyPut(() => GetPostUseCase(Get.find<NewsFeedRepositoryImpl>()));
    Get.lazyPut(() => FriendConnectUseCase(Get.find<SocialRepositoryImpl>()));
    Get.lazyPut(() => EditPostUseCase(Get.find<SocialRepositoryImpl>()));
    Get.lazyPut(() => CreatePostUseCase(Get.find<SocialRepositoryImpl>()));
    Get.lazyPut(() => GroupConnectUseCase(Get.find<SocialRepositoryImpl>()));
    Get.lazyPut(() => ShowGroupController(Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find()));
  }
}