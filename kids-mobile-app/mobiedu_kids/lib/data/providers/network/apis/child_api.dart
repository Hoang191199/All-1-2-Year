import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/data/providers/network/api_endpoint.dart';
import 'package:mobiedu_kids/data/providers/network/api_provider.dart';
import 'package:mobiedu_kids/data/providers/network/api_request_representable.dart';

enum ChildType {
  get,
  detail,
  detail_parent,
  add,
  edit,
  edit_parent,
  upload,
  search,
  searchDiary,
  addGrowth,
  addPhoto,
  infomation,
  overview,
  searchUser,
  searchCode
}

class ChildAPI implements APIRequestRepresentable {
  final ChildType type;
  String? child_id;
  String? child_code;
  String? nickname;
  Uint8List? file;
  String? date;
  int? year;
  String? page;
  String? group_name;
  String? code_auto;
  String? first_name;
  String? last_name;
  String? description;
  String? gender;
  String? parent_phone;
  String? parent_name;
  String? parent_email;
  String? create_parent_account;
  String? address;
  String? birthday;
  String? begin_at;
  String? pre_tuition_receive;
  String? password;
  String? caption;
  String? q;
  String? blood_type;
  String? hobby;
  String? allergy;
  int? parentNum;
  List<String>? parent;

  final store = Get.find<LocalStorageService>();

  ChildAPI._(
      {required this.type,
      this.child_id,
      this.child_code,
      this.nickname,
      this.file,
      this.date,
      this.year,
      this.page,
      this.group_name,
      this.code_auto,
      this.first_name,
      this.last_name,
      this.description,
      this.gender,
      this.parent_phone,
      this.parent_name,
      this.parent_email,
      this.create_parent_account,
      this.address,
      this.birthday,
      this.begin_at,
      this.pre_tuition_receive,
      this.password,
      this.caption,
      this.q,
      this.blood_type,
      this.hobby,
      this.allergy,
      this.parentNum,
      this.parent});

  ChildAPI.get(String group_name)
      : this._(type: ChildType.get, group_name: group_name);

  ChildAPI.detail(String group_name, String child_id)
      : this._(
            type: ChildType.detail, child_id: child_id, group_name: group_name);

  ChildAPI.detail_parent(String child_id)
      : this._(type: ChildType.detail_parent, child_id: child_id);

  ChildAPI.add(
      String group_name,
      String code_auto,
      String first_name,
      String last_name,
      String description,
      String gender,
      String parent_phone,
      String parent_name,
      String parent_email,
      String create_parent_account,
      String address,
      String birthday,
      String begin_at,
      String pre_tuition_receive,
      String password,
      List<String> parent,
      int parentNum)
      : this._(
            type: ChildType.add,
            group_name: group_name,
            code_auto: code_auto,
            first_name: first_name,
            last_name: last_name,
            description: description,
            gender: gender,
            parent_phone: parent_phone,
            parent_name: parent_name,
            parent_email: parent_email,
            create_parent_account: create_parent_account,
            address: address,
            birthday: birthday,
            begin_at: begin_at,
            pre_tuition_receive: pre_tuition_receive,
            password: password,
            parent: parent,
            parentNum: parentNum);

  ChildAPI.edit(
      String group_name,
      String child_id,
      String child_code,
      String first_name,
      String last_name,
      String description,
      String gender,
      String parent_phone,
      String parent_name,
      String parent_email,
      String create_parent_account,
      String address,
      String birthday,
      String begin_at,
      String pre_tuition_receive,
      String password,
      List<String> parent,
      int parentNum)
      : this._(
            type: ChildType.edit,
            group_name: group_name,
            child_id: child_id,
            child_code: child_code,
            first_name: first_name,
            last_name: last_name,
            description: description,
            gender: gender,
            parent_phone: parent_phone,
            parent_name: parent_name,
            parent_email: parent_email,
            create_parent_account: create_parent_account,
            address: address,
            birthday: birthday,
            begin_at: begin_at,
            pre_tuition_receive: pre_tuition_receive,
            password: password,
            parent: parent,
            parentNum: parentNum);

  ChildAPI.edit_parent(
      String child_id,
      String first_name,
      String last_name,
      String nickname,
      String description,
      String gender,
      String parent_phone,
      String parent_name,
      String parent_email,
      String address,
      String birthday,
      String blood_type,
      String hobby,
      String allergy,
      List<String> parent,
      int parentNum)
      : this._(
            type: ChildType.edit_parent,
            child_id: child_id,
            first_name: first_name,
            last_name: last_name,
            nickname: nickname,
            description: description,
            gender: gender,
            parent_phone: parent_phone,
            parent_name: parent_name,
            parent_email: parent_email,
            address: address,
            birthday: birthday,
            blood_type: blood_type,
            hobby: hobby,
            allergy: allergy,
            parent: parent,
            parentNum: parentNum);

  ChildAPI.upload(String child_id, Uint8List file)
      : this._(
            type: ChildType.upload, child_id: child_id, file: file);          

  ChildAPI.search(String group_name, String child_id)
      : this._(
            type: ChildType.search, child_id: child_id, group_name: group_name);

  ChildAPI.searchDiary(String group_name, String child_id, int year)
      : this._(
            type: ChildType.searchDiary,
            child_id: child_id,
            group_name: group_name,
            year: year);

  ChildAPI.addGrowth(
      String group_name, String child_id, String date, Uint8List file)
      : this._(
            type: ChildType.addGrowth,
            group_name: group_name,
            child_id: child_id,
            date: date,
            file: file);

  ChildAPI.addPhoto(
      String group_name, String child_id, String caption, Uint8List file)
      : this._(
            type: ChildType.addPhoto,
            group_name: group_name,
            child_id: child_id,
            caption: caption,
            file: file);

