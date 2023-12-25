import 'package:mobiedu_kids/domain/entities/infomation/data_menu.dart';
import 'package:mobiedu_kids/domain/entities/infomation/data_posts.dart';
import 'package:mobiedu_kids/domain/entities/infomation/info_child.dart';
import 'package:mobiedu_kids/domain/entities/infomation/schedule_child.dart';
import 'package:mobiedu_kids/domain/entities/post_details.dart';
import 'package:mobiedu_kids/domain/entities/response_data_comment.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';

abstract class InformationRepository {
  Future<ResponseDataObject<InfoChild>> fetchData();
  Future<ResponseDataObject<MenuClass>> getMenu();
  Future<ResponseDataObject<ScheduleChild>> getSchedule();
  Future<ResponseDataObject<DataPost>> newPost();
  Future<ResponseNoData> actionLike(String action, String idPost);
  Future<ResponseNoData> actionComment(String message, String idPost);
  Future<ResponseDataComment<PostDetails>> getPostDetail(String page, String idPost);
}
