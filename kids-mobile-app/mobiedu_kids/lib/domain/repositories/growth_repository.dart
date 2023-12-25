import 'dart:typed_data';
import 'package:mobiedu_kids/domain/entities/growths.dart';
import 'package:mobiedu_kids/domain/entities/response_data_array_object.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';

abstract class GrowthRepository {
  Future<ResponseDataObject<Growths>> get(String group_name, String child_id);
  Future<ResponseDataObject<Growths>> getChild(
      String child_id, String month_begin, String month_end);
  Future<ResponseDataArrayObject<Object>> add(
      String group_name,
      String child_id,
      String height,
      String weight,
      String nutriture_status,
      String ear,
      String eye,
      String blood_pressure,
      String heart,
      String nose,
      String description,
      String date,
      Uint8List? file);
  Future<ResponseDataArrayObject<Object>> edit(
      String group_name,
      String child_id,
      String child_growth_id,
      String height,
      String weight,
      String nutriture_status,
      String ear,
      String eye,
      String blood_pressure,
      String heart,
      String nose,
      String description,
      String date,
      Uint8List? file);
  // Future<ResponseDataArrayObject<Object>> editalt(
  //     String group_name,
  //     String child_id,
  //     String child_growth_id,
  //     String height,
  //     String weight,
  //     String nutriture_status,
  //     String ear,
  //     String eye,
  //     String blood_pressure,
  //     String heart,
  //     String nose,
  //     String description,
  //     String date);
  Future<ResponseDataArrayObject<Object>> addChild(
      String child_id,
      String height,
      String weight,
      String nutriture_status,
      String ear,
      String eye,
      String blood_pressure,
      String heart,
      String nose,
      String description,
      String date,
      Uint8List? file);
  Future<ResponseDataArrayObject<Object>> editChild(
      String child_id,
      String child_growth_id,
      String height,
      String weight,
      String nutriture_status,
      String ear,
      String eye,
      String blood_pressure,
      String heart,
      String nose,
      String description,
      String date,
      Uint8List? file);
  // Future<ResponseDataArrayObject<Object>> editaltChild(
  //     String child_id,
  //     String child_growth_id,
  //     String height,
  //     String weight,
  //     String nutriture_status,
  //     String ear,
  //     String eye,
  //     String blood_pressure,
  //     String heart,
  //     String nose,
  //     String description,
  //     String date);
  Future<ResponseDataObject<Object>> delete(
      String group_name, String child_id, String child_growth_id);
  Future<ResponseDataObject<Object>> deleteChild(
      String child_id, String child_growth_id);
}
