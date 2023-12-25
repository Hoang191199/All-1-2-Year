import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/domain/entities/content_media.dart';
import 'package:mobiedu_kids/domain/entities/media_info_details.dart';
import 'package:mobiedu_kids/domain/entities/media_post_details.dart';
import 'package:mobiedu_kids/domain/entities/media_sub1.dart';
import 'package:mobiedu_kids/domain/entities/media_sub2.dart';
import 'package:mobiedu_kids/domain/usecases/media_use_case.dart';

class MediaController extends GetxController {
  MediaController(this.mediaSupportUseCase, this.mediaComicUseCase,
      this.mediaVideoUseCase, this.detailMediaUseCase);

  final MediaSupportUseCase mediaSupportUseCase;
  final MediaComicUseCase mediaComicUseCase;
  final MediaVideoUseCase mediaVideoUseCase;
  final DetailMediaUseCase detailMediaUseCase;

  var categoriesSupport = Rx<MediaSub1<MediaSub2<MediaInfoDetails>>?>(null);
  var categoriesComic = Rx<MediaSub1<MediaInfoDetails>?>(null);
  var listVideo = RxList<MediaPostDetails?>([]);
  var listVideo2 = RxList<MediaPostDetails?>([]);
  var listdouble = RxList<List<MediaPostDetails?>>([]);
  final issupportLoading = false.obs;
  final iscomicLoading = false.obs;
  final isVideoLoading = false.obs;
  final isdetailLoading = false.obs;
  final isoutVideoLoading = RxList<RxBool>([]);
  var listMusic = RxList<MediaPostDetails?>([]);
  var listComedy = RxList<MediaPostDetails?>([]);
  var listCartoon = RxList<MediaPostDetails?>([]);
  final indexFilter = 0.obs;
  final indexFilter2 = 0.obs;
  final indexFilter3 = 0.obs;
  var detail = Rx<ContentMedia?>(null);

  support() async {
    issupportLoading(true);
    try{
    final response = await mediaSupportUseCase.execute("tro-ly-cha-me");
    if (response.code == 200) {
      categoriesSupport.value = response.data?.categories;
      categoriesSupport.value?.sub1?.sort((a, b) => a.id!.compareTo(b.id!));
    } else {
      showSnackbar(
          SnackbarType.error, "Không thành công", response.message ?? "");
    }
    issupportLoading(false);
    }
    catch(E) {
      issupportLoading(false);
    }
  }

  comic() async {
    iscomicLoading(true);
    try{
    final response = await mediaComicUseCase.execute("truyen");
    if (response.code == 200) {
      categoriesComic.value = response.data?.categories;
      categoriesComic.value?.sub1?.sort((a, b) => a.id!.compareTo(b.id!));
    } else {
      showSnackbar(
          SnackbarType.error, "Không thành công", response.message ?? "");
    }
    iscomicLoading(false);
    }
    catch(E) {
      iscomicLoading(false);
    }
  }

  video(String category, String filter_by, int page, int index) async {
    isoutVideoLoading[index](true);
    try{
    final response =
        await mediaVideoUseCase.execute(Tuple3(category, filter_by, page));
    if (response.code == 200) {
      listVideo.assignAll(response.data?.posts ?? []);
    } else {
      showSnackbar(
          SnackbarType.error, "Không thành công", response.message ?? "");
    }
    isoutVideoLoading[index](false);
    }
    catch(E) {
      isoutVideoLoading[index](false);
    }
  }

  videomain(String category, String filter_by, int page) async {
    isVideoLoading(true);
    try{
    final response =
        await mediaVideoUseCase.execute(Tuple3(category, filter_by, page));
    if (response.code == 200) {
      listVideo2.assignAll(response.data?.posts ?? []);
    } else {
      showSnackbar(
          SnackbarType.error, "Không thành công", response.message ?? "");
    }
    isVideoLoading(false);
    }
    catch(E) {
      isVideoLoading(false);
    }
  }

  getDetail(String id) async {
    isdetailLoading(true);
    try{
    detail.value = null;
    final res = await detailMediaUseCase.execute(id);
    detail.value = res;
    isdetailLoading(false);
    }
    catch(E) {
      isdetailLoading(false);
    }
  }
}
