import 'package:get/get.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/data/providers/network/api_endpoint.dart';
import 'package:mobiedu_kids/data/providers/network/api_provider.dart';
import 'package:mobiedu_kids/data/providers/network/api_request_representable.dart';

enum BlockType { list, unblock }

class BlockAPI implements APIRequestRepresentable {
  final BlockType type;
  int? page;
  String? friends_id;

  final store = Get.find<LocalStorageService>();

  BlockAPI._({required this.type, this.page, this.friends_id});

  BlockAPI.list(int page) : this._(type: BlockType.list, page: page);

  BlockAPI.unblock(String friends_id)
      : this._(type: BlockType.unblock, friends_id: friends_id);
  @override
  FormData get form {
    switch (type) {
      case BlockType.list:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "page": "$page",
        });
      case BlockType.unblock:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "unblock",
          "friends_id": "$friends_id"
        });
    }
  }

  @override
  String get endpoint => APIEndpoint.endpoint;

  @override
  String get path {
    switch (type) {
      case BlockType.list:
        return "/getBlocks";
      case BlockType.unblock:
        return "/friendsConnect";
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
