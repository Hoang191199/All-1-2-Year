import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/tuitions/tuition_childs.dart';
import 'package:mobiedu_kids/domain/entities/tuitions/tuitions.dart';
import 'package:mobiedu_kids/domain/entities/tuitions/tuitions_item.dart';

abstract class TuitionsRepository {
  Future<ResponseDataObject<Tuitions>> fetchData(int page);
  Future<ResponseDataObject<TuitionChilds>> detail(int tuitions_id);
  Future<ResponseDataObject<TuitionItems>> itemTuitions(int tuition_child_id);
  Future<ResponseDataObject<Tuitions>> tuitionParent(int page);
  Future<ResponseDataObject<TuitionItems>> detailTuitionParent(int tuition_child_id);
}
