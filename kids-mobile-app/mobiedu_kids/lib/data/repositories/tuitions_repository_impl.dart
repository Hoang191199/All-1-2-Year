import 'package:mobiedu_kids/data/providers/network/apis/tuition_api.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/tuitions/tuition_childs.dart';
import 'package:mobiedu_kids/domain/entities/tuitions/tuitions.dart';
import 'package:mobiedu_kids/domain/entities/tuitions/tuitions_item.dart';
import 'package:mobiedu_kids/domain/repositories/tuitions_repository.dart';

class TuitionsRepositoryImpl extends TuitionsRepository {
  @override
  Future<ResponseDataObject<Tuitions>> fetchData(int page) async {
    final response = await TuitionsApi.fetchData(page).request();
    return ResponseDataObject<Tuitions>.fromJson(response, (data) => Tuitions.fromJson(data));
  }

  @override
  Future<ResponseDataObject<TuitionChilds>> detail(int tuitions_id) async {
    final response = await TuitionsApi.detail(tuitions_id).request();
    return ResponseDataObject<TuitionChilds>.fromJson(response, (data) => TuitionChilds.fromJson(data));
  }

  @override
  Future<ResponseDataObject<TuitionItems>> itemTuitions(int tuition_child_id) async {
    final response = await TuitionsApi.itemTuitions(tuition_child_id).request();
    return ResponseDataObject<TuitionItems>.fromJson(response, (data) => TuitionItems.fromJson(data));
  }

  @override
  Future<ResponseDataObject<Tuitions>> tuitionParent(int page) async {
    final response = await TuitionsApi.tuitionParent(page).request();
    return ResponseDataObject<Tuitions>.fromJson(response, (data) => Tuitions.fromJson(data));
  }

  @override
  Future<ResponseDataObject<TuitionItems>> detailTuitionParent(int tuition_child_id) async {
    final response = await TuitionsApi.detailTuitionParent(tuition_child_id).request();
    return ResponseDataObject<TuitionItems>.fromJson(response, (data) => TuitionItems.fromJson(data));
  }
}
