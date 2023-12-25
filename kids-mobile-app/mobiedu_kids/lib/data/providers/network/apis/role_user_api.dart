import 'package:get/get.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';

import '../api_endpoint.dart';
import '../api_provider.dart';
import '../api_request_representable.dart';

class RoleUserApi implements APIRequestRepresentable {
  RoleUserApi.fetchData();
  final store = Get.find<LocalStorageService>();

  @override
  FormData get form => FormData({
    "user_id": store.userFromStorage?.user_id,
    "user_token": "${store.userFromStorage?.user_token}",
  });

  @override
  String get endpoint => APIEndpoint.endpoint;

  @override
  String get path {
    return "/manageHome";
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
