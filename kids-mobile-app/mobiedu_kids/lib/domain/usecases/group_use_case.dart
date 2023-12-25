import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
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

class ShowAllUseCase
    extends ParamUseCase<ResponseDataObject<InfoGroup>, Tuple2<int, String>> {
  ShowAllUseCase(this.groupRepository);

  final GroupRepository groupRepository;

  @override
  Future<ResponseDataObject<InfoGroup>> execute(Tuple2 params) {
    return groupRepository.showAll(params.value1, params.value2);
  }
}

class ShowMembersUseCase
    extends ParamUseCase<ResponseDataObject<Members>, Tuple2<int, String>> {
  ShowMembersUseCase(this.groupRepository);

  final GroupRepository groupRepository;

  @override
  Future<ResponseDataObject<Members>> execute(Tuple2 params) {
    return groupRepository.showMembers(params.value1, params.value2);
  }
}

class SearchDetailsUseCase extends ParamUseCase<ResponseDataObject<Posts>,
    Tuple3<int, String, String>> {
  SearchDetailsUseCase(this.groupRepository);

  final GroupRepository groupRepository;

  @override
  Future<ResponseDataObject<Posts>> execute(Tuple3 params) {
    return groupRepository.searchDetails(
      params.value1,
      params.value2,
      params.value3,
    );
  }
}

class GetAllPhotoUseCase
    extends ParamUseCase<ResponseDataObject<Photos>, Tuple2<int, String>> {
  GetAllPhotoUseCase(this.groupRepository);

  final GroupRepository groupRepository;

  @override
  Future<ResponseDataObject<Photos>> execute(Tuple2 params) {
    return groupRepository.getAllPhoto(params.value1, params.value2);
  }
}

class GetAlbumsUseCase
    extends ParamUseCase<ResponseDataObject<Albums>, Tuple2<int, String>> {
  GetAlbumsUseCase(this.groupRepository);

  final GroupRepository groupRepository;

  @override
  Future<ResponseDataObject<Albums>> execute(Tuple2 params) {
    return groupRepository.getAlbums(params.value1, params.value2);
  }
}

class GetAlbumUseCase extends ParamUseCase<ResponseDataObject<Album>,
    Tuple3<int, String, String>> {
  GetAlbumUseCase(this.groupRepository);

  final GroupRepository groupRepository;

  @override
  Future<ResponseDataObject<Album>> execute(Tuple3 params) {
    return groupRepository.getAlbum(
        params.value1, params.value2, params.value3);
  }
}

class GetVideoUseCase
    extends ParamUseCase<ResponseDataObject<Videos>, Tuple2<int, String>> {
  GetVideoUseCase(this.groupRepository);

  final GroupRepository groupRepository;

  @override
  Future<ResponseDataObject<Videos>> execute(Tuple2 params) {
    return groupRepository.getVideo(params.value1, params.value2);
  }
}

class CreatePostUseCase extends ParamUseCase<ResponseDataObject<Post>,
    Tuple3<String, String, Uint8List>> {
  CreatePostUseCase(this.groupRepository);

  final GroupRepository groupRepository;

  @override
  Future<ResponseDataObject<Post>> execute(Tuple3 params) {
    return groupRepository.createPost(
      params.value1,
      params.value2,
      params.value3,
    );
  }
}

class GetPostUseCase extends ParamUseCase<ResponseDataComment<PostDetails>,
    Tuple2<String, String>> {
  GetPostUseCase(this.groupRepository);

  final GroupRepository groupRepository;

  @override
  Future<ResponseDataComment<PostDetails>> execute(Tuple2 params) {
    return groupRepository.getPost(
      params.value1,
      params.value2,
    );
  }
}

class PostActionUseCase
    extends ParamUseCase<ResponseDataObject<Object>, Tuple2<String, String>> {
  PostActionUseCase(this.groupRepository);

  final GroupRepository groupRepository;

  @override
  Future<ResponseDataObject<Object>> execute(Tuple2 params) {
    return groupRepository.postActon(params.value1, params.value2);
  }
}

class CreateCommentUseCase extends ParamUseCase<ResponseDataObject<CommentInfo>,
    Tuple2<String, String>> {
  CreateCommentUseCase(this.groupRepository);

  final GroupRepository groupRepository;

  @override
  Future<ResponseDataObject<CommentInfo>> execute(Tuple2 params) {
    return groupRepository.createComment(params.value1, params.value2);
  }
}
