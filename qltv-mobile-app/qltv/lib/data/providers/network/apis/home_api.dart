import 'dart:io';

import 'package:get/get.dart';
import 'package:qltv/data/providers/network/api_endpoint.dart';
import 'package:qltv/data/providers/network/api_provider.dart';
import 'package:qltv/data/providers/network/api_request_representable.dart';
import 'package:qltv/presentation/controllers/login/login_controller.dart';

enum HomeType { home, bookcaseDetail }

class HomeAPI implements APIRequestRepresentable {
  final HomeType type;
  int? id;
  HomeAPI._(
      {
      required this.type,
      this.id,
  });


  HomeAPI.fetchHome()
    : this._(
      type: HomeType.home,
  );

  HomeAPI.bookDetail(int id)
    : this._(type: HomeType.bookcaseDetail, id: id);

  @override
  String get endpoint => APIEndpoint.endpointTest;

  @override
  String get path {
    final loginController = Get.find<LoginController>();
    final siteId = loginController.userLogin?.default_site_id;
    switch (type) {
      case HomeType.home:
        return '/$siteId/public/pages/by_slug';
      case HomeType.bookcaseDetail:
        return '/$siteId/public/publications/$id';
    }
  }

  @override
  String get url => endpoint + path;

  @override
  HTTPMethod get method { 
    return HTTPMethod.get; 
  }

  @override
  Map<String, String> get headers {
    final loginController = Get.find<LoginController>();
    String accessToken = loginController.accessToken ?? '';
    if (accessToken.isNotEmpty) {
      return {HttpHeaders.authorizationHeader: 'Bearer $accessToken'};
    }
    return {};
  }

  @override
  Map<String, String>? get query {
    return {'slug': '/home', 'type': 'app'};
  }

  @override
  get body => null;

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }
}