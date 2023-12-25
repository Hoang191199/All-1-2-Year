// import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/data/providers/network/api_endpoint.dart';
import 'package:mobiedu_kids/data/providers/network/api_provider.dart';
import 'package:mobiedu_kids/data/providers/network/api_request_representable.dart';
// import 'package:mobiedu_kids/domain/entities/image_data.dart';

enum ReviewType {
  mainFetchDaily,
  mainReviewDaily,
  mainFetchMonthly,
  mainReviewMonthly,
  fetchMenu,
  reviewMenu,
  fetchSchedule,
  reviewSchedule,
  upload,
  fetchTemplate
}

class ReviewAPI implements APIRequestRepresentable {
  final ReviewType type;
  String? group_name;
  int? childNum;
  Uint8List? file;
  String? prename;
  String? time;
  String? date;
  String? date_end;
  String? day;
  int? isNotified;
  String? mode;
  List<String?>? note;
  List<String?>? note_title;
  List<String?>? childId;
  List<String?>? source;
  List<String?>? filename;
  String? menu_id;
  String? schedule_id;
  String? metadata;

  final store = Get.find<LocalStorageService>();

  ReviewAPI._(
      {required this.type,
      this.group_name,
      this.childNum,
      this.file,
      this.prename,
      this.time,
      this.date,
      this.date_end,
      this.day,
      this.note,
      this.note_title,
      this.isNotified,
      this.mode,
      this.childId,
      this.menu_id,
      this.source,
      this.filename,
      this.metadata,
      this.schedule_id});

  ReviewAPI.mainFetchDaily(String group_name, String date)
      : this._(
            type: ReviewType.mainFetchDaily,
            group_name: group_name,
            date: date);

  ReviewAPI.mainReviewDaily(
      String group_name,
      String date,
      List<String?> note,
      List<String?> note_title,
      List<String?> childId,
      List<String?> source,
      List<String?> filename,
      int childNum,
      int isNotified)
      : this._(
            type: ReviewType.mainReviewDaily,
            childNum: childNum,
            group_name: group_name,
            date: date,
            note_title: note_title,
            note: note,
            source: source,
            filename: filename,
            childId: childId,
            isNotified: isNotified);

  ReviewAPI.mainFetchMonthly(String group_name, String date, String date_end)
      : this._(
            type: ReviewType.mainFetchMonthly,
            group_name: group_name,
            date: date,
            date_end: date_end);

  ReviewAPI.mainReviewMonthly(
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
      int isNotified)
      : this._(
            type: ReviewType.mainReviewMonthly,
            childNum: childNum,
            group_name: group_name,
            date: date,
            note_title: note_title,
            date_end: date_end,
            note: note,
            source: source,
            filename: filename,
            childId: childId,
            metadata: metadata,
            isNotified: isNotified);

  ReviewAPI.fetchMenu(String group_name, String date, String time)
      : this._(
            type: ReviewType.fetchMenu,
            group_name: group_name,
            date: date,
            time: time);

  ReviewAPI.reviewMenu(String group_name, String date, String day,
      List<String?> note, String menu_id, List<String?> childId, int childNum)
      : this._(
            type: ReviewType.reviewMenu,
            childNum: childNum,
            group_name: group_name,
            date: date,
            menu_id: menu_id,
            day: day,
            note: note,
            childId: childId);

  ReviewAPI.fetchSchedule(String group_name, String date)
      : this._(
          type: ReviewType.fetchSchedule,
          group_name: group_name,
          date: date,
        );

  ReviewAPI.reviewSchedule(String group_name, String date, List<String?> note,
      String schedule_id, List<String?> childId, int childNum)
      : this._(
            type: ReviewType.reviewSchedule,
            childNum: childNum,
            group_name: group_name,
            date: date,
            schedule_id: schedule_id,
            note: note,
            childId: childId);

  ReviewAPI.upload(String group_name, Uint8List file, String prename)
      : this._(
            type: ReviewType.upload,
            group_name: group_name,
            file: file,
            prename: prename);

  ReviewAPI.fetchTemplate(String group_name, String mode)
      : this._(
            type: ReviewType.fetchTemplate, group_name: group_name, mode: mode);

  @override
  FormData get form {
    switch (type) {
      case ReviewType.mainFetchDaily:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "group_name": "$group_name",
          "do": "conditionAttdanceDay",
          "type": "day",
          "attendance_date": "$date",
        });
      case ReviewType.mainReviewDaily:
        var formData = {
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "group_name": "$group_name",
          "do": "teacherReviewAddDay",
          "date_begin": "$date",
          "date_end": "$date",
          "type": "day",
          "status": 1,
          "is_notified": isNotified,
          "template_id": 1,
        };

