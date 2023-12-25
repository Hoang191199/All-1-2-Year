import 'package:mobiedu_kids/domain/entities/content_media.dart';
import 'package:mobiedu_kids/domain/entities/media_categories.dart';
import 'package:mobiedu_kids/domain/entities/media_info_details.dart';
import 'package:mobiedu_kids/domain/entities/media_posts.dart';
import 'package:mobiedu_kids/domain/entities/media_sub1.dart';
import 'package:mobiedu_kids/domain/entities/media_sub2.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';

abstract class MediaRepository {
  Future<
      ResponseDataObject<
          MediaCategories<MediaSub1<MediaSub2<MediaInfoDetails>>>>> support(
      String category);
  Future<ResponseDataObject<MediaCategories<MediaSub1<MediaInfoDetails>>>>
      comic(String category);
  Future<ResponseDataObject<MediaPosts>> video(
      String category, String filter_by, int page);
  Future<ContentMedia> detail(String id);
}
