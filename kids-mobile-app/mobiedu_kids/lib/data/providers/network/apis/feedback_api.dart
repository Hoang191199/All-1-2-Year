import 'package:get/get.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/data/providers/network/api_endpoint.dart';
import 'package:mobiedu_kids/data/providers/network/api_provider.dart';
import 'package:mobiedu_kids/data/providers/network/api_request_representable.dart';

// ignore: constant_identifier_names
enum FbType { create, get, confirm, delete, delete_all }

class FbAPI implements APIRequestRepresentable {
  final FbType type;
  String? pagename;
  String? feedback_id;
  String? content;
  String? child_id;
  String? incognito;
  int? page;

  final store = Get.find<LocalStorageService>();

  FbAPI._(
      {required this.type,
      this.page,
      this.pagename,
      this.content,
      this.child_id,
      this.feedback_id,
      this.incognito});

  FbAPI.create(String incognito, String child_id, String content)
      : this._(
            type: FbType.create,
            incognito: incognito,
            child_id: child_id,
            content: content);

  FbAPI.get(int page, String pagename)
      : this._(type: FbType.get, page: page, pagename: pagename);

  FbAPI.confirm(String feedback_id, String pagename)
      : this._(
            type: FbType.confirm, feedback_id: feedback_id, pagename: pagename);

  FbAPI.delete(String feedback_id, String pagename)
      : this._(
            type: FbType.delete, feedback_id: feedback_id, pagename: pagename);

  FbAPI.delete_all(String pagename)
      : this._(type: FbType.delete_all, pagename: pagename);

  @override
  FormData get form {
    switch (type) {
      case FbType.create:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "feedback",
          "incognito": "$incognito",
          "child_id": "$child_id",
          "feedback_level": "1",
          "content": "$content",
        });
      case FbType.get:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "lists",
          "page_name": "$pagename",
          "page": "$page"
        });
      case FbType.confirm:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "confirm",
          "page_name": "$pagename",
          "feedback_id": "$feedback_id"
        });
      case FbType.delete:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "delete",
          "page_name": "$pagename",
          "feedback_id": "$feedback_id"
        });
      case FbType.delete_all:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "delete_all",
          "page_name": "$pagename",
        });
    }
  }

  @override
  String get endpoint => APIEndpoint.endpoint;

  @override
  String get path {
    switch (type) {
      case FbType.get:
      case FbType.confirm:
      case FbType.delete:
      case FbType.delete_all:
        return "/manageSchoolFeedback";
      case FbType.create:
        return "/manageChildFeedback";
    }
  }

  @override
  String get url => endpoint + path;

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  Map<String, String>? get headers => {};

  @override
  Map<String, String>? get query => {};

  @override
  get body => form;

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }
}
