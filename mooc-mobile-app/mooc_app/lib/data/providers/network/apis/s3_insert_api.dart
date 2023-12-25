import 'package:get/get.dart';
import 'package:mooc_app/app/services/local_storage.dart';
import 'package:mooc_app/data/providers/network/api_endpoint.dart';
import 'package:mooc_app/data/providers/network/api_provider.dart';
import 'package:mooc_app/data/providers/network/api_request_representable.dart';

class InsertInfoAPI implements APIRequestRepresentable {
  final store = Get.find<LocalStorageService>();
  String? file;

  InsertInfoAPI._({this.file});

  InsertInfoAPI.insert(String? file)
      : this._(
          file: file,
        );

  @override
  String get endpoint => APIEndpoint.endpointTestMooc;

  @override
  String get path => "/storage/file/insertfile";

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
  Map<String, String> get query => {'idSite': '2', 'idFile': '$file'};

  @override
  get body => null;

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }
}
