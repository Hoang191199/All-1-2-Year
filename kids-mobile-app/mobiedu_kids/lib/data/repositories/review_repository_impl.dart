import 'dart:typed_data';

import 'package:mobiedu_kids/data/providers/network/apis/review_api.dart';
import 'package:mobiedu_kids/domain/entities/image_data.dart';
import 'package:mobiedu_kids/domain/entities/list_child.dart';
import 'package:mobiedu_kids/domain/entities/list_child_daily_details.dart';
import 'package:mobiedu_kids/domain/entities/list_child_details.dart';
import 'package:mobiedu_kids/domain/entities/list_child_monthly_details.dart';
import 'package:mobiedu_kids/domain/entities/response_data_array_object.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/template.dart';
import 'package:mobiedu_kids/domain/repositories/review_repository.dart';

class ReviewRepositoryImpl extends ReviewRepository {
  @override
  Future<ResponseDataObject<ListChild<ListChildDailyDetails>>> mainFetchDaily(
      String group_name, String date) async {
    final response = await ReviewAPI.mainFetchDaily(group_name, date).request();
    return ResponseDataObject<ListChild<ListChildDailyDetails>>.fromJson(
        response,
        (data) => ListChild<ListChildDailyDetails>.fromJson(
            data, (d) => ListChildDailyDetails.fromJson(d)));
  }

  @override
  Future<ResponseDataArrayObject<Object>> mainReviewDaily(
      String group_name,
      String date,
      List<String?> note,
      List<String?> note_title,
      List<String?> childId,
      List<String?> source,
      List<String?> filename,
      int childNum,
      int isNotified) async {
    final response = await ReviewAPI.mainReviewDaily(group_name, date, note,
            note_title, childId, source, filename, childNum, isNotified)
        .request();
    return ResponseDataArrayObject.fromJson(response, (data) => Object());
  }

  @override
  Future<ResponseDataObject<ListChild<ListChildMonthlyDetails>>>
      mainFetchMonthly(String group_name, String date, String date_end) async {
    final response =
        await ReviewAPI.mainFetchMonthly(group_name, date, date_end).request();
    return ResponseDataObject<ListChild<ListChildMonthlyDetails>>.fromJson(
        response,
        (data) => ListChild<ListChildMonthlyDetails>.fromJson(
            data, (d) => ListChildMonthlyDetails.fromJson(d)));
  }

  @override
  Future<ResponseDataArrayObject<Object>> mainReviewMonthly(
      String group_name,
      String date,
      String date_end,
      List<String?> note,
      List<String?> note_title,
      List<String?> childId,
      List<String?> source,
      List<String?> filename,
      int childNum,
      String metadata,
      int isNotified) async {
    final response = await ReviewAPI.mainReviewMonthly(
            group_name,
            date,
            date_end,
            note,
            note_title,
            childId,
            source,
            filename,
            childNum,
            metadata,
            isNotified)
        .request();
    return ResponseDataArrayObject.fromJson(response, (data) => Object());
  }

  @override
  Future<ResponseDataObject<ListChild<ListChildDetails>>> fetchMenu(
      String group_name, String date, String time) async {
    final response =
        await ReviewAPI.fetchMenu(group_name, date, time).request();
    return ResponseDataObject<ListChild<ListChildDetails>>.fromJson(
        response,
        (data) => ListChild<ListChildDetails>.fromJson(
            data, (d) => ListChildDetails.fromJson(d)));
  }

  @override
  Future<ResponseDataArrayObject<Object>> reviewMenu(
      String group_name,
      String date,
      String day,
      List<String> note,
      String menu_key,
      List<String> childId,
      int childNum) async {
    final response = await ReviewAPI.reviewMenu(
            group_name, date, day, note, menu_key, childId, childNum)
        .request();
    return ResponseDataArrayObject.fromJson(response, (data) => Object());
  }

  @override
  Future<ResponseDataObject<ListChild<ListChildDetails>>> fetchSchedule(
      String group_name, String date) async {
    final response = await ReviewAPI.fetchSchedule(group_name, date).request();
    return ResponseDataObject<ListChild<ListChildDetails>>.fromJson(
        response,
        (data) => ListChild<ListChildDetails>.fromJson(
            data, (d) => ListChildDetails.fromJson(d)));
  }

  @override
  Future<ResponseDataArrayObject<Object>> reviewSchedule(
      String group_name,
      String date,
      List<String> note,
      String schedule_id,
      List<String> childId,
      int childNum) async {
    final response = await ReviewAPI.reviewSchedule(
            group_name, date, note, schedule_id, childId, childNum)
        .request();
    return ResponseDataArrayObject.fromJson(response, (data) => Object());
  }

  @override
  Future<ResponseDataObject<ImageData>> upload(
      String group_name, Uint8List file, String prename) async {
    final response =
        await ReviewAPI.upload(group_name, file, prename).request();
    return ResponseDataObject<ImageData>.fromJson(
        response, (data) => ImageData.fromJson(data));
  }

  @override
  Future<ResponseDataArrayObject<Template>> fetchTemplate(
      String group_name, String mode) async {
    final response = await ReviewAPI.fetchTemplate(group_name, mode).request();
    return ResponseDataArrayObject<Template>.fromJson(
        response, (data) => Template.fromJson(data));
  }
}
