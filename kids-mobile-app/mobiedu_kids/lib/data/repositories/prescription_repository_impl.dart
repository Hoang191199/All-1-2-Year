import 'package:mobiedu_kids/data/providers/network/apis/prescription_api.dart';
import 'package:mobiedu_kids/domain/entities/list_children.dart';
import 'package:mobiedu_kids/domain/entities/prescription/prescription_data.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';
import 'package:mobiedu_kids/domain/repositories/prescription_repository.dart';

class PrescriptionRepositoryImpl extends PrescriptionRepository {
  @override
  Future<ResponseDataObject<Prescriptions>> fetchData() async {
    final response = await PrescriptionApi.fetchData().request();
    return ResponseDataObject<Prescriptions>.fromJson(response, (data) => Prescriptions.fromJson(data));
  }

  @override
  Future<ResponseNoData> takeMedicines(int? medicine_id, String? doing, int? child_id, int? max) async {
    final response = await PrescriptionApi.takeMedicines(medicine_id, doing, child_id, max).request();
    return ResponseNoData.fromJson(response);
  }

  @override
  Future<ResponseDataObject<ListChildren>> showChildActive() async {
    final response = await PrescriptionApi.showChildActive().request();
    return ResponseDataObject<ListChildren>.fromJson(response, (data) => ListChildren.fromJson(data));
  }

  @override
  Future<ResponseNoData> add(String? medicine_list, String? guide, String? time_per_day, String? begin, String? end, int? child_id ) async {
    final response = await PrescriptionApi.add(medicine_list, guide, time_per_day, begin, end, child_id).request();
    return ResponseNoData.fromJson(response);
  }

  @override
  Future<ResponseDataObject<Prescriptions>> getPrescriptionChild() async {
    final response = await PrescriptionApi.getPrescriptionChild().request();
    return ResponseDataObject<Prescriptions>.fromJson(response, (data) => Prescriptions.fromJson(data));
  }

  @override
  Future<ResponseNoData> register(String? medicine_list, String? guide, String? time_per_day, String? begin, String? end, int? child_id ) async {
    final response = await PrescriptionApi.register(medicine_list, guide, time_per_day, begin, end, child_id).request();
    return ResponseNoData.fromJson(response);
  }

}
