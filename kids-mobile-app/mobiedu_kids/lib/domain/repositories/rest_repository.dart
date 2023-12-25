import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';
import 'package:mobiedu_kids/domain/entities/rest/rest_data.dart';

abstract class RestRepository {
  Future<ResponseDataObject<RestData>> fetchData(String? formDate, String? toDate);
  Future<ResponseNoData> register();
}
