import 'package:mobiedu_kids/data/providers/network/apis/media_api.dart';
import 'package:mobiedu_kids/domain/entities/content_media.dart';
import 'package:mobiedu_kids/domain/entities/media_categories.dart';
import 'package:mobiedu_kids/domain/entities/media_info_details.dart';
import 'package:mobiedu_kids/domain/entities/media_posts.dart';
import 'package:mobiedu_kids/domain/entities/media_sub1.dart';
import 'package:mobiedu_kids/domain/entities/media_sub2.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/repositories/media_repository.dart';

class MediaRepositoryImpl extends MediaRepository {
  @override
  Future<
      ResponseDataObject<
          MediaCategories<MediaSub1<MediaSub2<MediaInfoDetails>>>>> support(
      String category) async {
    final response = await MediaAPI.support(category).request();
    return ResponseDataObject<
            MediaCategories<MediaSub1<MediaSub2<MediaInfoDetails>>>>.fromJson(
        response,
        (data) =>
            MediaCategories<MediaSub1<MediaSub2<MediaInfoDetails>>>.fromJson(
                data,
                (dta) => MediaSub1<MediaSub2<MediaInfoDetails>>.fromJson(
                    dta,
                    (dt) => MediaSub2<MediaInfoDetails>.fromJson(
                        dt, (d) => MediaInfoDetails.fromJson(d)))));
  }

  @override
  Future<ResponseDataObject<MediaCategories<MediaSub1<MediaInfoDetails>>>>
      comic(String category) async {
    final response = await MediaAPI.comic(category).request();
    return ResponseDataObject<
            MediaCategories<MediaSub1<MediaInfoDetails>>>.fromJson(
        response,
        (data) => MediaCategories<MediaSub1<MediaInfoDetails>>.fromJson(
            data,
            (dt) => MediaSub1<MediaInfoDetails>.fromJson(
                dt, (d) => MediaInfoDetails.fromJson(d))));
  }

  @override
  Future<ResponseDataObject<MediaPosts>> video(
      String category, String filter_by, int page) async {
    final response = await MediaAPI.video(category, filter_by, page).request();
    return ResponseDataObject<MediaPosts>.fromJson(
        response, (data) => MediaPosts.fromJson(data));
  }

  @override
  Future<ContentMedia> detail(String id) async {
    final response = await MediaAPI.detail(id).request();
    return ContentMedia.fromJson(response);
  }
}