  ChildAPI.infomation(String group_name, String child_id)
      : this._(
            type: ChildType.infomation,
            child_id: child_id,
            group_name: group_name);

  ChildAPI.overview(String child_id)
      : this._(
            type: ChildType.overview,
            child_id: child_id,);          

  ChildAPI.searchUser(String q, String page, List<String> parent, int parentNum)
      : this._(
            type: ChildType.searchUser,
            q: q,
            page: page,
            parent: parent,
            parentNum: parentNum);

  ChildAPI.searchCode(String group_name, String child_code)
      : this._(
          type: ChildType.searchCode,
          group_name: group_name,
          child_code: child_code,
        );

  @override
  FormData get form {
    switch (type) {
      case ChildType.get:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "show_active_children_short",
          "group_name": "$group_name"
        });
      case ChildType.detail:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "detail",
          "child_id": "$child_id",
          "group_name": "$group_name"
        });
      case ChildType.detail_parent:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "detail",
          "child_parent_id": "$child_id",
        });
      case ChildType.add:
        var formData = {
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "add",
          "group_name": "$group_name",
          "code_auto": "$code_auto",
          "first_name": "$first_name",
          "last_name": "$last_name",
          "description": "$description",
          "gender": "$gender",
          "parent_phone": "$parent_phone",
          "parent_name": "$parent_name",
          "parent_email": "$parent_email",
          "create_parent_account": "$create_parent_account",
          "address": "$address",
          "birthday": "$birthday",
          "begin_at": "$begin_at",
          "pre_tuition_receive": "$pre_tuition_receive",
          "password": "$password",
        };

        for (var i = 0; i < parentNum!; i++) {
          formData["user_id_parent[$i]"] = "${parent?[i]}";
        }

        return FormData(formData);
      case ChildType.edit_parent:
        var formData = {
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "edit",
          "child_parent_id": "$child_id",
          "first_name": "$first_name",
          "last_name": "$last_name",
          "nickname": "$nickname",
          "description": "$description",
          "gender": "$gender",
          "parent_phone": "$parent_phone",
          "parent_name": "$parent_name",
          "parent_email": "$parent_email",
          "address": "$address",
          "birthday": "$birthday",
          "blood_type": "$blood_type",
          "hobby": "$hobby",
          "allergy": "$allergy",
          "is_file": 1
        };

        for (var i = 0; i < parentNum!; i++) {
          formData["parent_ids[$i]"] = "${parent?[i]}";
        }

        return FormData(formData);
      case ChildType.upload:
        var formData = {
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "change_avatar",
          "child_parent_id": "$child_id",
          "is_file": "1",
          "file": MultipartFile(file, filename: "photo.jpg")
        };

        return FormData(formData);  
      case ChildType.edit:
        var formData = {
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "edit",
          "group_name": "$group_name",
          "child_id": "$child_id",
          "child_code": "$child_code",
          "first_name": "$first_name",
          "last_name": "$last_name",
          "description": "$description",
          "gender": "$gender",
          "parent_phone": "$parent_phone",
          "parent_name": "$parent_name",
          "parent_email": "$parent_email",
          "create_parent_account": "$create_parent_account",
          "address": "$address",
          "birthday": "$birthday",
          "begin_at": "$begin_at",
          "pre_tuition_receive": "$pre_tuition_receive",
          "password": "$password",
        };

        for (var i = 0; i < parentNum!; i++) {
          formData["user_id_parent[$i]"] = "${parent?[i]}";
        }

        return FormData(formData);
      case ChildType.search:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "search",
          "group_name": "$group_name",
          "child_id": "$child_id"
        });
      case ChildType.searchDiary:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "search_diary",
          "group_name": "$group_name",
          "child_id": "$child_id",
          "year": "$year",
        });
      case ChildType.addGrowth:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "add_growth",
          "group_name": "$group_name",
          "child_id": "$child_id",
          "recorded_at": "$date",
          "file": MultipartFile(file, filename: "image.jpg")
        });
      case ChildType.addPhoto:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "group_name": "$group_name",
          "do": "add_photo",
          "child_id": "$child_id",
          "caption": "$caption",
          "file[0]": MultipartFile(file, filename: "avatar.jpg")
        });
      case ChildType.infomation:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "list_child_picker",
          "group_name": "$group_name",
          "child_id": "$child_id",
        });
      case ChildType.overview:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "show_overview",
          "child_parent_id": "$child_id",
        });  
      case ChildType.searchUser:
        var formData = {
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "type": "parent",
          "page": "$page",
          "query": "$q",
        };

        for (var i = 0; i < parentNum!; i++) {
          formData["parent_id[$i]"] = "${parent?[i]}";
        }

        return FormData(formData);
      case ChildType.searchCode:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "searchchildexist",
          "group_name": "$group_name",
          "child_code": "$child_code",
        });
    }
  }

  @override
  String get endpoint => APIEndpoint.endpoint;

  @override
  String get path {
    switch (type) {
      case ChildType.get:
      case ChildType.detail:
        return "/manageClassChildShow";
      case ChildType.detail_parent:
      case ChildType.edit_parent:
      case ChildType.upload:
        return "/manageChildBasicInformation";
      case ChildType.add:
      case ChildType.edit:
      case ChildType.search:
      case ChildType.searchDiary:
      case ChildType.addGrowth:
      case ChildType.addPhoto:
      case ChildType.searchCode:
        return "/manageClassChild";
      case ChildType.infomation:
        return "/manageClassChildInformation";
      case ChildType.overview:
        return "/manageChildOverviewInformation";
      case ChildType.searchUser:
        return "/searchUser";
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
  get body {
    return form;
  }

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }
}
