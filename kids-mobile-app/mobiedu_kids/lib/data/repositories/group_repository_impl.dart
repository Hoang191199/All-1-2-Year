import 'dart:typed_data';
import 'package:mobiedu_kids/data/providers/network/apis/group_api.dart';
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
import 'package:mobiedu_kids/domain/repositories/group_repository.dart';

class GroupRepositoryImpl extends GroupRepository {
  @override
  Future<ResponseDataObject<InfoGroup>> showAll(
      int page, String username) async {
    final response = await GroupAPI.showAll(page, username).request();
    return ResponseDataObject<InfoGroup>.fromJson(
        response, (data) => InfoGroup.fromJson(data));
  }

  @override
  Future<ResponseDataObject<Members>> showMembers(
      int page, String username) async {
    final response = await GroupAPI.showMembers(
      page,
      username,
    ).request();
    return ResponseDataObject<Members>.fromJson(
        response, (data) => Members.fromJson(data));
  }

  @override
  Future<ResponseDataObject<Posts>> searchDetails(
      int page, String group_id, String message) async {
    final response =
        await GroupAPI.searchDetails(page, group_id, message).request();
    return ResponseDataObject<Posts>.fromJson(
        response, (data) => Posts.fromJson(data));
  }

  @override
  Future<ResponseDataObject<Photos>> getAllPhoto(
      int page, String group_ids) async {
    final response = await GroupAPI.getAllPhoto(page, group_ids).request();
    return ResponseDataObject<Photos>.fromJson(
        response, (data) => Photos.fromJson(data));
  }

  @override
  Future<ResponseDataObject<Albums>> getAlbums(
      int page, String username) async {
    final response = await GroupAPI.getAlbums(page, username).request();
    return ResponseDataObject<Albums>.fromJson(
        response, (data) => Albums.fromJson(data));
  }

  @override
  Future<ResponseDataObject<Album>> getAlbum(
      int page, String username, String album_id) async {
    final response =
        await GroupAPI.getAlbum(page, username, album_id).request();
    return ResponseDataObject<Album>.fromJson(
        response, (data) => Album.fromJson(data));
  }

  @override
  Future<ResponseDataObject<Videos>> getVideo(int page, String group_id) async {
    final response = await GroupAPI.getVideo(page, group_id).request();
    return ResponseDataObject<Videos>.fromJson(
        response, (data) => Videos.fromJson(data));
  }

  @override
  Future<ResponseDataObject<Post>> createPost(
      String group_id, String message, Uint8List file) async {
    final response =
        await GroupAPI.createPost(group_id, message, file).request();
    return ResponseDataObject<Post>.fromJson(
        response, (data) => Post.fromJson(data));
  }

  @override
  Future<ResponseDataComment<PostDetails>> getPost(
      int page, String post_id) async {
    final response = await GroupAPI.getPost(page, post_id).request();
    return ResponseDataComment<PostDetails>.fromJson(
        response, (data) => PostDetails.fromJson(data));
  }

  @override
  Future<ResponseDataObject<Object>> postActon(
      String action, String post_id) async {
    final response = await GroupAPI.postActon(action, post_id).request();
    return ResponseDataObject<Object>.fromJson(response, (data) => Object);
  }

  @override
  Future<ResponseDataObject<CommentInfo>> createComment(
      String post_id, String message) async {
    final response = await GroupAPI.createComment(post_id, message).request();
    return ResponseDataObject<CommentInfo>.fromJson(
        response, (data) => CommentInfo.fromJson(data));
  }
}
