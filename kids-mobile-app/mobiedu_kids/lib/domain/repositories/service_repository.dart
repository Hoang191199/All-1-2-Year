import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';
import 'package:mobiedu_kids/domain/entities/service/history_data.dart';
import 'package:mobiedu_kids/domain/entities/service/history_service_parent.dart';
import 'package:mobiedu_kids/domain/entities/service/list_usage.dart';
import 'package:mobiedu_kids/domain/entities/service/services_countbased.dart';

abstract class ServiceRepository {
  Future<ResponseDataObject<ListUsage>> fetchData();
  Future<ResponseNoData> update();
  Future<ResponseDataObject<HistoryData>> history();
  Future<ResponseDataObject<ServicesCountbased>> serviceParent();
  Future<ResponseNoData> register();
  Future<ResponseDataObject<HistoryServiceParent>> historyParent();
}
