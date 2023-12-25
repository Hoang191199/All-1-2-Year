import 'package:get/get.dart';
import 'package:qltv/presentation/controllers/login/login_controller.dart';
import '../../../../app/services/local_storage.dart';
import '../api_endpoint.dart';
import '../api_provider.dart';
import '../api_request_representable.dart';

class NotiAPI implements APIRequestRepresentable {
  final store = Get.find<LocalStorageService>();
  int page;
  int pageSize;
  NotiAPI._({required this.page, required this.pageSize});
  NotiAPI.fetchNoti(int page, int pageSize)
      : this._(page: page, pageSize: pageSize);

  @override
  String get endpoint => APIEndpoint.endpointTest;

  @override
  String get path {
    final login = Get.find<LoginController>();
    final siteId = login.userLogin?.default_site_id;
    return "/$siteId/notifications";
  }

  @override
  String get url => endpoint + path;

  @override
  HTTPMethod get method {
    return HTTPMethod.get;
  }

  @override
  Map<String, String> get headers =>
      {"Authorization": "Bearer ${store.accessTokenFromStorage}"};

  @override
  Map<String, String> get query =>
      {"current": "$page", "pageSize": "$pageSize"};

  @override
  get body => null;

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }
}
