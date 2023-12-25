import 'package:get/get.dart';
import 'package:mooc_app/data/providers/network/api_endpoint.dart';
import 'package:mooc_app/data/providers/network/api_provider.dart';
import 'package:mooc_app/data/providers/network/api_request_representable.dart';

import '../../../../app/services/local_storage.dart';

class OrderHistoryAPI implements APIRequestRepresentable {
  final store = Get.find<LocalStorageService>();
  int page;
  OrderHistoryAPI._({required this.page});
  OrderHistoryAPI.fetchData(int page)
      : this._(
  page: page,
  );

  @override
  String get endpoint => APIEndpoint.endpointTestMooc;

  @override
  String get path => "/course/order/listorderhistory";

  @override
  String get url => endpoint + path;

  @override
  HTTPMethod get method {
    return HTTPMethod.get;
  }

  @override
  Map<String, String> get headers => { 'Authorization' : 'Bearer ${store.tokenFromStorage}' };

  @override
  Map<String, String> get query => {'page': '$page','limit': '10'};

  @override
  get body => null;

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }
}