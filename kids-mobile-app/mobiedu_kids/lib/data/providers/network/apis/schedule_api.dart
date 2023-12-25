import 'package:get/get.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/data/providers/network/api_endpoint.dart';
import 'package:mobiedu_kids/data/providers/network/api_provider.dart';
import 'package:mobiedu_kids/data/providers/network/api_request_representable.dart';

enum ScheduleType {
  get,
  view,
  detail,
  getChild,
  viewChild,
  detailChild,
  schoolList,
  schoolDetail
}

class ScheduleAPI implements APIRequestRepresentable {
  final ScheduleType type;
  int? page;
  String? time;
  String? user_id;
  String? schedule_id;
  String? group_name;
  String? school_name;
  String? child_id;

  final store = Get.find<LocalStorageService>();

  ScheduleAPI._(
      {required this.type,
      this.time,
      this.page,
      this.user_id,
      this.schedule_id,
      this.group_name,
      this.school_name,
      this.child_id});

  ScheduleAPI.get(String group_name)
      : this._(type: ScheduleType.get, group_name: group_name);

  ScheduleAPI.getChild(String child_id)
      : this._(type: ScheduleType.getChild, child_id: child_id);

  ScheduleAPI.view(int page, String group_name)
      : this._(type: ScheduleType.view, page: page, group_name: group_name);

  ScheduleAPI.detail(String group_name, String schedule_id)
      : this._(
            type: ScheduleType.detail,
            group_name: group_name,
            schedule_id: schedule_id);

  ScheduleAPI.viewChild(int page, String child_id)
      : this._(type: ScheduleType.viewChild, page: page, child_id: child_id);

  ScheduleAPI.detailChild(String child_id, String schedule_id)
      : this._(
            type: ScheduleType.detailChild,
            child_id: child_id,
            schedule_id: schedule_id);

  ScheduleAPI.schoolList(String school_name)
      : this._(type: ScheduleType.schoolList, school_name: school_name);

  ScheduleAPI.schoolDetail(String school_name, String schedule_id)
      : this._(
            type: ScheduleType.schoolDetail,
            school_name: school_name,
            schedule_id: schedule_id);

  @override
  FormData get form {
    switch (type) {
      case ScheduleType.get:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "view": "this_week",
          "group_name": "$group_name"
        });
      case ScheduleType.getChild:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "view": "this_week",
          "child_id": "$child_id"
        });
      case ScheduleType.view:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "view": "history",
          "page": "$page",
          "group_name": "$group_name"
        });
      case ScheduleType.detail:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "view": "detail",
          "group_name": "$group_name",
          "schedule_id": "$schedule_id"
        });
      case ScheduleType.viewChild:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "view": "history",
          "page": "$page",
          "child_id": "$child_id"
        });
      case ScheduleType.detailChild:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "view": "detail",
          "child_id": "$child_id",
          "schedule_id": "$schedule_id"
        });
      case ScheduleType.schoolList:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "page_name": "$school_name",
          "do": "list_schedule"
        });
      case ScheduleType.schoolDetail:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "page_name": "$school_name",
          "do": "details",
          "schedule_id": "$schedule_id"
        });
    }
  }

  @override
  String get endpoint => APIEndpoint.endpoint;

  @override
  String get path {
    switch (type) {
      case ScheduleType.get:
      case ScheduleType.view:
      case ScheduleType.detail:
      case ScheduleType.getChild:
      case ScheduleType.viewChild:
      case ScheduleType.detailChild:
        return "/manageSchedule";
      case ScheduleType.schoolList:
      case ScheduleType.schoolDetail:
        return "/manageSchoolSchedule";
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
