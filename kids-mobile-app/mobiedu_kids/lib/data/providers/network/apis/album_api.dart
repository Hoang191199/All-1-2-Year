import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/data/providers/network/api_endpoint.dart';
import 'package:mobiedu_kids/data/providers/network/api_provider.dart';
import 'package:mobiedu_kids/data/providers/network/api_request_representable.dart';

enum AlbumType {
  get,
  add,
  detail,
  addPhoto,
  editCaption,
  deletePhoto,
  deleteAlbum,
  getChild,
  addChild,
  detailChild,
  addPhotoChild,
  editCaptionChild,
  deletePhotoChild,
  deleteAlbumChild
}

class AlbumAPI implements APIRequestRepresentable {
  final AlbumType type;
  String? group_name;
  String? child_id;
  int? year;
  Uint8List? file;
  List<Uint8List?>? multiFile;
  int? fileNum;
  String? caption;
  String? child_journal_album_id;
  String? child_journal_id;

  final store = Get.find<LocalStorageService>();

  AlbumAPI._(
      {required this.type,
      this.group_name,
      this.child_id,
      this.year,
      this.file,
      this.multiFile,
      this.fileNum,
      this.caption,
      this.child_journal_album_id,
      this.child_journal_id});

  AlbumAPI.get(String group_name, String child_id, int year)
      : this._(
            type: AlbumType.get,
            group_name: group_name,
            child_id: child_id,
            year: year);

  AlbumAPI.add(String group_name, String child_id, String caption,
      List<Uint8List?> multiFile, int fileNum)
      : this._(
            type: AlbumType.add,
            group_name: group_name,
            child_id: child_id,
            caption: caption,
            multiFile: multiFile,
            fileNum: fileNum);

  AlbumAPI.detail(String group_name, String child_journal_album_id)
      : this._(
            type: AlbumType.detail,
            group_name: group_name,
            child_journal_album_id: child_journal_album_id);

  AlbumAPI.addPhoto(String group_name, String child_id,
      String child_journal_album_id, List<Uint8List?> multiFile, int fileNum)
      : this._(
            type: AlbumType.addPhoto,
            group_name: group_name,
            child_journal_album_id: child_journal_album_id,
            multiFile: multiFile,
            fileNum: fileNum);

  AlbumAPI.editCaption(String group_name, String child_id,
      String child_journal_album_id, String caption)
      : this._(
            type: AlbumType.editCaption,
            group_name: group_name,
            child_id: child_id,
            child_journal_album_id: child_journal_album_id,
            caption: caption);

  AlbumAPI.deletePhoto(
      String group_name, String child_id, String child_journal_id)
      : this._(
            type: AlbumType.deletePhoto,
            group_name: group_name,
            child_id: child_id,
            child_journal_id: child_journal_id);

  AlbumAPI.deleteAlbum(
      String group_name, String child_id, String child_journal_album_id)
      : this._(
            type: AlbumType.deleteAlbum,
            group_name: group_name,
            child_id: child_id,
            child_journal_album_id: child_journal_album_id);

  AlbumAPI.getChild(String child_id, int year)
      : this._(type: AlbumType.getChild, child_id: child_id, year: year);

  AlbumAPI.addChild(
      String child_id, String caption, List<Uint8List?> multiFile, int fileNum)
      : this._(
            type: AlbumType.addChild,
            child_id: child_id,
            caption: caption,
            multiFile: multiFile,
            fileNum: fileNum);

  AlbumAPI.detailChild(String child_id, String child_journal_album_id)
      : this._(
            type: AlbumType.detailChild,
            child_id: child_id,
            child_journal_album_id: child_journal_album_id);

  AlbumAPI.addPhotoChild(String child_id, String child_journal_album_id,
      List<Uint8List?> multiFile, int fileNum)
      : this._(
            type: AlbumType.addPhotoChild,
            child_id: child_id,
            child_journal_album_id: child_journal_album_id,
            multiFile: multiFile,
            fileNum: fileNum);

  AlbumAPI.editCaptionChild(
      String child_id, String child_journal_album_id, String caption)
      : this._(
            type: AlbumType.editCaptionChild,
            child_id: child_id,
            child_journal_album_id: child_journal_album_id,
            caption: caption);

  AlbumAPI.deletePhotoChild(String child_id, String child_journal_id)
      : this._(
            type: AlbumType.deletePhotoChild,
            child_id: child_id,
            child_journal_id: child_journal_id);

