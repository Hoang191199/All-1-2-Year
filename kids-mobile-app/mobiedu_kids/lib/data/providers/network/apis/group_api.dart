import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/data/providers/network/api_endpoint.dart';
import 'package:mobiedu_kids/data/providers/network/api_provider.dart';
import 'package:mobiedu_kids/data/providers/network/api_request_representable.dart';

enum GroupType {
  showAll,
  showMembers,
  searchDetails,
  getAllPhoto,
  getAlbums,
  getAlbum,
  getVideo,
  createPost,
  getPost,
  postActon,
  createComment
}

class GroupAPI implements APIRequestRepresentable {
  final GroupType type;
  int? page;
  String? username;
  String? group_id;
  String? album_id;
  String? message;
  String? post_id;
  String? action;
  Uint8List? file;

  final store = Get.find<LocalStorageService>();

  GroupAPI._(
      {required this.type,
      this.page,
      this.username,
      this.group_id,
      this.album_id,
      this.message,
      this.post_id,
      this.action,
      this.file});

  GroupAPI.showAll(int page, String username)
      : this._(type: GroupType.showAll, page: page, username: username);

  GroupAPI.showMembers(int page, String username)
      : this._(type: GroupType.showMembers, page: page, username: username);

  GroupAPI.searchDetails(int page, String group_id, String message)
      : this._(
            type: GroupType.searchDetails,
            page: page,
            group_id: group_id,
            message: message);

  GroupAPI.getAllPhoto(int page, String group_id)
      : this._(type: GroupType.getAllPhoto, page: page, group_id: group_id);

  GroupAPI.getAlbums(int page, String username)
      : this._(type: GroupType.getAlbums, page: page, username: username);
  GroupAPI.getAlbum(int page, String username, String album_id)
      : this._(
            type: GroupType.getAlbum,
            page: page,
            username: username,
            album_id: album_id);

  GroupAPI.getVideo(int page, String group_id)
      : this._(
          type: GroupType.getVideo,
          page: page,
          group_id: group_id,
        );

  GroupAPI.createPost(String group_id, String message, Uint8List file)
      : this._(
            type: GroupType.createPost,
            group_id: group_id,
            message: message,
            file: file);

  GroupAPI.getPost(int page, String post_id)
      : this._(type: GroupType.getPost, page: page, post_id: post_id);

  GroupAPI.postActon(String action, String post_id)
      : this._(type: GroupType.postActon, action: action, post_id: post_id);

  GroupAPI.createComment(String post_id, String message)
      : this._(
            type: GroupType.createComment, post_id: post_id, message: message);

  @override
  FormData get form {
    switch (type) {
      case GroupType.showAll:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "view": "all",
          "page": "$page",
          "username": "$username"
        });
      case GroupType.showMembers:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "view": "members",
          "event_id": "$page",
          "group_name": "$username"
        });
      case GroupType.searchDetails:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "query": "$message",
          "type": "posts",
          "page": "$page",
          "id": "$group_id"
        });
      case GroupType.getAllPhoto:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "type": "group",
          "page": "$page",
          "id": "$group_id"
        });
      case GroupType.getAlbums:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "type": "group",
          "page": "$page",
          "username": "$username"
        });
      case GroupType.getAlbum:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "type": "group",
          "page": "$page",
          "album_id": "$album_id",
          "username": "$username"
        });
      case GroupType.createPost:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "id": "$group_id",
          "type": "publisher",
          "handle": "group",
          "message": "$message",
          "photo": MultipartFile(file, filename: "avatar.jpg")
        });
      case GroupType.getPost:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "page": "$page",
          "post_id": "$post_id",
        });
      case GroupType.getVideo:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "type": "group",
          "page": "$page",
          "id": "$album_id",
        });
      case GroupType.postActon:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "$action",
          "id": "$post_id",
        });
      case GroupType.createComment:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "handle": "post",
          "id": "$post_id",
          "message": "$message"
        });
    }
  }

  @override
  String get endpoint => APIEndpoint.endpoint;

  @override
  String get path {
    switch (type) {
      case GroupType.showAll:
      case GroupType.showMembers:
        return "/showGroup";
      case GroupType.searchDetails:
        return "/searchDetail";
      case GroupType.getAllPhoto:
        return "/getAllPhoto";
      case GroupType.getAlbums:
        return "/getAlbums";
      case GroupType.getAlbum:
        return "/getAlbum";
      case GroupType.getVideo:
        return "/getAllVideo";
      case GroupType.createPost:
        return "/createPost";
      case GroupType.getPost:
        return "/getPost";
      case GroupType.postActon:
        return "/getAllVideo";
      case GroupType.createComment:
        return "/getAllVideo";
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
