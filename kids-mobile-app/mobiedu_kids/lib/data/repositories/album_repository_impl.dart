import 'dart:typed_data';
import 'package:mobiedu_kids/data/providers/network/apis/album_api.dart';
import 'package:mobiedu_kids/domain/entities/journal.dart';
import 'package:mobiedu_kids/domain/entities/journals.dart';
import 'package:mobiedu_kids/domain/entities/response_data_array_object.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/repositories/album_repository.dart';

class AlbumRepositoryImpl extends AlbumRepository {
  @override
  Future<ResponseDataObject<Journals>> get(
      String group_name, String child_id, int year) async {
    final response = await AlbumAPI.get(group_name, child_id, year).request();
    return ResponseDataObject.fromJson(
        response, (data) => Journals.fromJson(data));
  }

  @override
  Future<ResponseDataObject<Journal>> detail(
      String group_name, String child_id) async {
    final response = await AlbumAPI.detail(group_name, child_id).request();
    return ResponseDataObject<Journal>.fromJson(
        response, (data) => Journal.fromJson(data));
  }

  @override
  Future<ResponseDataArrayObject<Object>> add(
      String group_name,
      String child_id,
      String caption,
      List<Uint8List?> multiFile,
      int fileNum) async {
    final response =
        await AlbumAPI.add(group_name, child_id, caption, multiFile, fileNum)
            .request();
    return ResponseDataArrayObject<Object>.fromJson(response, (data) => Object);
  }

  @override
  Future<ResponseDataArrayObject<Object>> addPhoto(
      String group_name,
      String child_id,
      String child_journal_album_id,
      List<Uint8List?> multiFile,
      int fileNum) async {
    final response = await AlbumAPI.addPhoto(
            group_name, child_id, child_journal_album_id, multiFile, fileNum)
        .request();
    return ResponseDataArrayObject<Object>.fromJson(response, (data) => Object);
  }

  @override
  Future<ResponseDataArrayObject<Object>> editCaption(String group_name,
      String child_id, String child_journal_album_id, String caption) async {
    final response = await AlbumAPI.editCaption(
            group_name, child_id, child_journal_album_id, caption)
        .request();
    return ResponseDataArrayObject<Object>.fromJson(response, (data) => Object);
  }

  @override
  Future<ResponseDataArrayObject<Object>> deletePhoto(
      String group_name, String child_id, String child_journal_id) async {
    final response =
        await AlbumAPI.deletePhoto(group_name, child_id, child_journal_id)
            .request();
    return ResponseDataArrayObject<Object>.fromJson(response, (data) => Object);
  }

  @override
  Future<ResponseDataArrayObject<Object>> deleteAlbum(
      String group_name, String child_id, String child_journal_album_id) async {
    final response =
        await AlbumAPI.deleteAlbum(group_name, child_id, child_journal_album_id)
            .request();
    return ResponseDataArrayObject<Object>.fromJson(response, (data) => Object);
  }

  @override
  Future<ResponseDataObject<Journals>> getChild(
      String child_id, int year) async {
    final response = await AlbumAPI.getChild(child_id, year).request();
    return ResponseDataObject.fromJson(
        response, (data) => Journals.fromJson(data));
  }

  @override
  Future<ResponseDataObject<Journal>> detailChild(
      String child_id, String child_journal_album_id) async {
    final response =
        await AlbumAPI.detailChild(child_id, child_journal_album_id).request();
    return ResponseDataObject<Journal>.fromJson(
        response, (data) => Journal.fromJson(data));
  }

  @override
  Future<ResponseDataArrayObject<Object>> addChild(String child_id,
      String caption, List<Uint8List?> multiFile, int fileNum) async {
    final response =
        await AlbumAPI.addChild(child_id, caption, multiFile, fileNum)
            .request();
    return ResponseDataArrayObject<Object>.fromJson(response, (data) => Object);
  }

  @override
  Future<ResponseDataArrayObject<Object>> addPhotoChild(
      String child_id,
      String child_journal_album_id,
      List<Uint8List?> multiFile,
      int fileNum) async {
    final response = await AlbumAPI.addPhotoChild(
            child_id, child_journal_album_id, multiFile, fileNum)
        .request();
    return ResponseDataArrayObject<Object>.fromJson(response, (data) => Object);
  }

  @override
  Future<ResponseDataArrayObject<Object>> editCaptionChild(
      String child_id, String child_journal_album_id, String caption) async {
    final response = await AlbumAPI.editCaptionChild(
            child_id, child_journal_album_id, caption)
        .request();
    return ResponseDataArrayObject<Object>.fromJson(response, (data) => Object);
  }

  @override
  Future<ResponseDataArrayObject<Object>> deletePhotoChild(
      String child_id, String child_journal_id) async {
    final response =
        await AlbumAPI.deletePhotoChild(child_id, child_journal_id).request();
    return ResponseDataArrayObject<Object>.fromJson(response, (data) => Object);
  }

  @override
  Future<ResponseDataArrayObject<Object>> deleteAlbumChild(
      String child_id, String child_journal_album_id) async {
    final response =
        await AlbumAPI.deleteAlbumChild(child_id, child_journal_album_id)
            .request();
    return ResponseDataArrayObject<Object>.fromJson(response, (data) => Object);
  }
}
