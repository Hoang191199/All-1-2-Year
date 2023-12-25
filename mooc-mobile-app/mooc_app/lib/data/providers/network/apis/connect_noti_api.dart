import 'package:get/get.dart';
import 'package:mooc_app/data/providers/network/api_endpoint.dart';
import 'package:mooc_app/data/providers/network/api_provider.dart';
import 'package:mooc_app/data/providers/network/api_request_representable.dart';

import '../../../../app/services/local_storage.dart';

class ConnectNotiAPI implements APIRequestRepresentable {
  final store = Get.find<LocalStorageService>();
  String? fmcToken;

  ConnectNotiAPI._({
    this.fmcToken,
  });
  ConnectNotiAPI.fetchConnectNoti(String fmcToken)
  : this._(fmcToken: fmcToken);

  @override
  String get endpoint => APIEndpoint.endpointNotiService;

  @override
  String get path => "/client/fcm_token.json";

  @override
  String get url => endpoint + path;

  @override
  HTTPMethod get method {
    return HTTPMethod.post;
  }

  @override
  Map<String, String> get headers =>
      {"Authorization": "Bearer ${store.notiTokenFromStorage}"};
  @override
  get query => null;

  @override
  Map<String, String> get body => {"fcm_token": fmcToken ?? ''};

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }
}
