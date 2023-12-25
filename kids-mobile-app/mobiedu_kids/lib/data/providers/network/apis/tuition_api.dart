import 'package:get/get.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/splash/splash_controller.dart';

import '../api_endpoint.dart';
import '../api_provider.dart';
import '../api_request_representable.dart';

enum TuitionsType { tuitions, detail, item, tuitionsParent, detailTuitionsParent }

class TuitionsApi implements APIRequestRepresentable {
  final TuitionsType type;
  int? tuitions_id;
  int? tuition_child_id;
  int? page;

  TuitionsApi._({required this.type, this.tuitions_id, this.tuition_child_id, this.page});

  TuitionsApi.fetchData(int page) : this._(page: page, type: TuitionsType.tuitions);

  TuitionsApi.detail(int tuitions_id)
      : this._(tuitions_id: tuitions_id, type: TuitionsType.detail);

  TuitionsApi.itemTuitions(int tuition_child_id)
      : this._(tuition_child_id: tuition_child_id, type: TuitionsType.item);

  TuitionsApi.tuitionParent(int page) : this._(page: page, type: TuitionsType.tuitionsParent);

  TuitionsApi.detailTuitionParent(int tuition_child_id) : this._(tuition_child_id: tuition_child_id , type: TuitionsType.detailTuitionsParent);

  final store = Get.find<LocalStorageService>();
  final spashControlller = Get.find<SplashScreenController>();

  @override
  FormData get form {
    switch (type) {
      case TuitionsType.tuitions:
        return FormData({
          "user_id": store.userFromStorage?.user_id,
          "user_token": "${store.userFromStorage?.user_token}",
          "group_name": store.getGroupname,
          "view": "list",
          "page": page,
        });
      case TuitionsType.detail:
        return FormData({
          "user_id": store.userFromStorage?.user_id,
          "user_token": "${store.userFromStorage?.user_token}",
          "group_name": store.getGroupname,
          "view": "detail_class",
          "tuition_id": tuitions_id,
        });
      case TuitionsType.item:
        return FormData({
          "user_id": store.userFromStorage?.user_id,
          "user_token": "${store.userFromStorage?.user_token}",
          "group_name": store.getGroupname,
          "view": "detail_child",
          "tuition_child_id": tuition_child_id,
        });
      case TuitionsType.tuitionsParent:
        return FormData({
          "user_id": store.userFromStorage?.user_id,
          "user_token": "${store.userFromStorage?.user_token}",
          "child_id": spashControlller.childId,
          "page": 0,
        });
      case TuitionsType.detailTuitionsParent:
        return FormData({
          "user_id": store.userFromStorage?.user_id,
          "user_token": "${store.userFromStorage?.user_token}",
          "child_id": spashControlller.childId,
          "view": "detail",
          "tuition_child_id": tuition_child_id,
        });
    }
  }

  @override
  String get endpoint => APIEndpoint.endpoint;

  @override
  String get path {
    switch (type) {
      case TuitionsType.tuitions:
      case TuitionsType.item:
      case TuitionsType.detail:
        return "/manageClassTuitionShow";
      case TuitionsType.tuitionsParent:
      case TuitionsType.detailTuitionsParent:
        return "/manageChildTuitionShow";
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
