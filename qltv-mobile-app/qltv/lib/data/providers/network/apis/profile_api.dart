import 'package:get/get.dart';
import '../../../../app/services/local_storage.dart';
import '../api_endpoint.dart';
import '../api_provider.dart';
import '../api_request_representable.dart';

class ProfileAPI implements APIRequestRepresentable {
  final store = Get.find<LocalStorageService>();

  ProfileAPI.fetchProfile();

  @override
  String get endpoint => APIEndpoint.endpointTest;

  @override
  String get path => "/auth/me";

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
  get query => null;

  @override
  get body => null;

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }
}
