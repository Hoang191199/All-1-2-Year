import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';
import 'package:mobiedu_kids/domain/entities/shuttle/assign_in_shuttle.dart';
import 'package:mobiedu_kids/domain/entities/shuttle/classes_in_shuttle.dart';
import 'package:mobiedu_kids/domain/entities/shuttle/history.dart';
import 'package:mobiedu_kids/domain/entities/shuttle/list_child.dart';
import 'package:mobiedu_kids/domain/entities/shuttle/shuttle.dart';

abstract class ShuttleRepository {
  Future<ResponseDataObject<Shuttle>> fetchData();
  Future<ResponseNoData> pickUp(int pickup_id, int child_id);
  Future<ResponseNoData> savePickup(int pickup_id, int child_id, String? late_pickup_free, int? total_amount, String? pickup_at, String? note, List<String>? service, int? index, String? status);
  Future<ResponseNoData> cancel(int pickup_id, int child_id);
  Future<ResponseDataObject<ClassesInShuttle>> listClass();
  Future<ResponseDataObject<ListChild>> listChild();
  Future<ResponseNoData> addChild();
  Future<ResponseDataObject<AssignInShuttle>> assign();
  Future<ResponseDataObject<History>> history();
}
