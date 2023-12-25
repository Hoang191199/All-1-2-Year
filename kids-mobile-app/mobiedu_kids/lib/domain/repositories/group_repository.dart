import 'dart:typed_data';
import 'package:mobiedu_kids/domain/entities/album.dart';
import 'package:mobiedu_kids/domain/entities/albums.dart';
import 'package:mobiedu_kids/domain/entities/comment_info.dart';
import 'package:mobiedu_kids/domain/entities/info_group.dart';
import 'package:mobiedu_kids/domain/entities/members.dart';
import 'package:mobiedu_kids/domain/entities/photos.dart';
import 'package:mobiedu_kids/domain/entities/post.dart';
import 'package:mobiedu_kids/domain/entities/post_details.dart';
import 'package:mobiedu_kids/domain/entities/posts.dart';
import 'package:mobiedu_kids/domain/entities/response_data_comment.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/videos.dart';

abstract class GroupRepository {
  Future<ResponseDataObject<InfoGroup>> showAll(int page, String username);
  Future<ResponseDataObject<Members>> showMembers(int page, String username);
  Future<ResponseDataObject<Posts>> searchDetails(
      int page, String group_id, String message);
  Future<ResponseDataObject<Photos>> getAllPhoto(int page, String group_id);
  Future<ResponseDataObject<Albums>> getAlbums(int page, String username);
  Future<ResponseDataObject<Album>> getAlbum(
      int page, String username, String album_id);
  Future<ResponseDataObject<Videos>> getVideo(int page, String group_id);
  Future<ResponseDataObject<Post>> createPost(
      String group_id, String message, Uint8List file);
  Future<ResponseDataComment<PostDetails>> getPost(int page, String post_id);
  Future<ResponseDataObject<Object>> postActon(String action, String post_id);
  Future<ResponseDataObject<CommentInfo>> createComment(
      String post_id, String message);
}
