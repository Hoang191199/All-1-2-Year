import 'dart:typed_data';

import 'package:mobiedu_kids/domain/entities/image_data.dart';
import 'package:mobiedu_kids/domain/entities/list_child_details.dart';
import 'package:mobiedu_kids/domain/entities/list_child_daily_details.dart';
import 'package:mobiedu_kids/domain/entities/list_child_monthly_details.dart';
import 'package:mobiedu_kids/domain/entities/response_data_array_object.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/list_child.dart';
import 'package:mobiedu_kids/domain/entities/template.dart';

abstract class ReviewRepository {
  Future<ResponseDataObject<ListChild<ListChildDailyDetails>>> mainFetchDaily(
      String group_name, String date);
  Future<ResponseDataArrayObject<Object>> mainReviewDaily(
      String group_name,
      String date,
      List<String?> note,
      List<String?> note_title,
      List<String?> childId,
      List<String?> source,
      List<String?> filename,
      int childNum,
      int isNotified);
  Future<ResponseDataObject<ListChild<ListChildMonthlyDetails>>>
      mainFetchMonthly(String group_name, String date, String date_end);
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
      int isNotified);
  Future<ResponseDataObject<ListChild<ListChildDetails>>> fetchMenu(
      String group_name, String date, String time);
  Future<ResponseDataArrayObject<Object>> reviewMenu(
      String group_name,
      String date,
      String day,
      List<String> note,
      String menu_id,
      List<String> childId,
      int childNum);
  Future<ResponseDataObject<ListChild<ListChildDetails>>> fetchSchedule(
      String group_name, String date);
  Future<ResponseDataArrayObject<Object>> reviewSchedule(
      String group_name,
      String date,
      List<String> note,
      String schedule_id,
      List<String> childId,
      int childNum);
  Future<ResponseDataObject<ImageData>> upload(
      String group_name, Uint8List file, String prename);
  Future<ResponseDataArrayObject<Template>> fetchTemplate(
      String group_name, String mode);
}
