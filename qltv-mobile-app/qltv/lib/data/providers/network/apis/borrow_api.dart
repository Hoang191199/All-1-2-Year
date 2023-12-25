import 'dart:io';

import 'package:get/get.dart';
import 'package:qltv/app/services/local_storage.dart';
import 'package:qltv/data/providers/network/api_endpoint.dart';
import 'package:qltv/data/providers/network/api_provider.dart';
import 'package:qltv/data/providers/network/api_request_representable.dart';
import 'package:qltv/presentation/controllers/login/login_controller.dart';
// import 'package:qltv/presentation/controllers/profile/profile_controller.dart';

enum BorrowType { borrow, add, borrowDetail, delete, update }

class BorrowAPI implements APIRequestRepresentable {
  final BorrowType type;
  int? idBorrow;
  String? keywords;
  int? status;
  int? pageSize;
  int? page;
  String? title;
  String? date;
  String? titleBook;
  String? author;
  String? note;

  BorrowAPI._(
      {required this.type,
      this.idBorrow,
      this.page,
      this.pageSize,
      this.keywords,
      this.status,
      this.title,
      this.date,
      this.titleBook,
      this.author,
      this.note});

  BorrowAPI.fetchBorrow(
    int page,
    int pageSize,
    String? keywords,
    int? status,
  ) : this._(
          type: BorrowType.borrow,
          page: page,
          pageSize: pageSize,
          keywords: keywords,
          status: status,
        );
  BorrowAPI.addBorrow(
    String? title,
    String date,
    String titleBook,
    String author,
    String? note,
  ) : this._(
            type: BorrowType.add,
            title: title,
            date: date,
            titleBook: titleBook,
            author: author,
            note: note);

  BorrowAPI.getBorrowDetail(int id)
      : this._(type: BorrowType.borrowDetail, idBorrow: id);

  BorrowAPI.deleteBorrow(int id)
      : this._(type: BorrowType.delete, idBorrow: id);

  BorrowAPI.updateBorrow(
    int id,
    String? title,
    String date,
    String titleBook,
    String author,
    String? note,
  ) : this._(
            type: BorrowType.update,
            idBorrow: id,
            title: title,
            date: date,
            titleBook: titleBook,
            author: author,
            note: note);

  @override
  String get endpoint => APIEndpoint.endpointTest;

  @override
  String get path {
    final loginController = Get.find<LoginController>();
    final siteId = loginController.userLogin?.default_site_id;
    switch (type) {
      case BorrowType.borrow:
        return "/$siteId/document_requests";
      case BorrowType.add:
        return "/$siteId/document_request";
      case BorrowType.borrowDetail:
        return "/$siteId/document_request/$idBorrow";
      case BorrowType.delete:
        return "/$siteId/document_request";
      case BorrowType.update:
        return "/$siteId/document_request/$idBorrow";
    }
  }

  @override
  String get url => endpoint + path;

  @override
  HTTPMethod get method {
    switch (type) {
      case BorrowType.add:
        return HTTPMethod.post;
      case BorrowType.delete:
        return HTTPMethod.delete;
      case BorrowType.update:
        return HTTPMethod.put;
      default:
        return HTTPMethod.get;
    }
  }

  @override
  Map<String, String> get headers {
    final authController = Get.find<LoginController>();
    String accessToken = authController.accessToken ?? '';
    switch (type) {
      case BorrowType.borrow:
      case BorrowType.add:
      case BorrowType.borrowDetail:
      case BorrowType.update:
      case BorrowType.delete:
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
    final loginController = Get.find<LoginController>();
    final userId = loginController.userLogin?.id;

    switch (type) {
      case BorrowType.borrow:
        if (status == null) {
          return {
            "q": "$keywords",
            "type": "app",
            "current": "$page",
            "pageSize": "$pageSize",
            "user_id": "$userId"
          };
        } else {
          return {
            "status": "$status",
            "type": "app",
            "q": "$keywords",
            "current": "$page",
            "pageSize": "$pageSize",
            "user_id": "$userId"
          };
        }
      default:
        return null;
    }
  }

  @override
  get body {
    final storeUser = Get.find<LocalStorageService>();
    final fullName = storeUser.userFromStorage?.fullname;
    final useCode = storeUser.userFromStorage?.code;
    final subjectGroup = storeUser
        .userFromStorage?.site_ids?[0].metadata?.subject_groups
        ?.join(', ');
    switch (type) {
      case BorrowType.add:
        return {
          "user_code": useCode,
          "user_name": fullName,
          "user_group": ["$subjectGroup"],
          "title": title,
          "note": note,
          "get_date": date,
          "items": [
            {"title": titleBook, "author": author}
          ]
        };
      case BorrowType.update:
        return {
          "title": "$title",
          "note": "$note",
          "get_date": "$date",
          "items": [
            {"title": "$titleBook", "author": "$author"}
          ]
        };
      case BorrowType.delete:
        return {
          "ids": ["$idBorrow"],
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
