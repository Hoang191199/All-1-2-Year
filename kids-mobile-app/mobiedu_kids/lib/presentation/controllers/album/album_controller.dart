import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/domain/entities/image_metadata.dart';
import 'package:mobiedu_kids/domain/entities/journals_details.dart';
import 'package:mobiedu_kids/domain/entities/journals_info.dart';
import 'package:mobiedu_kids/domain/usecases/album_use_case.dart';

class AlbumController extends GetxController {
  AlbumController(
    this.getAlbumUseCase,
    this.detailAlbumUseCase,
    this.addAlbumUseCase,
    this.addPhotoUseCase,
    this.editCaptionUseCase,
    this.deletePhotoUseCase,
    this.deleteAlbumUseCase,
    this.getAlbumChildUseCase,
    this.detailAlbumChildUseCase,
    this.addAlbumChildUseCase,
    this.addPhotoChildUseCase,
    this.editCaptionChildUseCase,
    this.deletePhotoChildUseCase,
    this.deleteAlbumChildUseCase,
  );

  GetAlbumUseCase getAlbumUseCase;
  DetailAlbumUseCase detailAlbumUseCase;
  AddAlbumUseCase addAlbumUseCase;
  AddPhotoUseCase addPhotoUseCase;
  EditCaptionUseCase editCaptionUseCase;
  DeletePhotoUseCase deletePhotoUseCase;
  DeleteAlbumUseCase deleteAlbumUseCase;
  GetAlbumChildUseCase getAlbumChildUseCase;
  DetailAlbumChildUseCase detailAlbumChildUseCase;
  AddAlbumChildUseCase addAlbumChildUseCase;
  AddPhotoChildUseCase addPhotoChildUseCase;
  EditCaptionChildUseCase editCaptionChildUseCase;
  DeletePhotoChildUseCase deletePhotoChildUseCase;
  DeleteAlbumChildUseCase deleteAlbumChildUseCase;
  late TextEditingController caption;
  var listAlbum = RxList<JournalsInfo?>([]);
  var diverse = RxList<List<JournalsInfo?>>([]);
  var listPhoto = RxList<ImageMetaData?>([]);
  var detailAlbum = Rx<JournalsDetails?>(null);
  final currentStudent = 0.obs;
  final store = Get.find<LocalStorageService>();
  final isLoading = false.obs;
  final isDetailLoading = false.obs;
  var indexDateNow = Rx<DateTime>(DateTime.now());
  var indexDate = Rx<DateTime>(DateTime.now());
  var index = 0.obs;
  final submit = false.obs;

  @override
  void onInit() async {
    caption = TextEditingController(text: "");
    super.onInit();
  }

  fetch(String groupname, String child_id, int year) async {
    isLoading(true);
    // try {
    final res =
        await getAlbumUseCase.execute(Tuple3(groupname, child_id, year));
    listAlbum.assignAll(res.data?.journals ?? []);
    final Map<String?, List<JournalsInfo?>> groupedMap =
        groupBy(listAlbum, (obj) => obj?.created_at);
    diverse.value = groupedMap.values.toList();
    // } catch (e) {
    //   Get.to(() => LoginPage());
    // }
    isLoading(false);
  }

  fetchChild(String child_id, int year) async {
    isLoading(true);
    // try {
    final res = await getAlbumChildUseCase.execute(Tuple2(child_id, year));
    if (res.code == 200) {
      listAlbum.assignAll(res.data?.journals ?? []);
      final Map<String?, List<JournalsInfo?>> groupedMap =
          groupBy(listAlbum, (obj) => obj?.created_at);
      diverse.value = groupedMap.values.toList();
    }
    // } catch (e) {
    //   Get.to(() => LoginPage());
    // }
    isLoading(false);
  }

  detail(String groupname, String child_jounal_album_id) async {
    isDetailLoading(true);
    final res = await detailAlbumUseCase
        .execute(Tuple2(groupname, child_jounal_album_id));
    if (res.code == 200) {
      detailAlbum.value = res.data?.journal;
    }
    isDetailLoading(false);
  }

  detailChild(String child_id, String child_jounal_album_id) async {
    isDetailLoading(true);
    final res = await detailAlbumChildUseCase
        .execute(Tuple2(child_id, child_jounal_album_id));
    detailAlbum.value = res.data?.journal;
    isDetailLoading(false);
  }

