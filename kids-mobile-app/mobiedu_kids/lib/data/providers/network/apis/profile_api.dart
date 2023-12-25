import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';

import '../api_endpoint.dart';
import '../api_provider.dart';
import '../api_request_representable.dart';

enum ProfileType { get, detail, edit, update, password, resend }

class ProfileAPI implements APIRequestRepresentable {
  final store = Get.find<LocalStorageService>();
  final ProfileType type;
  String? kind;
  String? payload;
  String? user_name;
  int? page;
  String? first_name;
  String? last_name;
  String? gender;
  String? birth_day;
  String? user_phone;
  String? work_title;
  String? work_place;
  String? city;
  String? hometown;
  String? edu_major;
  String? edu_school;
  String? edu_class;
  String? city_id;
  String? identification_card_number;
  String? date_of_issue;
  String? place_of_issue;
  Uint8List? file;
  String? current_password;
  String? new_password;
  String? confirm_password;

  ProfileAPI._({
    required this.type,
    this.kind,
    this.payload,
    this.user_name,
    this.page,
    this.first_name,
    this.last_name,
    this.gender,
    this.birth_day,
    this.user_phone,
    this.work_title,
    this.work_place,
    this.city,
    this.hometown,
    this.edu_major,
    this.edu_school,
    this.edu_class,
    this.city_id,
    this.identification_card_number,
    this.date_of_issue,
    this.place_of_issue,
    this.file,
    this.current_password,
    this.new_password,
    this.confirm_password,
  });

  ProfileAPI.profile(String user_name, int page)
      : this._(
          type: ProfileType.get,
          user_name: user_name,
          page: page,
        );

  ProfileAPI.detail(String user_name)
      : this._(
          type: ProfileType.detail,
          user_name: user_name,
        );

  ProfileAPI.edit(String kind, String payload)
      : this._(type: ProfileType.edit, kind: kind, payload: payload);

  ProfileAPI.update(
      String first_name,
      String last_name,
      String gender,
      String birth_day,
      String user_phone,
      String work_title,
      String work_place,
      String city,
      String hometown,
      String edu_major,
      String edu_school,
      String edu_class,
      String city_id,
      String identification_card_number,
      String date_of_issue,
      String place_of_issue,
      Uint8List? file)
      : this._(
            type: ProfileType.update,
            first_name: first_name,
            last_name: last_name,
            gender: gender,
            birth_day: birth_day,
            user_phone: user_phone,
            work_title: work_title,
            work_place: work_place,
            city: city,
            hometown: hometown,
            edu_major: edu_major,
            edu_school: edu_school,
            edu_class: edu_class,
            city_id: city_id,
            identification_card_number: identification_card_number,
            date_of_issue: date_of_issue,
            place_of_issue: place_of_issue,
            file: file);

  ProfileAPI.password(
      String current_password, String new_password, String confirm_password)
      : this._(
            type: ProfileType.password,
            current_password: current_password,
            new_password: new_password,
            confirm_password: confirm_password);

  ProfileAPI.resend() : this._(type: ProfileType.resend);

  @override
  FormData get form {
    switch (type) {
      case ProfileType.get:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "username": "$user_name",
          "view": "all",
          "page": "$page"
        });
      case ProfileType.detail:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "username": "$user_name",
          "view": "profile",
        });
      case ProfileType.edit:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "edit": "$kind",
          "$kind": "$payload",
        });
      case ProfileType.update:
        var formData = <String, Object>{
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "edit": "profile",
          "first_name": "$first_name",
          "last_name": "$last_name",
          "gender": "$gender",
          "birth_day": "$birth_day",
          // "user_phone": "$user_phone",
          "work_title": "$work_title",
          "work_place": "$work_place",
          "city": "$city",
          "hometown": "$hometown",
          "edu_major": "$edu_major",
          "edu_school": "$edu_school",
          "edu_class": "$edu_class",
          "city_id": "$city_id",
          "identification_card_number": "$identification_card_number",
          "date_of_issue": "$date_of_issue",
          "place_of_issue": "$place_of_issue",
        };
        if (file != null) {
          formData["photo"] = MultipartFile(file, filename: "avatar.jpg");
        }
        return FormData(formData);
      case ProfileType.password:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "edit": "password",
          "current_password": "$current_password",
          "new_password": "$new_password",
          "confirm_password": "$confirm_password",
        });
      case ProfileType.resend:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}",
          "do": "resend_email",
        });
    }
  }

  @override
  String get endpoint => APIEndpoint.endpoint;

  @override
  String get path {
    switch (type) {
      case ProfileType.get:
      case ProfileType.detail:
        return "/homePage";
      case ProfileType.edit:
      case ProfileType.update:
      case ProfileType.password:
        return "/updateProfile";
      case ProfileType.resend:
        return "/userActive";
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
