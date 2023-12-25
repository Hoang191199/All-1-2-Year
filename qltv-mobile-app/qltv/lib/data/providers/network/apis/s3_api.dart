import 'dart:io';

import 'package:get/get.dart';
import 'package:qltv/data/providers/network/api_endpoint.dart';
import 'package:qltv/data/providers/network/api_provider.dart';
import 'package:qltv/data/providers/network/api_request_representable.dart';
import 'package:qltv/presentation/controllers/login/login_controller.dart';

enum S3APIType { preSignedUrl, preSignedGetUrl }

class S3API implements APIRequestRepresentable {
  final loginController = Get.find<LoginController>();

  final S3APIType type;
  String? object_key;
  String? mime;
  String? name;
  int? size;

  S3API._(
      {required this.type, this.object_key, this.mime, this.name, this.size});

  S3API.preSignedGetUrl(String object_key)
      : this._(
          type: S3APIType.preSignedGetUrl,
          object_key: object_key,
        );

  S3API.preSignedUrl(String mime, String name, int size)
      : this._(
            type: S3APIType.preSignedUrl, size: size, mime: mime, name: name);

  @override
  String get endpoint => APIEndpoint.endpointTest;

  @override
  String get path {
    switch (type) {
      case S3APIType.preSignedGetUrl:
        return '/s3/preSignedGetUrl';
      case S3APIType.preSignedUrl:
        return '/s3/preSignedUrl';
      default:
        return '';
    }
  }

  @override
  String get url => endpoint + path;

  @override
  HTTPMethod get method {
    switch (type) {
      case S3APIType.preSignedGetUrl:
        return HTTPMethod.get;
      case S3APIType.preSignedUrl:
        return HTTPMethod.post;
      default:
        return HTTPMethod.get;
    }
  }

  @override
  Map<String, String> get headers {
    String accessToken = loginController.accessToken ?? '';
    if (accessToken.isNotEmpty) {
      switch (type) {
        case S3APIType.preSignedGetUrl:
          return {
            HttpHeaders.authorizationHeader: 'Bearer $accessToken',
          };
        case S3APIType.preSignedUrl:
          return {
            HttpHeaders.authorizationHeader: 'Bearer $accessToken',
          };
      }
    }
    return {};
  }

  @override
  Map<String, String>? get query {
    switch (type) {
      case S3APIType.preSignedGetUrl:
        return {'object_key': '$object_key'};
      default:
        return {};
    }
  }

  @override
  get body {
    switch (type) {
      case S3APIType.preSignedUrl:
        return {
          "content_type": "$mime",
          "type": "images",
          "file": "$name",
          "content_length": size,
          "delete_allow": false
        };
      default:
        return null;
    }
  }

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }
}
