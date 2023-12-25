
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/data/providers/network/api_endpoint.dart';
import 'package:mobiedu_kids/data/providers/network/api_provider.dart';
import 'package:mobiedu_kids/data/providers/network/api_request_representable.dart';
import 'package:mobiedu_kids/presentation/controllers/attendance/attendanceController.dart';
import 'package:mobiedu_kids/presentation/controllers/hygiene/hygiene_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/manager/manager_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/sleep/sleep_controller.dart';

enum AttendanceType { get, uploadImage, updateCheckIn, updateCheckOut, getHygiene, updateHygiene, getSleep, updateSleep, confirm }

class AttendanceAPI implements APIRequestRepresentable {
  final AttendanceType type;


  final store = Get.find<LocalStorageService>();
  final managerController = Get.find<ManagerController>();
  final attendanceController = Get.find<AttendanceController>();
  final hygieneController = Get.find<HygieneController>();
  final sleepController = Get.find<SleepController>();

  AttendanceAPI._(
      {
        required this.type,
        this.index,
        this.date,
        this.groupName,
        this.childId,
        this.attendanceDetailId,
      });

  int? index;
  String? groupName;
  String? date;
  String? childId;
  String? attendanceDetailId;
  
  AttendanceAPI.fetchData(groupName, date): this._(type: AttendanceType.get, groupName: groupName, date: date);

  AttendanceAPI.uploadImage(index) : this._(type: AttendanceType.uploadImage, index: index);

  AttendanceAPI.update() : this._(type: AttendanceType.updateCheckIn);

  AttendanceAPI.updateCheckOut() : this._(type: AttendanceType.updateCheckOut);

  AttendanceAPI.getHygiene() : this._(type: AttendanceType.getHygiene);

  AttendanceAPI.updateHygiene() : this._(type: AttendanceType.updateHygiene);

  AttendanceAPI.getSleep() : this._(type: AttendanceType.getSleep);

  AttendanceAPI.updateSleep() : this._(type: AttendanceType.updateSleep);

  AttendanceAPI.confirm(groupName, childId, attendanceDetailId): this._(type: AttendanceType.confirm, groupName:  groupName, childId: childId, attendanceDetailId: attendanceDetailId);

  @override
  FormData get form {
    switch (type) {
      case AttendanceType.get:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "group_name": "$groupName",
          "do": "list",
          "attendance_date": "$date",
        });

