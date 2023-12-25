import 'dart:io';

import 'package:get/get.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/manager/manager_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/prescription/prescription_child_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/prescription/prescription_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/splash/splash_controller.dart';

import '../api_endpoint.dart';
import '../api_provider.dart';
import '../api_request_representable.dart';

enum PrescriptionType { prescription, take_medicines, show_child, add, prescriptionChild, register }

class PrescriptionApi implements APIRequestRepresentable {
  final PrescriptionType type;
  int? medicine_id;
  String? doing;
  int? child_id;
  int? max;
  String? medicine_list;
  String? begin;
  String? end;
  String? guide;
  String? time_per_day;

  PrescriptionApi._(
      {required this.type,
      this.medicine_id,
      this.doing,
      this.child_id,
      this.max,
      this.guide,
      this.time_per_day,
      this.begin,
      this.end,
      this.medicine_list});

  PrescriptionApi.fetchData() : this._(type: PrescriptionType.prescription);

  PrescriptionApi.takeMedicines(
      int? medicine_id, String? doing, int? child_id, int? max)
      : this._(
            type: PrescriptionType.take_medicines,
            medicine_id: medicine_id,
            doing: doing,
            child_id: child_id,
            max: max);

  PrescriptionApi.showChildActive() : this._(type: PrescriptionType.show_child);

  PrescriptionApi.add(String? medicine_list, String? guide,
      String? time_per_day, String? begin, String? end, int? child_id)
      : this._(
            type: PrescriptionType.add,
            medicine_list: medicine_list,
            guide: guide,
            time_per_day: time_per_day,
            child_id: child_id,
            begin: begin,
            end: end);

  PrescriptionApi.getPrescriptionChild() : this._(type: PrescriptionType.prescriptionChild);

  PrescriptionApi.register(String? medicine_list, String? guide, String? time_per_day, String? begin, String? end, int? child_id)
      : this._(
          type: PrescriptionType.register,
          medicine_list: medicine_list,
          guide: guide,
          time_per_day: time_per_day,
          child_id: child_id,
          begin: begin,
          end: end
        );

  final store = Get.find<LocalStorageService>();
  final managerController = Get.find<ManagerController>();
  final spashControlller = Get.find<SplashScreenController>();

  @override
  FormData get form {
    switch (type) {
      case PrescriptionType.prescription:
        return FormData({
          "user_id": store.userFromStorage?.user_id,
          "user_token": "${store.userFromStorage?.user_token}",
          "group_name": store.getGroupname,
          "view": "today",
        });
      case PrescriptionType.take_medicines:
        return FormData({
          "user_id": store.userFromStorage?.user_id,
          "user_token": "${store.userFromStorage?.user_token}",
          "group_name": store.getGroupname,
          "child_id": child_id,
          "do": doing,
          "medicine_id": medicine_id,
          "max": max,
        });
      case PrescriptionType.show_child:
        return FormData({
          "user_id": store.userFromStorage?.user_id,
          "user_token": "${store.userFromStorage?.user_token}",
          "group_name": store.getGroupname,
          "do": "show_active_children_short",
        });
      case PrescriptionType.add:
        final prescriptionController = Get.find<PrescriptionController>();

        var objectData = {
          "user_id": store.userFromStorage?.user_id,
          "user_token": "${store.userFromStorage?.user_token}",
          "group_name": store.getGroupname,
          "do": "add",
          "medicine_list": medicine_list,
          "guide": guide,
          "time_per_day": time_per_day,
          "begin": begin,
          "end": end,
          "child_id": child_id,
        };
        if(prescriptionController.selectedImagePath.value != ''){
          objectData["file"] = MultipartFile(
            File(prescriptionController.selectedImagePath.value),
            filename: prescriptionController.selectedImageName.value
          );
        }
        return FormData(objectData);

      case PrescriptionType.prescriptionChild:
        return FormData({
          "user_id": store.userFromStorage?.user_id,
          "user_token": "${store.userFromStorage?.user_token}",
          "child_id": "${spashControlller.childId}",
        });

      case PrescriptionType.register:
        final prescriptionChildController = Get.find<PrescriptionChildController>();

        var objectData = {
          "user_id": store.userFromStorage?.user_id,
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "add",
          "medicine_list": medicine_list,
          "guide": guide,
          "time_per_day": time_per_day,
          "begin": begin,
          "end": end,
          "child_id": child_id,
        };
        if (prescriptionChildController.selectedImagePath.value != '') {
          objectData["file"] = MultipartFile(
            File(prescriptionChildController.selectedImagePath.value),
            filename: prescriptionChildController.selectedImageName.value);
        }
        return FormData(objectData);
    }
  }

  @override
  String get endpoint => APIEndpoint.endpoint;

  @override
  String get path {
    switch (type) {
      case PrescriptionType.prescription:
        return "/manageClassMedicineShow";
      case PrescriptionType.take_medicines:
      case PrescriptionType.add:
        return "/manageClassMedicine";
      case PrescriptionType.show_child:
        return "/manageClassChildShow";
      case PrescriptionType.prescriptionChild:
        return "/manageChildMedicineShow";
      case PrescriptionType.register:
        return "/manageChildMedicine";
    }
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
