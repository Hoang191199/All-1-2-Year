import 'package:get/get.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/infomation/infomation_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/splash/splash_controller.dart';

import '../api_endpoint.dart';
import '../api_provider.dart';
import '../api_request_representable.dart';

enum InformationType { fetch, menu, schedule, showGroup, like, comment, postDetail}

class InformationApi implements APIRequestRepresentable {
  final InformationType type;

  InformationApi._({
    required this.type,
    this.idPost,
    this.action,
    this.message,
    this.page
  });

  String? idPost;
  String? action;
  String? message;
  String? page;

  InformationApi.fetchData() : this._(type: InformationType.fetch);
  InformationApi.getMenu() : this._(type: InformationType.menu);
  InformationApi.getSchedule() : this._(type: InformationType.schedule);
  InformationApi.newPost() : this._(type: InformationType.showGroup);
  InformationApi.actionLike(String action,String idPost) : this._(type: InformationType.like, action : action, idPost: idPost);
  InformationApi.actionComment(String message,String idPost) : this._(type: InformationType.comment, message : message, idPost: idPost);
  InformationApi.getPostDetail(String page, String idPost) : this._(type: InformationType.postDetail, page : page, idPost: idPost);
  
  final store = Get.find<LocalStorageService>();
  final splashController = Get.find<SplashScreenController>();
  final informationController = Get.find<InformationController>();

  @override
  FormData get form {
    switch (type) {
      case InformationType.fetch:
        return FormData({
          "user_id": store.userFromStorage?.user_id,
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "pageInfo",
          "child_id": splashController.childId.value,
          "date": convertDateTimeToString(informationController.dateNow),
          "date_end": convertDateTimeToString(informationController.endOfWeek),
          "date_begin": convertDateTimeToString(informationController.startOfWeek),
        });

      case InformationType.menu:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "view": "this_week",
          "child_id": splashController.childId.value,
        });
      
      case InformationType.schedule:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "view": "this_week",
          "child_id": splashController.childId.value,
        });

      case InformationType.showGroup:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "username": splashController.groupName.value,
          "page": '0',
          "view": "allDayTeacher",
          "date_post": convertDateTimeToString(informationController.dateNow)
        });
      
      case InformationType.like:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": action,
          "id": idPost,
        });

      case InformationType.comment:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "handle": 'post',
          "id": idPost,
          'message': message
        });

      case InformationType.postDetail:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "post_id": idPost,
          'page': page
        });
    }
  }

  @override
  String get endpoint => APIEndpoint.endpoint;

  @override
  String get path {
    switch (type) {
      case InformationType.fetch:
        return "/manageChildBasicInformation";
      case InformationType.menu:
        return "/manageMenu";
      case InformationType.schedule:
        return "/manageSchedule";
      case InformationType.showGroup:
        return "/showGroup";
      case InformationType.like:
        return "/postAction";
      case InformationType.comment:
        return "/createComment";
      case InformationType.postDetail:
        return "/getPost";
    }
  }

  @override
  String get url => endpoint + path;

  @override
  HTTPMethod get method {
    return HTTPMethod.post;
  }

  @override
  Map<String, String> get headers => {};

  @override
  get query => null;

  @override
  get body => form;

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }
}