  addAlbum(String group_name, String child_id, String caption,
      List<Uint8List> multiFile, int fileNum) async {
    final res = await addAlbumUseCase
        .execute(Tuple5(group_name, child_id, caption, multiFile, fileNum));
    if (res.code == 200) {
      showSnackbar(
          SnackbarType.success, "Thêm thành công", "Thêm album thành công");
    } else {
      showSnackbar(SnackbarType.error, "Thêm thất bại", "${res.message}");
    }
  }

  addAlbumChild(String child_id, String caption, List<Uint8List> multiFile,
      int fileNum) async {
    final res = await addAlbumChildUseCase
        .execute(Tuple4(child_id, caption, multiFile, fileNum));
    if (res.code == 200) {
      showSnackbar(
          SnackbarType.success, "Thêm thành công", "Thêm album thành công");
    } else {
      showSnackbar(SnackbarType.error, "Thêm thất bại", "${res.message}");
    }
  }

  addPhoto(String group_name, String child_id, String child_journal_album_id,
      List<Uint8List?> multiFile, int fileNum) async {
    final res = await addPhotoUseCase.execute(Tuple5(
        group_name, child_id, child_journal_album_id, multiFile, fileNum));
    if (res.code == 200) {
      showSnackbar(
          SnackbarType.success, "Thêm thành công", "Thêm ảnh album thành công");
    } else {
      showSnackbar(SnackbarType.error, "Thêm thất bại", "${res.message}");
    }
  }

  addPhotoChild(String child_id, String child_journal_album_id,
      List<Uint8List?> multiFile, int fileNum) async {
    final res = await addPhotoChildUseCase
        .execute(Tuple4(child_id, child_journal_album_id, multiFile, fileNum));
    if (res.code == 200) {
      showSnackbar(
          SnackbarType.success, "Thêm thành công", "Thêm ảnh album thành công");
    } else {
      showSnackbar(SnackbarType.error, "Thêm thất bại", "${res.message}");
    }
  }

  editCaption(String group_name, String child_id, String child_journal_album_id,
      String caption) async {
    final res = await editCaptionUseCase
        .execute(Tuple4(group_name, child_id, child_journal_album_id, caption));
    if (res.code == 200) {
      showSnackbar(SnackbarType.success, "Thay đổi thành công",
          "Đổi tiêu đề thành công");
    } else {
      showSnackbar(SnackbarType.error, "Thay đổi thất bại", "${res.message}");
    }
  }

  editCaptionChild(
      String child_id, String child_journal_album_id, String caption) async {
    final res = await editCaptionChildUseCase
        .execute(Tuple3(child_id, child_journal_album_id, caption));
    if (res.code == 200) {
      showSnackbar(SnackbarType.success, "Thay đổi thành công",
          "Đổi tiêu đề thành công");
    } else {
      showSnackbar(SnackbarType.error, "Thay đổi thất bại", "${res.message}");
    }
  }

  deletePhoto(
      String group_name, String child_id, String child_journal_id) async {
    final res = await deletePhotoUseCase
        .execute(Tuple3(group_name, child_id, child_journal_id));
    if (res.code == 200) {
      showSnackbar(
          SnackbarType.success, "Xóa thành công", "Xóa ảnh thành công");
    } else {
      showSnackbar(SnackbarType.error, "Xóa thất bại", "${res.message}");
    }
  }

  deletePhotoChild(String child_id, String child_journal_id) async {
    final res = await deletePhotoChildUseCase
        .execute(Tuple2(child_id, child_journal_id));
    if (res.code == 200) {
      showSnackbar(
          SnackbarType.success, "Xóa thành công", "Xóa ảnh thành công");
    } else {
      showSnackbar(SnackbarType.error, "Xóa thất bại", "${res.message}");
    }
  }

  delete(
      String group_name, String child_id, String child_journal_album_id) async {
    final res = await deleteAlbumUseCase
        .execute(Tuple3(group_name, child_id, child_journal_album_id));
    if (res.code == 200) {
      showSnackbar(
          SnackbarType.success, "Xóa thành công", "Xóa album thành công");
    } else {
      showSnackbar(SnackbarType.error, "Xóa thất bại", "${res.message}");
    }
  }

  deleteChild(String child_id, String child_journal_album_id) async {
    final res = await deleteAlbumChildUseCase
        .execute(Tuple2(child_id, child_journal_album_id));
    if (res.code == 200) {
      showSnackbar(
          SnackbarType.success, "Xóa thành công", "Xóa album thành công");
    } else {
      showSnackbar(SnackbarType.error, "Xóa thất bại", "${res.message}");
    }
  }
}
