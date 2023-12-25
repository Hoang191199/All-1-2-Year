import 'package:get/get.dart';

import '../../../../app/services/local_storage.dart';
import '../api_endpoint.dart';
import '../api_provider.dart';
import '../api_request_representable.dart';

enum NotiType { readAll, listUnread }

class ReadAPI implements APIRequestRepresentable {
  final store = Get.find<LocalStorageService>();
  final NotiType type;
  ReadAPI._({
    required this.type,
  });
  ReadAPI.fetchReadAll(): this._(
      type: NotiType.readAll);
  ReadAPI.fetchUnread(): this._(
      type: NotiType.listUnread,
  );

  @override
  String get endpoint => APIEndpoint.endpointNotiService;

  @override
  String get path {
    switch (type) {
      case NotiType.readAll:
        return "/client/notification/read_all.json";
      case NotiType.listUnread:
        return "/client/notification.json";
    }
  }

  @override
  String get url => endpoint + path;

  @override
  HTTPMethod get method {
    switch (type) {
      case NotiType.readAll:
        return HTTPMethod.post;
      case NotiType.listUnread:
        return HTTPMethod.get;
    }
  }

  @override
  Map<String, String> get headers =>
      {'Authorization': 'Bearer ${store.notiTokenFromStorage}'};

  @override
  get query => null;

  @override
  get body => null;

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }
}