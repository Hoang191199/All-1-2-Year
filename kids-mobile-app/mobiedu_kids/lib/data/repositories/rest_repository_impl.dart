import 'package:mobiedu_kids/data/providers/network/apis/rest_api.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';
import 'package:mobiedu_kids/domain/entities/rest/rest_data.dart';
import 'package:mobiedu_kids/domain/repositories/rest_repository.dart';

class RestRepositoryImpl extends RestRepository {
  @override
  Future<ResponseDataObject<RestData>> fetchData(String? formDate, String? toDate) async {
    final response = await RestAPI.fetchData(formDate, toDate).request();
    return ResponseDataObject<RestData>.fromJson(response, (data) => RestData.fromJson(data));
  }

  @override
  Future<ResponseNoData> register() async {
    final response = await RestAPI.register().request();
    return ResponseNoData.fromJson(response);
  }
}
