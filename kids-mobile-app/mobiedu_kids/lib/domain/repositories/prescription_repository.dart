import 'package:mobiedu_kids/domain/entities/list_children.dart';
import 'package:mobiedu_kids/domain/entities/prescription/prescription_data.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';

abstract class PrescriptionRepository {
  Future<ResponseDataObject<Prescriptions>> fetchData();
  Future<ResponseNoData> takeMedicines(int? medicine_id, String? doing, int? child_id, int? max);
  Future<ResponseDataObject<ListChildren>> showChildActive();
  Future<ResponseNoData> add(String? medicine_list, String? guide, String? time_per_day, String? begin, String? end, int? child_id);
  Future<ResponseDataObject<Prescriptions>> getPrescriptionChild();
  Future<ResponseNoData> register(String? medicine_list, String? guide, String? time_per_day, String? begin, String? end, int? child_id);
}