      case AttendanceType.uploadImage:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "group_name": store.getGroupname,
          "do": "uploadImage",
          "file": MultipartFile(
            File(attendanceController.tabs.value == "check-in" 
              ? (attendanceController.listDetailCheckIn[index ?? 0].source_file ?? '') 
              : (attendanceController.listDetailCheckOut[index ?? 0].source_file ?? '')
            ),
            filename: (attendanceController.tabs.value  == "check-in" 
              ? attendanceController.listDetailCheckIn[index ?? 0].fileName ?? '' 
              : attendanceController.listDetailCheckOut[index ?? 0].fileName ?? ''
            )
          )
        });

      case AttendanceType.updateCheckIn:
        var objectUpdate = {
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "group_name": store.getGroupname,
          "do": "rollup",
          "attendance_date": convertDateTimeToString(attendanceController.dateNow),
          };

          attendanceController.listDetailCheckIn.asMap().forEach((key, value) {
            objectUpdate["allChildIds[$key]"] = attendanceController.listDetailCheckIn[key].id ?? '0';
            objectUpdate["allReasons[$key]"] = (attendanceController.listDetailCheckIn[key].reason)?.text ?? '';
            objectUpdate["allStatus[$key]"] = attendanceController.listDetailCheckIn[key].status ?? '0';
            objectUpdate["allSourceFile[$key]"] = attendanceController.listDetailCheckIn[key].source_file ?? '';
            objectUpdate["allFileName[$key]"] = attendanceController.listDetailCheckIn[key].fileName ?? '';
          });

        return FormData(objectUpdate);

      case AttendanceType.updateCheckOut:
        var objectUpdateCheckOut = {
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "group_name": store.getGroupname,
          "do": "rollup_back",
          "attendance_date": convertDateTimeToString(attendanceController.dateNow),
          };

          attendanceController.listDetailCheckOut.asMap().forEach((key, value) {
            objectUpdateCheckOut["allChildBackIds[$key]"] = attendanceController.listDetailCheckOut[key].id ?? '0';
            objectUpdateCheckOut["allStatusBack[$key]"] = attendanceController.listDetailCheckOut[key].status_back ?? '0';
            objectUpdateCheckOut["cameback_time[$key]"] = attendanceController.listDetailCheckOut[key].time_back == "" ? convertTimeOfDayToString(TimeOfDay.now()) 
            : attendanceController.listDetailCheckOut[key].time_back ?? convertTimeOfDayToString(TimeOfDay.now());
            objectUpdateCheckOut["cameback_note[$key]"] = (attendanceController.listDetailCheckOut[key].came_back_note)?.text ?? '';
            objectUpdateCheckOut["allSourceFile[$key]"] = attendanceController.listDetailCheckOut[key].source_file ?? '';
            objectUpdateCheckOut["allFileName[$key]"] = attendanceController.listDetailCheckOut[key].fileName ?? '';
          });

        return FormData(objectUpdateCheckOut);

        case AttendanceType.getHygiene:
          return FormData({
            "user_id": "${store.userFromStorage?.user_id}",
            "user_token": "${store.userFromStorage?.user_token}",
            "group_name": store.getGroupname,
            "do": "conditionAttdance",
            "type": "poo",
            "attendance_date": convertDateTimeToString(DateTime.now())
          });

      case AttendanceType.updateHygiene:
        var objectUpdate = {
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "group_name": store.getGroupname,
          "do": "teacherReviewAdd",
          "review_date": convertDateTimeToString(attendanceController.dateNow),
          "type": "poo",
          "key": 2,

          };

          final tempArr = hygieneController.listHygieneTemp.where((hygiene) => (hygiene.check ?? false)).toList();
          tempArr.asMap().forEach((key, value) {
            objectUpdate["allChildIds[$key]"] = tempArr[key].id ?? '';
            objectUpdate["allNote[$key]"] = tempArr[key].note?.text ?? '';
            objectUpdate["allMetadata[$key]"] = tempArr[key].metadata ?? '0';
          });

        return FormData(objectUpdate);

      case AttendanceType.getSleep:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "group_name": store.getGroupname,
          "do": "conditionAttdance",
          "type": "sleep",
          "time": "11:30:00",
          "attendance_date": convertDateTimeToString(DateTime.now())
        });

      case AttendanceType.updateSleep:
        var objectUpdate = {
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "group_name": store.getGroupname,
          "do": "teacherReviewAdd",
          "review_date": convertDateTimeToString(attendanceController.dateNow),
          "type": "sleep",
          "key": 1,
          };

          final tempArr = sleepController.listSleepTemp.where((hygiene) => (hygiene.check ?? false)).toList();
          tempArr.asMap().forEach((key, value) {
              objectUpdate["allChildIds[$key]"] = tempArr[key].id ?? '0';
              objectUpdate["allNote[$key]"] = (tempArr[key].note)?.text ?? '';
              objectUpdate["allMetadata[$key]"] = tempArr[key].metadata ?? '{"begin":"11:30","end":"14:00"}';
          });

        return FormData(objectUpdate);

      case AttendanceType.confirm:
        return FormData({
            "user_id": store.userFromStorage?.user_id,
            "user_token": "${store.userFromStorage?.user_token}",
            "child_id": childId,
            "group_name": groupName,
            "do": "confirm",
            "attendance_detail_id": attendanceDetailId
        });
    }
  }

  @override
  String get endpoint => APIEndpoint.endpoint;

  @override
  String get path {
    switch (type) {
      case AttendanceType.get:
      case AttendanceType.uploadImage:
      case AttendanceType.updateCheckIn:
      case AttendanceType.updateCheckOut:
      case AttendanceType.getHygiene:
      case AttendanceType.updateHygiene:
      case AttendanceType.getSleep:
      case AttendanceType.updateSleep:
      case AttendanceType.confirm:
        return "/manageClassAttendance";
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