        if(childNum! > 0){
        for (var i = 0; i < childNum!; i++) {
          formData["allContent[$i]"] = "${note?[i]}";
          formData["allTitle[$i]"] = "${note_title?[i]}";
          formData["allChildIds[$i]"] = "${childId?[i]}";
          formData["allFileName[$i]"] = "${filename?[i]}";
          formData["allSourceFile[$i]"] = "${source?[i]}";
        }
        }

        return FormData(formData);
      case ReviewType.mainFetchMonthly:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "group_name": "$group_name",
          "do": "conditionAttdanceDay",
          "type": "week",
          "attendance_date": "$date",
          "attendance_date_end": "$date_end",
        });
      case ReviewType.mainReviewMonthly:
        var formData = {
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "group_name": "$group_name",
          "do": "teacherReviewAddDay",
          "date_begin": "$date",
          "date_end": "$date_end",
          "type": "week",
          "status": 1,
          "is_notified": isNotified,
          "template_id": 1,
        };

        // if (metadata?.isNotEmpty ?? false) {
        //   String jsonMetadata = jsonEncode(metadata);
        if(childNum! > 0){
        for (var i = 0; i < childNum!; i++) {
          formData["allContent[$i]"] = "${note?[i]}";
          formData["allTitle[$i]"] = "${note_title?[i]}";
          formData["allChildIds[$i]"] = "${childId?[i]}";
          formData["allFileName[$i]"] = "${filename?[i]}";
          formData["allSourceFile[$i]"] = "${source?[i]}";
          formData["allMetadata[$i]"] = metadata;
        }
        }
        // } else {
        //   for (var i = 0; i < childNum!; i++) {
        //     formData["allContent[$i]"] = "${note?[i]}";
        //     formData["allTitle[$i]"] = "${note_title?[i]}";
        //     formData["allChildIds[$i]"] = "${childId?[i]}";
        //     formData["allFileName[$i]"] = "${filename?[i]}";
        //     formData["allSourceFile[$i]"] = "${source?[i]}";
        //     formData["allMetadata[$i]"] = "";
        //   }
        // }

        return FormData(formData);
      case ReviewType.fetchMenu:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "group_name": "$group_name",
          "do": "conditionAttdance",
          "attendance_date": "$date",
          "time": "$time",
          "type": "menu"
        });
      case ReviewType.reviewMenu:
        var formData = {
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "group_name": "$group_name",
          "do": "teacherReviewAdd",
          "review_date": "$date",
          "key": "$menu_id",
          "type": "menu",
        };

        for (var i = 0; i < childNum!; i++) {
          formData["allNote[$i]"] = "${note?[i]}";
          formData["allMetadata[$i]"] =
              "{\"menu_id\": $menu_id,\"day\":\"${day}\"}";
          formData["allChildIds[$i]"] = "${childId?[i]}";
        }

        return FormData(formData);
      case ReviewType.fetchSchedule:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "group_name": "$group_name",
          "do": "conditionAttdance",
          "attendance_date": "$date",
          "type": "schedule"
        });
      case ReviewType.reviewSchedule:
        var formData = {
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "group_name": "$group_name",
          "do": "teacherReviewAdd",
          "review_date": "$date",
          "key": "$schedule_id",
          "type": "schedule",
        };

        for (var i = 0; i < childNum!; i++) {
          formData["allNote[$i]"] = "${note?[i]}";
          formData["allMetadata[$i]"] = "{\"schedule_id\": $schedule_id}";
          formData["allChildIds[$i]"] = "${childId?[i]}";
        }

        return FormData(formData);
      case ReviewType.upload:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "page_name": "$group_name",
          "do": "uploadImage",
          "file": MultipartFile(file, filename: "$prename")
        });
      case ReviewType.fetchTemplate:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "group_name": "$group_name",
          "do": "listTeamplate",
          "type": "$mode"
        });
    }
  }

  @override
  String get endpoint => APIEndpoint.endpoint;

  @override
  String get path {
    switch (type) {
      case ReviewType.fetchMenu:
      case ReviewType.reviewMenu:
      case ReviewType.fetchSchedule:
      case ReviewType.reviewSchedule:
        return '/manageClassAttendance';
      case ReviewType.mainFetchDaily:
      case ReviewType.mainReviewDaily:
      case ReviewType.mainFetchMonthly:
      case ReviewType.mainReviewMonthly:
      case ReviewType.fetchTemplate:
        return '/manageReviewTeacher';
      case ReviewType.upload:
        return '/manageSchoolTemplateReview';
    }
  }

  @override
  String get url => endpoint + path;

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  Map<String, String>? get headers => {};

  @override
  Map<String, String>? get query => {};

  @override
  get body => form;

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }
}
