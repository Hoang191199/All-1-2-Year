import 'package:mobiedu_kids/data/providers/network/apis/shuttle_api.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';
import 'package:mobiedu_kids/domain/entities/shuttle/assign_in_shuttle.dart';
import 'package:mobiedu_kids/domain/entities/shuttle/classes_in_shuttle.dart';
import 'package:mobiedu_kids/domain/entities/shuttle/history.dart';
import 'package:mobiedu_kids/domain/entities/shuttle/list_child.dart';
import 'package:mobiedu_kids/domain/entities/shuttle/shuttle.dart';
import 'package:mobiedu_kids/domain/repositories/shuttle_repositiory.dart';

class ShuttleRepositoryImpl extends ShuttleRepository {
  @override
  Future<ResponseDataObject<Shuttle>> fetchData() async {
    final response = await ShuttleApi.fetchData().request();
    return ResponseDataObject<Shuttle>.fromJson(response, (data) => Shuttle.fromJson(data));
  }

  @override
  Future<ResponseNoData> pickUp(int pickup_id, int child_id) async {
    final response = await ShuttleApi.pickUp(pickup_id, child_id).request();
    return ResponseNoData.fromJson(response);
  }

  @override
  Future<ResponseNoData> savePickup(int pickup_id, int child_id, String? late_pickup_free, int? total_amount, 
    String? pickup_at, String? note, List<String>? service, int? index, String? status) async {
    final response = await ShuttleApi.savePickup(pickup_id, child_id, late_pickup_free, total_amount, pickup_at, note, service, index, status).request();
    return ResponseNoData.fromJson(response);
  }

  @override
  Future<ResponseNoData> cancel(int pickup_id, int child_id) async {
    final response = await ShuttleApi.cancel(pickup_id, child_id).request();
    return ResponseNoData.fromJson(response);
  }

  @override
  Future<ResponseDataObject<ClassesInShuttle>> listClass() async {
    final response = await ShuttleApi.listClass().request();
    return ResponseDataObject<ClassesInShuttle>.fromJson(response, (data) => ClassesInShuttle.fromJson(data));
  }

  @override
  Future<ResponseDataObject<ListChild>> listChild() async {
    final response = await ShuttleApi.listChild().request();
    return ResponseDataObject<ListChild>.fromJson(response, (data) => ListChild.fromJson(data));
  }

  @override
  Future<ResponseNoData> addChild() async {
    final response = await ShuttleApi.addChild().request();
    return ResponseNoData.fromJson(response);
  }

  @override
  Future<ResponseDataObject<AssignInShuttle>> assign() async {
    final response = await ShuttleApi.assign().request();
    return ResponseDataObject<AssignInShuttle>.fromJson(response, (data) => AssignInShuttle.fromJson(data));
  }

  @override
  Future<ResponseDataObject<History>> history() async {
    final response = await ShuttleApi.history().request();
    return ResponseDataObject<History>.fromJson(response, (data) => History.fromJson(data));
  }
}
