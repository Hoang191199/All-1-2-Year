import 'package:get/get.dart';
import 'package:mooc_app/app/services/local_storage.dart';
import 'package:mooc_app/data/providers/network/api_endpoint.dart';
import 'package:mooc_app/data/providers/network/api_provider.dart';
import 'package:mooc_app/data/providers/network/api_request_representable.dart';

class S3GetUrlAPI implements APIRequestRepresentable {
  final store = Get.find<LocalStorageService>();
  String? name;
  String? type;
  int? size;

  S3GetUrlAPI._({this.name, this.type, this.size});

  S3GetUrlAPI.fetchUrl(String? name, String? type, int? size)
      : this._(
          name: name,
          type: type,
          size: size,
        );

  @override
  String get endpoint => APIEndpoint.endpointTestMooc;

  @override
  String get path => "/storage/file/getuploadurl";

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
        'fileName': '$name',
        'contentType': '$type',
        'size': '$size',
        'idSite': '2',
        'uploadAction': 'Other'
      };

  @override
  get body => null;

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }
}
