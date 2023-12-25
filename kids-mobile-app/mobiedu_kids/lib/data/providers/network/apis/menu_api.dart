import 'package:get/get.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/data/providers/network/api_endpoint.dart';
import 'package:mobiedu_kids/data/providers/network/api_provider.dart';
import 'package:mobiedu_kids/data/providers/network/api_request_representable.dart';

enum MenuType {
  get,
  history,
  detail,
  getChild,
  historyChild,
  detailChild,
  schoolList,
  schoolDetail
}

class MenuAPI implements APIRequestRepresentable {
  final MenuType type;
  int? page;
  String? group_name;
  String? menu_id;
  String? child_id;

  final store = Get.find<LocalStorageService>();

  MenuAPI._(
      {required this.type,
      this.page,
      this.group_name,
      this.menu_id,
      this.child_id});

  MenuAPI.get(String group_name)
      : this._(type: MenuType.get, group_name: group_name);

  MenuAPI.getChild(String child_id)
      : this._(type: MenuType.getChild, child_id: child_id);

  MenuAPI.history(int page, String group_name)
      : this._(type: MenuType.history, page: page, group_name: group_name);

  MenuAPI.detail(String group_name, String menu_id)
      : this._(type: MenuType.detail, menu_id: menu_id, group_name: group_name);

  MenuAPI.historyChild(int page, String child_id)
      : this._(type: MenuType.historyChild, page: page, child_id: child_id);

  MenuAPI.detailChild(String child_id, String menu_id)
      : this._(
            type: MenuType.detailChild, menu_id: menu_id, child_id: child_id);

  MenuAPI.schoolList(String group_name)
      : this._(type: MenuType.schoolList, group_name: group_name);

  MenuAPI.schoolDetail(String group_name, String menu_id)
      : this._(
            type: MenuType.schoolDetail,
            menu_id: menu_id,
            group_name: group_name);
  @override
  FormData get form {
    switch (type) {
      case MenuType.get:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "view": "this_week",
          "group_name": "$group_name"
        });
      case MenuType.getChild:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "view": "this_week",
          "child_id": "$child_id"
        });
      case MenuType.history:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "view": "history",
          "page": "$page",
          "group_name": "$group_name"
        });
      case MenuType.detail:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "view": "detail",
          "group_name": "$group_name",
          "menu_id": "$menu_id"
        });
      case MenuType.historyChild:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "view": "history",
          "page": "$page",
          "child_id": "$child_id"
        });
      case MenuType.detailChild:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "view": "detail",
          "child_id": "$child_id",
          "menu_id": "$menu_id"
        });
      case MenuType.schoolList:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "list_menu",
          "page_name": "$group_name"
        });
      case MenuType.schoolDetail:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "detail",
          "page_name": "$group_name",
          "menu_id": "$menu_id"
        });
    }
  }

  @override
  String get endpoint => APIEndpoint.endpoint;

  @override
  String get path {
    switch (type) {
      case MenuType.get:
      case MenuType.history:
      case MenuType.detail:
      case MenuType.getChild:
      case MenuType.historyChild:
      case MenuType.detailChild:
        return "/manageMenu";
      case MenuType.schoolList:
      case MenuType.schoolDetail:
        return "/manageSchoolMenu";
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
