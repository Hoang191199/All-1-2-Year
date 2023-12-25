import 'package:mobiedu_kids/data/providers/network/apis/feedback_api.dart';
import 'package:mobiedu_kids/domain/entities/feedbacks.dart';
import 'package:mobiedu_kids/domain/entities/response_data_array_object.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/repositories/feedback_repository.dart';

class FbRepositoryImpl extends FbRepository {
  @override
  Future<ResponseDataArrayObject<Object>> create(
      String incognito, String child_id, String content) async {
    final response = await FbAPI.create(incognito, child_id, content).request();
    return ResponseDataArrayObject<Object>.fromJson(response, (data) => Object);
  }

  @override
  Future<ResponseDataObject<FeedBacks>> get(int page, String pagename) async {
    final response = await FbAPI.get(page, pagename).request();
    return ResponseDataObject<FeedBacks>.fromJson(
        response, (data) => FeedBacks.fromJson(data));
  }

  @override
  Future<ResponseDataObject<Object>> confirm(
      String feedback_id, String pagename) async {
    final response = await FbAPI.confirm(feedback_id, pagename).request();
    return ResponseDataObject<Object>.fromJson(response, (data) => Object);
  }

  @override
  Future<ResponseDataObject<Object>> delete(
      String feedback_id, String pagename) async {
    final response = await FbAPI.delete(feedback_id, pagename).request();
    return ResponseDataObject<Object>.fromJson(response, (data) => Object);
  }

  @override
  Future<ResponseDataObject<Object>> deleteAll(String pagename) async {
    final response = await FbAPI.delete_all(pagename).request();
    return ResponseDataObject<Object>.fromJson(response, (data) => Object);
  }
}
