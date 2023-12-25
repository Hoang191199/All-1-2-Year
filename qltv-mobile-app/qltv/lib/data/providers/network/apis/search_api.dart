import 'dart:io';

import 'package:get/get.dart';
import 'package:qltv/data/providers/network/api_endpoint.dart';
import 'package:qltv/data/providers/network/api_provider.dart';
import 'package:qltv/data/providers/network/api_request_representable.dart';
import 'package:qltv/presentation/controllers/login/login_controller.dart';

enum SearchType { search, register, add, seen }

class SearchAPI implements APIRequestRepresentable {
  final SearchType type;
  int? id;
  String? object_type;
  String? keyword;
  String? titleLable;
  int? pageSize;
  int? page;
  int? quantity;
  String? receipt_date;
  String? typePublication;

  SearchAPI._(
      {required this.type,
      this.id,
      this.object_type,
      this.keyword,
      this.titleLable,
      this.page,
      this.pageSize,
      this.quantity,
      this.receipt_date,
      this.typePublication
    });

  SearchAPI.fetch(
    String? object_type,
    String? titleLable,
    String? keyword,
    int? page,
    int? pageSize,
  ) : this._(
          type: SearchType.search,
          object_type: object_type,
          keyword: keyword,
          titleLable: titleLable,
          page: page,
          pageSize: pageSize,
        );

  SearchAPI.register(
    int? quantity,
    int? item_id,
    String? receipt_date,
    String? type,

  ) : this._(
          type: SearchType.register,
          quantity: quantity,
          receipt_date: receipt_date,
          id: item_id,
          typePublication: type
  );

  SearchAPI.add(
    int? item_id,

  ) : this._(
          type: SearchType.add,
          id: item_id,
  );
  
  SearchAPI.seen(
    int? item_id,
  ) : this._(
          type: SearchType.seen,
          id: item_id,
  );

  @override
  String get endpoint => APIEndpoint.endpointTest;

  @override
  String get path {
    final loginController = Get.find<LoginController>();
    final siteId = loginController.userLogin?.default_site_id;
    switch (type) {
      case SearchType.search:
        return "/$siteId/publications_for_app";
      case SearchType.register:
        return "/$siteId/reservations";
      case SearchType.add:
        return "/$siteId/bookcase";
      case SearchType.seen:
        return "/$siteId/interactives";
    }
  }

  @override
  String get url => endpoint + path;

  @override
  HTTPMethod get method {
    switch (type) {
      case SearchType.register:
      case SearchType.add:
      case SearchType.seen:
        return HTTPMethod.post;
      default:
        return HTTPMethod.get;
    }
  }

  @override
  Map<String, String> get headers {
    final authController = Get.find<LoginController>();
    String accessToken = authController.accessToken ?? '';
    switch (type) {
      case SearchType.search:
      case SearchType.register:
      case SearchType.add:
      case SearchType.seen:
        if (accessToken.isNotEmpty) {
          return {HttpHeaders.authorizationHeader: 'Bearer $accessToken'};
        }
        return {};
      default:
        return {};
    }
  }

  @override
  Map<String, String>? get query {
    switch (type) {
      case SearchType.search:
        return {
          "object_type": "$object_type",
          "$titleLable": "$keyword",
          "current": "$page",
          "pageSize": "$pageSize",
        };
      default:
        return null;
    }
  }

  @override
  get body {
    final loginController = Get.find<LoginController>();
    final userId = loginController.userLogin?.id;
    switch (type) {
      case SearchType.register:
        return {
          "user_id": userId,
          "receipt_date": receipt_date,
          "items": [
            {
              "item_id": id,
              "quantity": quantity
            }
          ],
          "type": typePublication
        };
      case SearchType.add:
        return {
          "item_id": id,
        };
      case SearchType.seen:
        return {
          "user_id": userId,
          "item_id": id,
          "type": 'seen',
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
