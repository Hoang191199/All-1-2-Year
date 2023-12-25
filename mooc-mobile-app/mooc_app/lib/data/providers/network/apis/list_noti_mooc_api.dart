import 'package:get/get.dart';
import 'package:mooc_app/data/providers/network/api_endpoint.dart';
import 'package:mooc_app/data/providers/network/api_provider.dart';
import 'package:mooc_app/data/providers/network/api_request_representable.dart';

import '../../../../app/services/local_storage.dart';

class ListNotiMoocAPI implements APIRequestRepresentable {
  final store = Get.find<LocalStorageService>();
  int page;
  int per_page;
  ListNotiMoocAPI._({required this.page, required this.per_page});
  ListNotiMoocAPI.fetchNoti(int page, int per_page)
      : this._(
          page: page,
          per_page: per_page,
        );

  @override
  String get endpoint => APIEndpoint.endpointTestMooc;

  @override
  String get path => "/auth/restapi/user/mynotification";

  @override
  String get url => endpoint + path;

  @override
  HTTPMethod get method {
    return HTTPMethod.get;
  }

  @override
  Map<String, String> get headers =>
      {'Authorization': 'Bearer ${store.tokenFromStorage}'};

  @override
  Map<String, String> get query => {
        "userToken": store.notiTokenFromStorage,
        "page": "${page}",
        "per_page": "${per_page}"
      };

  @override
  get body => null;

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }
}
