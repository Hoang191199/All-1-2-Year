import 'package:mobiedu_kids/domain/entities/feedbacks.dart';
import 'package:mobiedu_kids/domain/entities/response_data_array_object.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';

abstract class FbRepository {
  Future<ResponseDataArrayObject<Object>> create(
      String incognito, String child_id, String content);
  Future<ResponseDataObject<FeedBacks>> get(int page, String pagename);
  Future<ResponseDataObject<Object>> confirm(
      String feedback_id, String pagename);
  Future<ResponseDataObject<Object>> delete(
      String feedback_id, String pagename);
  Future<ResponseDataObject<Object>> deleteAll(String pagename);
}
