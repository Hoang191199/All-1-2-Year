import 'dart:typed_data';

import 'package:mobiedu_kids/data/providers/network/apis/social_api.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/data_photo_album_video.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/data_response.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';
import 'package:mobiedu_kids/domain/repositories/social_repository.dart';

class SocialRepositoryImpl extends SocialRepository {

  @override
  Future<ResponseNoData> friendsConnect(String friendId, String actionFriend) async {
    final response = await SocialAPI.friendsConnect(friendId, actionFriend).request();
    return ResponseNoData.fromJson(response);
  }

  @override
  Future<ResponseNoData> postAction(String action, String postId) async {
    final response = await SocialAPI.postAction(action, postId).request();
    return ResponseNoData.fromJson(response);
  }

  @override
  Future<ResponseNoData> report(String action, String id) async {
    final response = await SocialAPI.report(action, id).request();
    return ResponseNoData.fromJson(response);
  }

  @override
  Future<ResponseNoData> pageConnect(String action, String postId) async {
    final response = await SocialAPI.pageConnect(action, postId).request();
    return ResponseNoData.fromJson(response);
  }

  @override
  Future<ResponseNoData> groupConnect(String action, String groupId) async {
    final response = await SocialAPI.groupConnect(action, groupId).request();
    return ResponseNoData.fromJson(response);
  }

  @override
  Future<ResponseDataObject<DataResponse>> createPost(String action, String id, String type, String? privacy, List<Uint8List>? files, String? fileType, String? text) async {
    final response = await SocialAPI.createPost(action, id, type, privacy, files, fileType, text).request();
    return ResponseDataObject<DataResponse>.fromJson(response, (data) => DataResponse.fromJson(data));
  }

  @override
  Future<ResponseNoData> editPost(String action, String postId, String text) async {
    final response = await SocialAPI.editPost(action, postId, text).request();
    return ResponseNoData.fromJson(response);
  }

  @override
  Future<ResponseDataObject<DataPhotoAlbumVideo>> getAllPhoto(String typeOwner, String id, int page) async {
    final response = await SocialAPI.getAllPhoto(typeOwner, id, page).request();
    return ResponseDataObject<DataPhotoAlbumVideo>.fromJson(response, (data) => DataPhotoAlbumVideo.fromJson(data));
  }

  @override
  Future<ResponseDataObject<DataPhotoAlbumVideo>> getAlbums(String typeOwner, String username, int page) async {
    final response = await SocialAPI.getAlbums(typeOwner, username, page).request();
    return ResponseDataObject<DataPhotoAlbumVideo>.fromJson(response, (data) => DataPhotoAlbumVideo.fromJson(data));
  }

  @override
  Future<ResponseDataObject<DataPhotoAlbumVideo>> getAlbum(String typeOwner, String username, String albumId, int page) async {
    final response = await SocialAPI.getAlbum(typeOwner, username, albumId, page).request();
    return ResponseDataObject<DataPhotoAlbumVideo>.fromJson(response, (data) => DataPhotoAlbumVideo.fromJson(data));
  }

  @override
  Future<ResponseDataObject<DataPhotoAlbumVideo>> getAllVideo(String typeOwner, String id, int page) async {
    final response = await SocialAPI.getAllVideo(typeOwner, id, page).request();
    return ResponseDataObject<DataPhotoAlbumVideo>.fromJson(response, (data) => DataPhotoAlbumVideo.fromJson(data));
  }
  
}