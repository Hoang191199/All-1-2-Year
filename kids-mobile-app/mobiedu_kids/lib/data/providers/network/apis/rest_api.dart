import 'package:get/get.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/rest/rest_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/splash/splash_controller.dart';

import '../api_endpoint.dart';
import '../api_provider.dart';
import '../api_request_representable.dart';

enum RestType { fetch, resign }

class RestAPI implements APIRequestRepresentable {
  final RestType type;

  RestAPI._({
    required this.type, 
    this.fromDate, 
    this.toDate,
  });

  String? fromDate;
  String? toDate;

  RestAPI.fetchData(fromDate, toDate) : this._(
    type: RestType.fetch,
    fromDate: fromDate,
    toDate: toDate
  );

  RestAPI.register() : this._(
    type: RestType.resign,
  );

  final store = Get.find<LocalStorageService>();
  final splashController = Get.find<SplashScreenController>();
  final restController = Get.find<RestController>();


  @override
  FormData get form {
    switch (type) {
      case RestType.fetch:
        return FormData({
          "user_id": store.userFromStorage?.user_id,
          "user_token": "${store.userFromStorage?.user_token}",
          "child_id": splashController.childId.value,
          "do": "attendance",
          "fromDate": fromDate,
          "toDate": toDate,
        });
      case RestType.resign:
      return FormData({
          "user_id": store.userFromStorage?.user_id,
          "user_token": "${store.userFromStorage?.user_token}",
          "child_id": splashController.childId.value,
          "do": "resign",
          "start_date": convertDateTimeToString(restController.firstDate),
          "end_date": convertDateTimeToString(restController.lastDate),
          "reason": restController.note.text
      });
    }
  }

  @override
  String get endpoint => APIEndpoint.endpoint;

  @override
  String get path {
    return "/manageChildAttendance";
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
