import 'package:get/get.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/data/providers/network/api_endpoint.dart';
import 'package:mobiedu_kids/data/providers/network/api_provider.dart';
import 'package:mobiedu_kids/data/providers/network/api_request_representable.dart';

enum LogType { login , logout }

class LogAPI implements APIRequestRepresentable {
  final LogType type;
  String? username;
  String? password;

  final store = Get.find<LocalStorageService>();

  LogAPI._({
    required this.type,
    this.username,
    this.password,
  });

  LogAPI.login(String username, String password)
      : this._(
          type: LogType.login,
          username: username,
          password: password,
        );

  LogAPI.logout()
      : this._(
          type: LogType.logout,
        );      

  @override
  FormData get form {
    switch (type) {
      case LogType.login:
        return FormData({
          "device_token":
              "ekijasxsJys:APA91bEgynHBlfZykZsYTQMas1NVAHooDLHysy1UJvxCmBqrLk5CO4jCLoCER8WT3Q-_EH9HkCq3duerKa9P4fwJB_uJqNpeyJG6yuq2HawwxuNh6PcZbO6W-mMiAO50fGO1TfQVwd9Q",
          "force_update": 1,
          "username_email": "$username",
          "password": "$password"
        });
      case LogType.logout:
        return FormData({
          "user_id": "${store.userFromStorage?.user_id}",
          "user_token": "${store.userFromStorage?.user_token}"
        });  
    }
  }

  @override
  String get endpoint => APIEndpoint.endpoint;

  @override
  String get path {
    switch (type) {
      case LogType.login:
        return "/signin";
      case LogType.logout:
        return "/signout";
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
    switch (type) {
      case LogType.login:
        return form;
      case LogType.logout:
        return form;  
    }
  }

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }
}
