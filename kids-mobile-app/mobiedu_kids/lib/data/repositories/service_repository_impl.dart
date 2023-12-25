import 'package:mobiedu_kids/data/providers/network/apis/service_api.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';
import 'package:mobiedu_kids/domain/entities/service/history_data.dart';
import 'package:mobiedu_kids/domain/entities/service/history_service_parent.dart';
import 'package:mobiedu_kids/domain/entities/service/list_usage.dart';
import 'package:mobiedu_kids/domain/entities/service/services_countbased.dart';
import 'package:mobiedu_kids/domain/repositories/service_repository.dart';

class ServiceRepositoryImpl extends ServiceRepository {
  @override
  Future<ResponseDataObject<ListUsage>> fetchData() async {
    final response = await ServiceApi.fetchData().request();
    return ResponseDataObject<ListUsage>.fromJson(response, (data) => ListUsage.fromJson(data));
  }

  @override
  Future<ResponseNoData> update() async {
    final response = await ServiceApi.update().request();
    return ResponseNoData.fromJson(response);
  }

  @override
  Future<ResponseDataObject<HistoryData>> history() async {
    final response = await ServiceApi.history().request();
    return ResponseDataObject<HistoryData>.fromJson(response, (data) => HistoryData.fromJson(data));
  }

  @override
  Future<ResponseDataObject<ServicesCountbased>> serviceParent() async {
    final response = await ServiceApi.serviceParent().request();
    return ResponseDataObject<ServicesCountbased>.fromJson(response, (data) => ServicesCountbased.fromJson(data));
  }

  @override
  Future<ResponseNoData> register() async {
    final response = await ServiceApi.register().request();
    return ResponseNoData.fromJson(response);
  }

  @override
  Future<ResponseDataObject<HistoryServiceParent>> historyParent() async {
    final response = await ServiceApi.historyParent().request();
    return ResponseDataObject<HistoryServiceParent>.fromJson(response, (data) => HistoryServiceParent.fromJson(data));
  }
}
