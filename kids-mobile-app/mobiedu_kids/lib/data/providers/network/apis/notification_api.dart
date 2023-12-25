import 'package:get/get.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/data/providers/network/api_endpoint.dart';
import 'package:mobiedu_kids/data/providers/network/api_provider.dart';
import 'package:mobiedu_kids/data/providers/network/api_request_representable.dart';

enum NotificationApiType { listNotifications, setCountNotifications, detail }

class NotificationAPI implements APIRequestRepresentable {

  final store = Get.find<LocalStorageService>();
  
  final NotificationApiType type;
  int? page;
  String? action;
  String? nodeUrl;
  String? nodeType;
  String? extra1;
  String? extra2;
  String? extra3;

  NotificationAPI._({
    required this.type,
    this.page,
    this.action,
    this.nodeUrl,
    this.nodeType,
    this.extra1,
    this.extra2,
    this.extra3
  });

  NotificationAPI.getListNotifications(int page)
    : this._(
      type: NotificationApiType.listNotifications,
      page: page,
    );

  NotificationAPI.setCountNotifications()
    : this._(
      type: NotificationApiType.setCountNotifications,
    );

  NotificationAPI.detail(String action, String nodeUrl,String nodeType ,String extra1,String extra2 ,String extra3)
    : this._(
      type: NotificationApiType.detail,
      action: action,
      nodeUrl: nodeUrl,
      nodeType: nodeType,
      extra1: extra1,
      extra2: extra2,
      extra3: extra3
    );

  @override
  String get endpoint => APIEndpoint.endpoint;

  @override
  String get path {
    switch (type) {
      case NotificationApiType.listNotifications:
        return '/notification';
      case NotificationApiType.setCountNotifications:
        return '/setCountNotifications';
      case NotificationApiType.detail:
        return '/notificationDetail';
      default: 
        return '';
    }
  }

  @override
  String get url {
    switch (type) {
      default:
        return endpoint + path;
    }
  }

  @override
  HTTPMethod get method {
    switch (type) {
      default:
        return HTTPMethod.post;
    }
  }

  @override
  Map<String, String> get headers {
    return {};
  }

  @override
  Map<String, String>? get query {
    switch (type) {
      default:
        return {};
    }
  }

  @override
  FormData get form {
    final user_token = store.userFromStorage?.user_token;
    final user_id = store.userFromStorage?.user_id;
    switch (type) {
      case NotificationApiType.listNotifications:
        return FormData({
          'user_token': user_token,
          'user_id': user_id,
          'page': '$page',
        });
      case NotificationApiType.setCountNotifications:
        return FormData({
          'user_token': user_token,
          'user_id': user_id,
          'value': 'all'
        });
      case NotificationApiType.detail:
        return FormData({
          'user_token': user_token,
          'user_id': user_id,
          'action': action,
          'node_url': nodeUrl,
          'node_type': nodeType,
          'extra1': extra1,
          'extra2': extra2,
          'extra3': extra3,
        });
    }
  }

  @override
  get body => form;

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }
}