import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/data/providers/network/api_endpoint.dart';
import 'package:mobiedu_kids/data/providers/network/api_provider.dart';
import 'package:mobiedu_kids/data/providers/network/api_request_representable.dart';

enum GrowthType {
  get,
  getChild,
  add,
  addChild,
  edit,
  editChild,
  // editalt,
  // editaltChild,
  delete,
  deleteChild
}

class GrowthAPI implements APIRequestRepresentable {
  final GrowthType type;
  String? child_id;
  Uint8List? file;
  String? date;
  String? group_name;
  String? child_growth_id;
  String? height;
  String? weight;
  String? nutriture_status;
  String? ear;
  String? eye;
  String? blood_pressure;
  String? heart;
  String? nose;
  String? description;
  String? month_begin;
  String? month_end;

  final store = Get.find<LocalStorageService>();

  GrowthAPI._(
      {required this.type,
      this.file,
      this.date,
      this.child_id,
      this.group_name,
      this.child_growth_id,
      this.height,
      this.weight,
      this.nutriture_status,
      this.ear,
      this.eye,
      this.blood_pressure,
      this.heart,
      this.nose,
      this.description,
      this.month_begin,
      this.month_end});

  GrowthAPI.get(String group_name, String child_id)
      : this._(
            type: GrowthType.get, child_id: child_id, group_name: group_name);

  GrowthAPI.getChild(String child_id, String month_begin, String month_end)
      : this._(
            type: GrowthType.getChild,
            child_id: child_id,
            month_begin: month_begin,
            month_end: month_end);

  GrowthAPI.add(
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
      Uint8List? file)
      : this._(
            type: GrowthType.add,
            group_name: group_name,
            child_id: child_id,
            date: date,
            height: height,
            weight: weight,
            nutriture_status: nutriture_status,
            ear: ear,
            eye: eye,
            blood_pressure: blood_pressure,
            heart: heart,
            nose: nose,
            description: description,
            file: file);

  GrowthAPI.addChild(
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
      Uint8List? file)
      : this._(
            type: GrowthType.addChild,
            child_id: child_id,
            date: date,
            height: height,
            weight: weight,
            nutriture_status: nutriture_status,
            ear: ear,
            eye: eye,
            blood_pressure: blood_pressure,
            heart: heart,
            nose: nose,
            description: description,
            file: file);

  GrowthAPI.edit(
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
      Uint8List? file)
      : this._(
            type: GrowthType.edit,
            group_name: group_name,
            child_id: child_id,
            child_growth_id: child_growth_id,
            date: date,
            height: height,
            weight: weight,
            nutriture_status: nutriture_status,
            ear: ear,
            eye: eye,
            blood_pressure: blood_pressure,
            heart: heart,
            nose: nose,
            description: description,
            file: file);

  // GrowthAPI.editalt(
  //   String group_name,
  //   String child_id,
  //   String child_growth_id,
  //   String height,
  //   String weight,
  //   String nutriture_status,
  //   String ear,
  //   String eye,
  //   String blood_pressure,
  //   String heart,
  //   String nose,
  //   String description,
  //   String date,
  // ) : this._(
  //         type: GrowthType.editalt,
  //         group_name: group_name,
  //         child_id: child_id,
  //         child_growth_id: child_growth_id,
  //         date: date,
  //         height: height,
  //         weight: weight,
  //         nutriture_status: nutriture_status,
  //         ear: ear,
  //         eye: eye,
  //         blood_pressure: blood_pressure,
  //         heart: heart,
  //         nose: nose,
  //         description: description,
  //       );

  GrowthAPI.editChild(
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
      Uint8List? file)
      : this._(
            type: GrowthType.editChild,
            child_id: child_id,
            child_growth_id: child_growth_id,
            date: date,
            height: height,
            weight: weight,
            nutriture_status: nutriture_status,
            ear: ear,
            eye: eye,
            blood_pressure: blood_pressure,
            heart: heart,
            nose: nose,
            description: description,
            file: file);

  // GrowthAPI.editaltChild(
  //   String child_id,
  //   String child_growth_id,
  //   String height,
  //   String weight,
  //   String nutriture_status,
  //   String ear,
  //   String eye,
  //   String blood_pressure,
  //   String heart,
  //   String nose,
  //   String description,
  //   String date,
  // ) : this._(
  //         type: GrowthType.editaltChild,
  //         child_id: child_id,
  //         child_growth_id: child_growth_id,
  //         date: date,
  //         height: height,
  //         weight: weight,
  //         nutriture_status: nutriture_status,
  //         ear: ear,
  //         eye: eye,
  //         blood_pressure: blood_pressure,
  //         heart: heart,
  //         nose: nose,
  //         description: description,
  //       );

  GrowthAPI.delete(String group_name, String child_id, String child_growth_id)
      : this._(
            type: GrowthType.delete,
            group_name: group_name,
            child_id: child_id,
            child_growth_id: child_growth_id);

  GrowthAPI.deleteChild(String child_id, String child_growth_id)
      : this._(
            type: GrowthType.deleteChild,
            child_id: child_id,
            child_growth_id: child_growth_id);

