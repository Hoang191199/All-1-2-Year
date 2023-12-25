import 'package:get/get.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/data/providers/network/api_endpoint.dart';
import 'package:mobiedu_kids/data/providers/network/api_provider.dart';
import 'package:mobiedu_kids/data/providers/network/api_request_representable.dart';

enum EventType {
  get,
  getchild,
  detail,
  getSchool,
  detailSchool,
  editSchool,
  createSchool,
  deleteSchool,
  fetchRegister,
  saveRegister,
  saveRegisterchild
}

class EventAPI implements APIRequestRepresentable {
  final EventType type;
  int? page;
  String? group_name;
  String? event_id;
  String? event_level;
  String? event_name;
  String? post_on_wall;
  String? notify_immediately;
  String? description;
  String? must_register;
  String? for_parent;
  String? for_child;
  String? for_teacher;
  String? child_id;
  String? participant_child;
  String? participant_parent;
  List<String>? childId;
  List<String>? parentId;
  int? childNum;
  int? parentNum;

  final store = Get.find<LocalStorageService>();

  EventAPI._(
      {required this.type,
      this.page,
      this.group_name,
      this.event_id,
      this.event_level,
      this.event_name,
      this.post_on_wall,
      this.notify_immediately,
      this.description,
      this.must_register,
      this.for_parent,
      this.for_child,
      this.for_teacher,
      this.child_id,
      this.participant_child,
      this.participant_parent,
      this.childId,
      this.parentId,
      this.childNum,
      this.parentNum});

  EventAPI.get(int page, String group_name)
      : this._(type: EventType.get, page: page, group_name: group_name);

  EventAPI.getChild(int page, String child_id)
      : this._(type: EventType.getchild, page: page, child_id: child_id);

  EventAPI.detail(String group_name, String event_id)
      : this._(
            type: EventType.detail, event_id: event_id, group_name: group_name);

  EventAPI.getSchool(int page, String group_name)
      : this._(type: EventType.getSchool, page: page, group_name: group_name);

  EventAPI.detailSchool(String group_name, String event_id)
      : this._(
            type: EventType.detailSchool,
            event_id: event_id,
            group_name: group_name);

  EventAPI.editSchool(
      String group_name,
      String event_id,
      String event_level,
      String event_name,
      String post_on_wall,
      String notify_immediately,
      String description,
      String must_register,
      String for_parent,
      String for_child,
      String for_teacher)
      : this._(
            type: EventType.editSchool,
            event_id: event_id,
            group_name: group_name,
            event_level: event_level,
            event_name: event_name,
            post_on_wall: post_on_wall,
            notify_immediately: notify_immediately,
            description: description,
            must_register: must_register,
            for_parent: for_parent,
            for_child: for_child,
            for_teacher: for_teacher);

  EventAPI.createSchool(
      String group_name,
      String event_id,
      String event_level,
      String event_name,
      String post_on_wall,
      String notify_immediately,
      String description,
      String must_register,
      String for_parent,
      String for_child,
      String for_teacher)
      : this._(
            type: EventType.createSchool,
            event_id: event_id,
            group_name: group_name,
            event_level: event_level,
            event_name: event_name,
            post_on_wall: post_on_wall,
            notify_immediately: notify_immediately,
            description: description,
            must_register: must_register,
            for_parent: for_parent,
            for_child: for_child,
            for_teacher: for_teacher);

  EventAPI.deleteSchool(String group_name, String event_id)
      : this._(
            type: EventType.deleteSchool,
            event_id: event_id,
            group_name: group_name);

  EventAPI.fetchRegister(
    String group_name,
    String event_id,
  ) : this._(
          type: EventType.fetchRegister,
          event_id: event_id,
          group_name: group_name,
        );

  EventAPI.saveRegister(String group_name, String event_id,
      List<String> childId, int childNum, List<String> parentId, int parentNum)
      : this._(
            type: EventType.saveRegister,
            event_id: event_id,
            group_name: group_name,
            childId: childId,
            childNum: childNum,
            parentId: parentId,
            parentNum: parentNum);

