import 'package:mobiedu_kids/data/providers/network/apis/information_api.dart';
import 'package:mobiedu_kids/domain/entities/infomation/data_menu.dart';
import 'package:mobiedu_kids/domain/entities/infomation/data_posts.dart';
import 'package:mobiedu_kids/domain/entities/infomation/info_child.dart';
import 'package:mobiedu_kids/domain/entities/infomation/schedule_child.dart';
import 'package:mobiedu_kids/domain/entities/post_details.dart';
import 'package:mobiedu_kids/domain/entities/response_data_comment.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';
import 'package:mobiedu_kids/domain/repositories/information_repository.dart';

class InfomationRepositoryImpl extends InformationRepository {
  @override
  Future<ResponseDataObject<InfoChild>> fetchData() async {
    final response = await InformationApi.fetchData().request();
    return ResponseDataObject<InfoChild>.fromJson(response, (data) => InfoChild.fromJson(data));
  }

  @override
  Future<ResponseDataObject<MenuClass>> getMenu() async {
    final response = await InformationApi.getMenu().request();
    return ResponseDataObject<MenuClass>.fromJson(response, (data) => MenuClass.fromJson(data));
  }

  @override
  Future<ResponseDataObject<ScheduleChild>> getSchedule() async {
    final response = await InformationApi.getSchedule().request();
    return ResponseDataObject<ScheduleChild>.fromJson(response, (data) => ScheduleChild.fromJson(data));
  }

  @override
  Future<ResponseDataObject<DataPost>> newPost() async {
    final response = await InformationApi.newPost().request();
    return ResponseDataObject<DataPost>.fromJson(response, (data) => DataPost.fromJson(data));
  }

  @override
  Future<ResponseNoData> actionLike(String action, String idPost) async {
    final response = await InformationApi.actionLike(action, idPost).request();
    return ResponseNoData.fromJson(response);
  }

  @override
  Future<ResponseNoData> actionComment(String message, String idPost) async {
    final response = await InformationApi.actionComment(message, idPost).request();
    return ResponseNoData.fromJson(response);
  }

  @override
  Future<ResponseDataComment<PostDetails>> getPostDetail(String page, String idPost) async {
    final response = await InformationApi.getPostDetail(page, idPost).request();
    return ResponseDataComment<PostDetails>.fromJson(response, (data) => PostDetails.fromJson(data));
  }
}
