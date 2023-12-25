import 'dart:typed_data';
import 'package:mobiedu_kids/domain/entities/journal.dart';
import 'package:mobiedu_kids/domain/entities/journals.dart';
import 'package:mobiedu_kids/domain/entities/response_data_array_object.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';

abstract class AlbumRepository {
  Future<ResponseDataObject<Journals>> get(
      String group_name, String child_id, int year);
  Future<ResponseDataArrayObject<Object>> add(String group_name,
      String child_id, String caption, List<Uint8List?> multiFile, int fileNum);
  Future<ResponseDataObject<Journal>> detail(
      String group_name, String child_journal_album_id);
  Future<ResponseDataArrayObject<Object>> addPhoto(
      String group_name,
      String child_id,
      String child_journal_album_id,
      List<Uint8List?> multiFile,
      int fileNum);
  Future<ResponseDataArrayObject<Object>> editCaption(String group_name,
      String child_id, String child_journal_album_id, String caption);
  Future<ResponseDataArrayObject<Object>> deletePhoto(
      String group_name, String child_id, String child_journal_id);
  Future<ResponseDataArrayObject<Object>> deleteAlbum(
      String group_name, String child_id, String child_journal_album_id);
  Future<ResponseDataObject<Journals>> getChild(String child_id, int year);
  Future<ResponseDataArrayObject<Object>> addChild(
      String child_id, String caption, List<Uint8List?> multiFile, int fileNum);
  Future<ResponseDataObject<Journal>> detailChild(
      String child_id, String child_journal_album_id);
  Future<ResponseDataArrayObject<Object>> addPhotoChild(String chidl_id,
      String child_journal_album_id, List<Uint8List?> multiFile, int fileNum);
  Future<ResponseDataArrayObject<Object>> editCaptionChild(
      String child_id, String child_journal_album_id, String caption);
  Future<ResponseDataArrayObject<Object>> deletePhotoChild(
      String child_id, String child_journal_id);
  Future<ResponseDataArrayObject<Object>> deleteAlbumChild(
      String child_id, String child_journal_album_id);
}
