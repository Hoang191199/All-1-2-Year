import 'dart:typed_data';
import 'package:mobiedu_kids/data/providers/network/apis/growth_api.dart';
import 'package:mobiedu_kids/domain/entities/growths.dart';
import 'package:mobiedu_kids/domain/entities/response_data_array_object.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/repositories/growth_repository.dart';

class GrowthRepositoryImpl extends GrowthRepository {
  @override
  Future<ResponseDataObject<Growths>> get(
      String group_name, String child_id) async {
    final response = await GrowthAPI.get(group_name, child_id).request();
    return ResponseDataObject<Growths>.fromJson(
        response, (data) => Growths.fromJson(data));
  }

  @override
  Future<ResponseDataObject<Growths>> getChild(
      String child_id, String month_begin, String month_end) async {
    final response =
        await GrowthAPI.getChild(child_id, month_begin, month_end).request();
    return ResponseDataObject<Growths>.fromJson(
        response, (data) => Growths.fromJson(data));
  }

  @override
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
      Uint8List? file) async {
    final response = await GrowthAPI.add(
            group_name,
            child_id,
            height,
            weight,
            nutriture_status,
            ear,
            eye,
            blood_pressure,
            heart,
            nose,
            description,
            date,
            file)
        .request();
    return ResponseDataArrayObject<Object>.fromJson(response, (data) => Object);
  }

  @override
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
      Uint8List? file) async {
    final response = await GrowthAPI.edit(
            group_name,
            child_id,
            child_growth_id,
            height,
            weight,
            nutriture_status,
            ear,
            eye,
            blood_pressure,
            heart,
            nose,
            description,
            date,
            file)
        .request();
    return ResponseDataArrayObject<Object>.fromJson(response, (data) => Object);
  }

  // @override
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
  //     String date) async {
  //   final response = await GrowthAPI.editalt(
  //           group_name,
  //           child_id,
  //           child_growth_id,
  //           height,
  //           weight,
  //           nutriture_status,
  //           ear,
  //           eye,
  //           blood_pressure,
  //           heart,
  //           nose,
  //           description,
  //           date)
  //       .request();
  //   print(response);
  //   return ResponseDataArrayObject<Object>.fromJson(response, (data) => Object);
  // }

  @override
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
      Uint8List? file) async {
    final response = await GrowthAPI.addChild(
            child_id,
            height,
            weight,
            nutriture_status,
            ear,
            eye,
            blood_pressure,
            heart,
            nose,
            description,
            date,
            file)
        .request();
    return ResponseDataArrayObject<Object>.fromJson(response, (data) => Object);
  }

  @override
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
      Uint8List? file) async {
    final response = await GrowthAPI.editChild(
            child_id,
            child_growth_id,
            height,
            weight,
            nutriture_status,
            ear,
            eye,
            blood_pressure,
            heart,
            nose,
            description,
            date,
            file)
        .request();
    return ResponseDataArrayObject<Object>.fromJson(response, (data) => Object);
  }

  // @override
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
  //     String date) async {
  //   final response = await GrowthAPI.editaltChild(
  //           child_id,
  //           child_growth_id,
  //           height,
  //           weight,
  //           nutriture_status,
  //           ear,
  //           eye,
  //           blood_pressure,
  //           heart,
  //           nose,
  //           description,
  //           date)
  //       .request();
  //   print(response);
  //   return ResponseDataArrayObject<Object>.fromJson(response, (data) => Object);
  // }

  @override
  Future<ResponseDataObject<Object>> delete(
      String group_name, String child_id, String child_growth_id) async {
    final response =
        await GrowthAPI.delete(group_name, child_id, child_growth_id).request();
    return ResponseDataObject<Object>.fromJson(response, (data) => Object);
  }

  @override
  Future<ResponseDataObject<Object>> deleteChild(
      String child_id, String child_growth_id) async {
    final response =
        await GrowthAPI.deleteChild(child_id, child_growth_id).request();
    return ResponseDataObject<Object>.fromJson(response, (data) => Object);
  }
}