  EventAPI.saveChildRegister(String child_id, String event_id,
      String participant_child, String participant_parent)
      : this._(
            type: EventType.saveRegisterchild,
            child_id: child_id,
            event_id: event_id,
            participant_child: participant_child,
            participant_parent: participant_parent);
  @override
  FormData get form {
    switch (type) {
      case EventType.get:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "view": "all",
          "page": "$page",
          "group_name": "$group_name"
        });
      case EventType.getchild:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "page": "$page",
          "child_id": "$child_id"
        });
      case EventType.detail:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "view": "detail",
          "event_id": "$event_id",
          "group_name": "$group_name"
        });
      case EventType.getSchool:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "view": "all",
          "page": "$page",
          "page_name": "$group_name"
        });
      case EventType.detailSchool:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "view": "detail",
          "page_name": "$group_name",
          "event_id": "$event_id"
        });
      case EventType.editSchool:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "edit",
          "page_name": "$group_name",
          "event_id": "$event_id",
          "event_level": "$event_level",
          "event_name": "$event_name",
          "post_on_wall": "$post_on_wall",
          "notify_immediately": "$notify_immediately",
          "description": "$description",
          "must_register": "$must_register",
          "for_parent": "$for_parent",
          "for_child": "$for_child",
          "for_teacher": "$for_teacher"
        });
      case EventType.createSchool:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "add",
          "page_name": "$group_name",
          "event_id": "$event_id",
          "event_level": "$event_level",
          "event_name": "$event_name",
          "post_on_wall": "$post_on_wall",
          "notify_immediately": "$notify_immediately",
          "description": "$description",
          "must_register": "$must_register",
          "for_parent": "$for_parent",
          "for_child": "$for_child",
          "for_teacher": "$for_teacher"
        });
      case EventType.deleteSchool:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "delete",
          "page_name": "$group_name",
          "event_id": "$event_id",
          "event_level": "$event_level",
          "event_name": "$event_name",
          "post_on_wall": "$post_on_wall",
          "notify_immediately": "$notify_immediately",
          "description": "$description",
          "must_register": "$must_register",
          "for_parent": "$for_parent",
          "for_child": "$for_child",
          "for_teacher": "$for_teacher"
        });
      case EventType.fetchRegister:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "view": "participant",
          "group_name": "$group_name",
          "event_id": "$event_id"
        });
      case EventType.saveRegister:
        var formData = {
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "add_pp",
          "group_name": "$group_name",
          "event_id": "$event_id",
        };

        for (var i = 0; i < childNum!; i++) {
          formData["child_id[$i]"] = "${childId?[i]}";
        }
        for (var j = 0; j < parentNum!; j++) {
          formData["parent_id[$j]"] = "${parentId?[j]}";
        }

        return FormData(formData);
      case EventType.saveRegisterchild:
        var formData = {
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "register",
          "child_id": "$child_id",
          "event_id": "$event_id",
          // "participant_child": "$participant_child",
          // "participant_parent": "$participant_parent"
        };
        if (participant_child == "1" || participant_child == "0") {
          formData["participant_child"] = "$participant_child";
        }
        if (participant_parent == "1" || participant_parent == "0") {
          formData["participant_parent"] = "$participant_parent";
        }
        return FormData(formData);
    }
  }

  @override
  String get endpoint => APIEndpoint.endpoint;

  @override
  String get path {
    switch (type) {
      case EventType.get:
      case EventType.detail:
      case EventType.fetchRegister:
        return "/manageClassEventShow";
      case EventType.saveRegister:
        return "/manageClassEvent";
      case EventType.getchild:
        return "/manageChildEventShow";
      case EventType.saveRegisterchild:
        return "/manageChildEvent";
      case EventType.getSchool:
      case EventType.detailSchool:
        return "/manageEmployeeEventShow";
      case EventType.editSchool:
      case EventType.createSchool:
      case EventType.deleteSchool:
        return "/manageSchoolEvent";
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
