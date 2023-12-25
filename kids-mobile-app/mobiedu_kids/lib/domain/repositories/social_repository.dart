import 'dart:typed_data';

import 'package:mobiedu_kids/domain/entities/news_feed/data_photo_album_video.dart';
import 'package:mobiedu_kids/domain/entities/news_feed/data_response.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';

abstract class SocialRepository {

  Future<ResponseNoData> friendsConnect(String friendId, String actionFriend);

  Future<ResponseNoData> postAction(String action, String postId);

  Future<ResponseNoData> report(String action, String id);

  Future<ResponseNoData> pageConnect(String action, String postId);

  Future<ResponseNoData> groupConnect(String action, String groupId);

  Future<ResponseDataObject<DataResponse>> createPost(String action, String id, String type, String? privacy, List<Uint8List>? files, String? fileType, String? text);

  Future<ResponseNoData> editPost(String action, String postId, String text);

  Future<ResponseDataObject<DataPhotoAlbumVideo>> getAllPhoto(String typeOwner, String id, int page);

  Future<ResponseDataObject<DataPhotoAlbumVideo>> getAlbums(String typeOwner, String username, int page);

  Future<ResponseDataObject<DataPhotoAlbumVideo>> getAlbum(String typeOwner, String username, String albumId, int page);

  Future<ResponseDataObject<DataPhotoAlbumVideo>> getAllVideo(String typeOwner, String id, int page);

}