  @override
  FormData get form {
    switch (type) {
      case GrowthType.get:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "search",
          "group_name": "$group_name",
          "child_id": "$child_id"
        });
      case GrowthType.getChild:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "search_chart",
          "child_parent_id": "$child_id",
          "month_begin": "$month_begin",
          "month_end": "$month_end"
        });
      case GrowthType.add:
        var formData = <String, Object>{
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "add_growth",
          "group_name": "$group_name",
          "child_id": "$child_id",
          "height": "$height",
          "weight": "$weight",
          "nutriture_status": "$nutriture_status",
          "ear": "$ear",
          "eye": "$eye",
          "blood_pressure": "$blood_pressure",
          "heart": "$heart",
          "nose": "$nose",
          "description": "$description",
          "recorded_at": "$date",
        };
        if (file != null) {
          formData["file"] = MultipartFile(file, filename: "image.jpg");
        }
        return FormData(formData);
      case GrowthType.addChild:
        var formData = <String, Object>{
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "add_growth",
          "child_parent_id": "$child_id",
          "height": "$height",
          "weight": "$weight",
          "nutriture_status": "$nutriture_status",
          "ear": "$ear",
          "eye": "$eye",
          "blood_pressure": "$blood_pressure",
          "heart": "$heart",
          "nose": "$nose",
          "description": "$description",
          "recorded_at": "$date",
        };
        if (file != null) {
          formData["file"] = MultipartFile(file, filename: "image.jpg");
        }
        return FormData(formData);
      case GrowthType.edit:
        var formData = <String, Object>{
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "edit_growth",
          "group_name": "$group_name",
          "child_id": "$child_id",
          "child_growth_id": "$child_growth_id",
          "height": "$height",
          "weight": "$weight",
          "nutriture_status": "$nutriture_status",
          "ear": "$ear",
          "eye": "$eye",
          "blood_pressure": "$blood_pressure",
          "heart": "$heart",
          "nose": "$nose",
          "description": "$description",
          "recorded_at": "$date",
        };
        if (file != null) {
          formData["file"] = MultipartFile(file, filename: "image.jpg");
        }
        return FormData(formData);
      // case GrowthType.editalt:
      //   return FormData({
      //     "user_id": "${store.userFromStorage?.user_id}",
      //     "user_token": "${store.userFromStorage?.user_token}",
      //     "do": "edit_growth",
      //     "group_name": "$group_name",
      //     "child_id": "$child_id",
      //     "child_growth_id": "$child_growth_id",
      //     "height": "$height",
      //     "weight": "$weight",
      //     "nutriture_status": "$nutriture_status",
      //     "ear": "$ear",
      //     "eye": "$eye",
      //     "blood_pressure": "$blood_pressure",
      //     "heart": "$heart",
      //     "nose": "$nose",
      //     "description": "$description",
      //     "recorded_at": "$date"
      //   });
      case GrowthType.editChild:
        var formData = <String, Object>{
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "edit_growth",
          "child_parent_id": "$child_id",
          "child_growth_id": "$child_growth_id",
          "height": "$height",
          "weight": "$weight",
          "nutriture_status": "$nutriture_status",
          "ear": "$ear",
          "eye": "$eye",
          "blood_pressure": "$blood_pressure",
          "heart": "$heart",
          "nose": "$nose",
          "description": "$description",
          "recorded_at": "$date",
        };
        if (file != null) {
          formData["file"] = MultipartFile(file, filename: "image.jpg");
        }
        return FormData(formData);
      // case GrowthType.editaltChild:
      //   return FormData({
      //     "user_id": "${store.userFromStorage?.user_id}",
      //     "user_token": "${store.userFromStorage?.user_token}",
      //     "do": "edit_growth",
      //     "child_parent_id": "$child_id",
      //     "child_growth_id": "$child_growth_id",
      //     "height": "$height",
      //     "weight": "$weight",
      //     "nutriture_status": "$nutriture_status",
      //     "ear": "$ear",
      //     "eye": "$eye",
      //     "blood_pressure": "$blood_pressure",
      //     "heart": "$heart",
      //     "nose": "$nose",
      //     "description": "$description",
      //     "recorded_at": "$date"
      //   });
      case GrowthType.delete:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "delete_growth",
          "group_name": "$group_name",
          "child_id": "$child_id",
          "child_growth_id": "$child_growth_id",
        });
      case GrowthType.deleteChild:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "delete_growth",
          "child_parent_id": "$child_id",
          "child_growth_id": "$child_growth_id",
        });
    }
  }

  @override
  String get endpoint => APIEndpoint.endpoint;

  @override
  String get path {
    switch (type) {
      case GrowthType.get:
      case GrowthType.add:
      case GrowthType.edit:
      // case GrowthType.editalt:
      case GrowthType.delete:
        return "/manageClassChild";
      case GrowthType.getChild:
      case GrowthType.addChild:
      case GrowthType.editChild:
      // case GrowthType.editaltChild:
      case GrowthType.deleteChild:
        return "/manageChildHealthInformation";
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
