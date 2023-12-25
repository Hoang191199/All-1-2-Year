import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/data/providers/network/api_endpoint.dart';
import 'package:mobiedu_kids/data/providers/network/api_provider.dart';
import 'package:mobiedu_kids/data/providers/network/api_request_representable.dart';

enum SocialApiType { friendsConnect, postAction, report, pageConnect, groupConnect, createPost, editPost, getAllPhoto, getAlbums, getAlbum, getAllVideo }

class SocialAPI implements APIRequestRepresentable {
  
  final store = Get.find<LocalStorageService>();
  
  final SocialApiType type;
  String? friendsId;
  String? actionFriend;
  String? action;
  String? id;
  String? text;
  String? typeStr;
  int? page;
  String? username;
  String? albumId;
  String? privacy;
  List<Uint8List>? files;
  String? fileType;

  SocialAPI._({
    required this.type,
    this.friendsId,
    this.actionFriend,
    this.action,
    this.id,
    this.text,
    this.typeStr,
    this.page,
    this.username,
    this.albumId,
    this.privacy,
    this.files,
    this.fileType,
  });

  SocialAPI.friendsConnect(String friendsId, String actionFriend)
    : this._(
      type: SocialApiType.friendsConnect,
      friendsId: friendsId,
      actionFriend: actionFriend,
    );

  SocialAPI.postAction(String action, String id)
    : this._(
      type: SocialApiType.postAction,
      action: action,
      id: id,
    );

  SocialAPI.report(String action, String id)
    : this._(
      type: SocialApiType.report,
      action: action,
      id: id,
    );

  SocialAPI.pageConnect(String action, String id)
    : this._(
      type: SocialApiType.pageConnect,
      action: action,
      id: id,
    );

  SocialAPI.groupConnect(String action, String id)
    : this._(
      type: SocialApiType.groupConnect,
      action: action,
      id: id,
    );

  SocialAPI.createPost(String action, String id, String typeStr, String? privacy, List<Uint8List>? files, String? fileType, String? text)
    : this._(
      type: SocialApiType.createPost,
      action: action,
      id: id,
      typeStr: typeStr,
      privacy: privacy,
      files: files,
      fileType: fileType,
      text: text,
    );

  SocialAPI.editPost(String action, String id, String text)
    : this._(
      type: SocialApiType.editPost,
      action: action,
      id: id,
      text: text,
    );

  SocialAPI.getAllPhoto(String typeStr, String id, int page)
    : this._(
      type: SocialApiType.getAllPhoto,
      typeStr: typeStr,
      id: id,
      page: page,
    );
  
  SocialAPI.getAlbums(String typeStr, String username, int page)
    : this._(
      type: SocialApiType.getAlbums,
      typeStr: typeStr,
      username: username,
      page: page,
    );

  SocialAPI.getAlbum(String typeStr, String username, String albumId, int page)
    : this._(
      type: SocialApiType.getAlbum,
      typeStr: typeStr,
      username: username,
      albumId: albumId,
      page: page,
    );

  SocialAPI.getAllVideo(String typeStr, String id, int page)
    : this._(
      type: SocialApiType.getAllVideo,
      typeStr: typeStr,
      id: id,
      page: page,
    );

  @override
  String get endpoint => APIEndpoint.endpoint;

  @override
  String get path {
    switch (type) {
      case SocialApiType.friendsConnect:
        return '/friendsConnect';
      case SocialApiType.postAction:
      case SocialApiType.editPost:
        return '/postAction';
      case SocialApiType.createPost:
        return '/createPost';
      case SocialApiType.report:
        return '/report';
      case SocialApiType.pageConnect:
        return '/pageConnect';
      case SocialApiType.groupConnect:
        return '/groupConnect';
      case SocialApiType.getAllPhoto:
        return '/getAllPhoto';
      case SocialApiType.getAlbums:
        return '/getAlbums';
      case SocialApiType.getAlbum:
        return '/getAlbum';
      case SocialApiType.getAllVideo:
        return '/getAllVideo';
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
    final userToken = store.userFromStorage?.user_token;
    final userId = store.userFromStorage?.user_id;
    switch (type) {
      case SocialApiType.friendsConnect:
        return FormData({
          'user_token': userToken,
          'user_id': userId,
          'friends_id': friendsId,
          'do': actionFriend,
        });
      case SocialApiType.postAction:
      case SocialApiType.report:
      case SocialApiType.pageConnect:
      case SocialApiType.groupConnect:
        return FormData({
          'user_token': userToken,
          'user_id': userId,
          'do': action,
          'id': id,
        });
      case SocialApiType.createPost:
        var data = <String, Object>{
          'user_token': '$userToken',
          'user_id': '$userId',
          'handle': '$action',
          'id': '$id',
          'type': '$typeStr',
        };
        if (privacy != null && (privacy?.isNotEmpty ?? false)) {
          data['privacy'] = '$privacy';
        }
        if (text != null && (text?.isNotEmpty ?? false)) {
          data['message'] = '$text';
        }
        if (fileType != null && fileType == PhotoType.photo) {
          if (files?.length == 1) {
            data['photo'] = MultipartFile(files?[0], filename: 'image.jpg');
          } else {
            for (var i = 0; i < (files?.length ?? 0); i++) {
              data['photo[$i]'] = MultipartFile(files?[i], filename: 'avatar.jpg');
            }
          }
        } else if (fileType != null && fileType == PhotoType.video) {
          data['video'] = MultipartFile(files?[0], filename: 'video.mp4');
        }
        return FormData(data);
      case SocialApiType.editPost:
        return FormData({
          'user_token': userToken,
          'user_id': userId,
          'do': action,
          'id': id,
          'text': text,
        });
      case SocialApiType.getAllPhoto:
      case SocialApiType.getAllVideo:
        return FormData({
          'user_token': userToken,
          'user_id': userId,
          'type': typeStr,
          'id': id,
          'page': '$page',
        });
      case SocialApiType.getAlbums:
        return FormData({
          'user_token': userToken,
          'user_id': userId,
          'type': typeStr,
          'username': username,
          'page': '$page',
        });
      case SocialApiType.getAlbum:
        return FormData({
          'user_token': userToken,
          'user_id': userId,
          'type': typeStr,
          'username': username,
          'album_id': albumId,
          'page': '$page',
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