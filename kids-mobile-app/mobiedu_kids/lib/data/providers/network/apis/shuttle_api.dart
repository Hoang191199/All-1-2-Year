import 'package:get/get.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/manager/manager_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/shuttle/shuttle_controller.dart';

import '../api_endpoint.dart';
import '../api_provider.dart';
import '../api_request_representable.dart';

enum ShuttleType {
  shuttle,
  pickup,
  savePickup,
  cancel,
  listClass,
  listChild,
  addChild,
  assign,
  history
}

class ShuttleApi implements APIRequestRepresentable {
  final ShuttleType type;
  int? pickup_id;
  int? child_id;
  String? late_pickup_free;
  int? total_amount;
  String? pickup_at;
  String? note;
  List<String>? service;
  int? index;
  String? status;

  ShuttleApi._(
      {required this.type,
      this.child_id,
      this.pickup_id,
      this.late_pickup_free,
      this.total_amount,
      this.pickup_at,
      this.note,
      this.service,
      this.index,
      this.status});

  ShuttleApi.fetchData() : this._(type: ShuttleType.shuttle);

  ShuttleApi.pickUp(int pickup_id, int child_id)
      : this._(
            type: ShuttleType.pickup, pickup_id: pickup_id, child_id: child_id);

  ShuttleApi.savePickup(
      int pickup_id,
      int child_id,
      String? late_pickup_free,
      int? total_amount,
      String? pickup_at,
      String? note,
      List<String>? service,
      int? index,
      String? status)
      : this._(
            type: ShuttleType.savePickup,
            pickup_id: pickup_id,
            child_id: child_id,
            late_pickup_free: late_pickup_free,
            total_amount: total_amount,
            note: note,
            pickup_at: pickup_at,
            service: service,
            index: index,
            status: status);

  ShuttleApi.cancel(int pickup_id, int child_id)
      : this._(
            type: ShuttleType.cancel, pickup_id: pickup_id, child_id: child_id);

  ShuttleApi.listClass() : this._(type: ShuttleType.listClass);

  ShuttleApi.listChild() : this._(type: ShuttleType.listChild);

  ShuttleApi.addChild() : this._(type: ShuttleType.addChild);

  ShuttleApi.assign() : this._(type: ShuttleType.assign);

  ShuttleApi.history() : this._(type: ShuttleType.history);

  final store = Get.find<LocalStorageService>();
  final managerController = Get.find<ManagerController>();
  final shuttleController = Get.find<ShuttleController>();

  @override
  FormData get form {
    switch (type) {
      case ShuttleType.shuttle:
        return FormData({
          "user_id": store.userFromStorage?.user_id,
          "user_token": "${store.userFromStorage?.user_token}",
          "page_name": store.getPagename,
          "do": "manage",
        });

      case ShuttleType.pickup:
        return FormData({
          "user_id": store.userFromStorage?.user_id,
          "user_token": "${store.userFromStorage?.user_token}",
          "page_name": store.getPagename,
          "do": "pickup",
          "pickup_id": pickup_id,
          "child_id": child_id
        });

      case ShuttleType.savePickup:
        var m = {
          "user_id": store.userFromStorage?.user_id,
          "user_token": "${store.userFromStorage?.user_token}",
          "page_name": store.getPagename,
          "do": "save_pickup_child",
          "pickup_id": pickup_id,
          "child_id": child_id,
          "pickup_at": pickup_at,
          "late_pickup_fee": late_pickup_free,
          "total_amount": total_amount,
          "note": shuttleController.listStudent[index ?? 0].description?.text,
          'status': status
        };
        service?.asMap().forEach((index, e) {
          m["service[$index]"] = e;
        });
        return FormData(m);
      case ShuttleType.cancel:
        return FormData({
          "user_id": store.userFromStorage?.user_id,
          "user_token": "${store.userFromStorage?.user_token}",
          "page_name": store.getPagename,
          "do": "cancel",
          "pickup_id": pickup_id,
          "child_id": child_id
        });

      case ShuttleType.listClass:
        return FormData({
          "user_id": store.userFromStorage?.user_id,
          "user_token": "${store.userFromStorage?.user_token}",
          "page_name": store.getPagename,
          "do": "list_class",
        });

      case ShuttleType.listChild:
        return FormData({
          "user_id": store.userFromStorage?.user_id,
          "user_token": "${store.userFromStorage?.user_token}",
          "page_name": store.getPagename,
          "do": "list_child_pickup",
          "class_id": shuttleController.classId.value,
          "pickup_id": shuttleController.pickup_id.value
        });

      case ShuttleType.addChild:
        var data = shuttleController.listStudentWithClass;
        var add = {
          "user_id": store.userFromStorage?.user_id,
          "user_token": "${store.userFromStorage?.user_token}",
          "page_name": store.getPagename,
          "do": "add_child",
          "class_id": shuttleController.classId.value,
          "pickup_id": shuttleController.pickup_id.value,
          "pickup_class_id": shuttleController.pickup_class_id.value,
        };
        data.asMap().forEach((index, data) {
          if (data.check == true) {
            add["childIds[$index]"] = data.child_id;
            add["notes[${data.child_id}]"] = data.description?.text;
            add["registered[${data.child_id}]"] = '1';
          }
        });
        return FormData(add);

      case ShuttleType.assign:
        return FormData({
          "user_id": store.userFromStorage?.user_id,
          "user_token": "${store.userFromStorage?.user_token}",
          "page_name": store.getPagename,
          "do": "assign",
        });

      case ShuttleType.history:
        return FormData({
          "user_id": store.userFromStorage?.user_id,
          "user_token": "${store.userFromStorage?.user_token}",
          "page_name": store.getPagename,
          "do": "history",
          "formDate": shuttleController.firstDayOfMonthString,
          "toDate": shuttleController.lastDayOfMonthString
        });
    }
  }

  @override
  String get endpoint => APIEndpoint.endpoint;

  @override
  String get path {
    return "/manageClassPickup";
  }

  @override
  String get url => endpoint + path;

  @override
  HTTPMethod get method {
    return HTTPMethod.post;
  }

  @override
  Map<String, String> get headers => {};

  @override
  get query => null;

  @override
  get body => form;

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }
}
