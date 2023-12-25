import 'package:get/get.dart';
import 'package:mooc_app/data/providers/network/api_endpoint.dart';
import 'package:mooc_app/data/providers/network/api_provider.dart';
import 'package:mooc_app/data/providers/network/api_request_representable.dart';

import '../../../../app/services/local_storage.dart';
class LoginHistoryAPI implements APIRequestRepresentable {
  final store = Get.find<LocalStorageService>();
  int page;
  LoginHistoryAPI._({required this.page});
  LoginHistoryAPI.fetchLoginfo(int page)
      : this._(
    page: page,
  );

  @override
  String get endpoint => APIEndpoint.endpointTestMooc;

  @override
  String get path => "/userlog/log/loginlog";

  @override
  String get url => endpoint + path;

  @override
  HTTPMethod get method {
    return HTTPMethod.get;
  }

  @override
  Map<String, String> get headers => { "Authorization" : "Bearer ${store.tokenFromStorage}" };

  @override
  Map<String, String> get query => { 'page': '$page','per_page': '15'};

  @override
  get body => null;

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }
}
