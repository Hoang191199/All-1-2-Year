import 'package:get/get.dart';
import 'package:mooc_app/data/providers/network/api_endpoint.dart';
import 'package:mooc_app/data/providers/network/api_provider.dart';
import 'package:mooc_app/data/providers/network/api_request_representable.dart';

import '../../../../app/services/local_storage.dart';

class DetailNotiAPI implements APIRequestRepresentable {
  final store = Get.find<LocalStorageService>();
  String id;
  DetailNotiAPI._({required this.id});
  DetailNotiAPI.fetchNoti(String id)
      : this._(
          id: id,
        );

  @override
  String get endpoint => APIEndpoint.endpointTestMooc;

  @override
  String get path => "/auth/restapi/user/detailnotification";

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
  Map<String, String> get query =>
      {"id": "$id", "userToken": "${store.notiTokenFromStorage}"};

  @override
  get body => null;

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }
}
