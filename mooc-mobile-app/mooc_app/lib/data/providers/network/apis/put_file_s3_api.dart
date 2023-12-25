import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:mooc_app/app/services/local_storage.dart';
import 'package:mooc_app/data/providers/network/api_endpoint.dart';
import 'package:mooc_app/data/providers/network/api_provider.dart';
import 'package:mooc_app/data/providers/network/api_request_representable.dart';

class S3PutAPI implements APIRequestRepresentable {
  final store = Get.find<LocalStorageService>();
  Uint8List bytes;
  String urlFile;
  String type;

  S3PutAPI._({required this.bytes, required this.urlFile, required this.type});

  S3PutAPI.upload(Uint8List bytes, String urlFile, String type)
      : this._(bytes: bytes, urlFile: urlFile, type: type);

  @override
  String get endpoint => "";

  @override
  String get path => "";

  @override
  String get url => urlFile;

  @override
  HTTPMethod get method {
    return HTTPMethod.put;
  }

  @override
  Map<String, String> get headers => {
        "Content-Type": type,
        "x-amz-acl": "public-read",
      };

  @override
  get query => null;

  @override
  get body => bytes;

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }
}