  AlbumAPI.deleteAlbumChild(String child_id, String child_journal_album_id)
      : this._(
            type: AlbumType.deleteAlbumChild,
            child_id: child_id,
            child_journal_album_id: child_journal_album_id);
  @override
  FormData get form {
    switch (type) {
      case AlbumType.get:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "search_diary",
          "group_name": "$group_name",
          "child_id": "$child_id",
          "year": "$year",
        });
      case AlbumType.add:
        var formData = <String, Object>{
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "group_name": "$group_name",
          "do": "add_photo",
          "child_id": "$child_id",
          "caption": "$caption",
          // "file[0]": MultipartFile(file, filename: "avatar.jpg")
        };
        var count = 0;
        if (fileNum! > 0 && fileNum != null) {
          for (var i = 0; i < fileNum!; i++) {
            if (multiFile?[i] != null) {
              formData["file[$count]"] =
                  MultipartFile(multiFile?[i], filename: "avatar.jpg");
              count++;
            }
          }
        }
        return FormData(formData);
      case AlbumType.detail:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "group_name": "$group_name",
          "do": "album_detail",
          "child_journal_album_id": "$child_journal_album_id"
        });
      case AlbumType.addPhoto:
        var formData = <String, Object>{
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "group_name": "$group_name",
          "child_id": "$child_id",
          "do": "add_photo_journal",
          "child_journal_album_id": "$child_journal_album_id",
          // "file[0]": MultipartFile(file, filename: "avatar.jpg")
        };
        var count = 0;
        if (fileNum! > 0 && fileNum != null) {
          for (var i = 0; i < fileNum!; i++) {
            if (multiFile?[i] != null) {
              formData["file[$count]"] =
                  MultipartFile(multiFile?[i], filename: "avatar.jpg");
              count++;
            }
          }
        }
        return FormData(formData);
      case AlbumType.editCaption:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "group_name": "$group_name",
          "do": "edit_caption",
          "child_id": "$child_id",
          "caption": "$caption",
          "child_journal_album_id": "$child_journal_album_id",
        });
      case AlbumType.deletePhoto:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "group_name": "$group_name",
          "child_id": "$child_id",
          "do": "delete_photo",
          "child_journal_id": "$child_journal_id"
        });
      case AlbumType.deleteAlbum:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "delete_album",
          "group_name": "$group_name",
          "child_id": "$child_id",
          "child_journal_album_id": "$child_journal_album_id",
        });
      case AlbumType.getChild:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "search",
          "child_parent_id": "$child_id",
          "year": "$year",
        });
      case AlbumType.addChild:
        var formData = <String, Object>{
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "add",
          "child_parent_id": "$child_id",
          "caption": "$caption",
          // "file[0]": MultipartFile(file, filename: "avatar.jpg")
        };
        var count = 0;
        if (fileNum! > 0 && fileNum != null) {
          for (var i = 0; i < fileNum!; i++) {
            if (multiFile?[i] != null) {
              formData["file[$count]"] =
                  MultipartFile(multiFile?[i], filename: "avatar.jpg");
              count++;
            }
          }
        }
        return FormData(formData);
      case AlbumType.detailChild:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "child_parent_id": "$child_id",
          "do": "album_detail",
          "child_journal_album_id": "$child_journal_album_id"
        });
      case AlbumType.addPhotoChild:
        var formData = <String, Object>{
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "child_parent_id": "$child_id",
          "do": "add_photo",
          "child_journal_album_id": "$child_journal_album_id",
          // "file[0]": MultipartFile(file, filename: "avatar.jpg")
        };
        var count = 0;
        if (fileNum! > 0 && fileNum != null) {
          for (var i = 0; i < fileNum!; i++) {
            if (multiFile?[i] != null) {
              formData["file[$count]"] =
                  MultipartFile(multiFile?[i], filename: "avatar.jpg");
              count++;
            }
          }
        }
        return FormData(formData);
      case AlbumType.editCaptionChild:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "edit_caption",
          "child_parent_id": "$child_id",
          "caption": "$caption",
          "child_journal_album_id": "$child_journal_album_id",
        });
      case AlbumType.deletePhotoChild:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "child_parent_id": "$child_id",
          "do": "delete",
          "child_journal_id": "$child_journal_id"
        });
      case AlbumType.deleteAlbumChild:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "delete_album",
          "child_parent_id": "$child_id",
          "child_journal_album_id": "$child_journal_album_id",
        });
    }
  }

  @override
  String get endpoint => APIEndpoint.endpoint;

  @override
  String get path {
    switch (type) {
      case AlbumType.get:
      case AlbumType.add:
      case AlbumType.detail:
      case AlbumType.addPhoto:
      case AlbumType.editCaption:
      case AlbumType.deletePhoto:
      case AlbumType.deleteAlbum:
        return "/manageClassChild";
      case AlbumType.getChild:
      case AlbumType.addChild:
      case AlbumType.detailChild:
      case AlbumType.addPhotoChild:
      case AlbumType.editCaptionChild:
      case AlbumType.deletePhotoChild:
      case AlbumType.deleteAlbumChild:
        return "/manageChildJournal";
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
