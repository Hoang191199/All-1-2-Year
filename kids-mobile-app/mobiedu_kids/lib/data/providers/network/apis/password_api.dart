import 'package:get/get.dart';
import 'package:mobiedu_kids/data/providers/network/api_endpoint.dart';
import 'package:mobiedu_kids/data/providers/network/api_provider.dart';
import 'package:mobiedu_kids/data/providers/network/api_request_representable.dart';

enum PasswordType { forget, retrieve }

class PasswordAPI implements APIRequestRepresentable {
  final PasswordType type;
  String? otp;
  String? newPassword;
  String? rePassword;
  String? email;

  PasswordAPI._(
      {required this.type,
      this.otp,
      this.newPassword,
      this.rePassword,
      this.email});

  PasswordAPI.forget(String email)
      : this._(
          type: PasswordType.forget,
          email: email,
        );

  PasswordAPI.retrieve(
      String email, String otp, String newPassword, String rePassword)
      : this._(
            type: PasswordType.retrieve,
            email: email,
            otp: otp,
            newPassword: newPassword,
            rePassword: rePassword);

  @override
  FormData get form {
    switch (type) {
      case PasswordType.forget:
        return FormData({"email": "$email"});
      case PasswordType.retrieve:
        return FormData({
          "email": "$email",
          "reset_key": "$otp",
          "password": "$newPassword",
          "confirm_password": "$rePassword"
        });
    }
  }

  @override
  String get endpoint => APIEndpoint.endpoint;

  @override
  String get path {
    switch (type) {
      case PasswordType.forget:
        return "/forgetPassword";
      case PasswordType.retrieve:
        return "/forgetPasswordReset";
    }
  }

  @override
  String get url => endpoint + path;

  @override
  HTTPMethod get method {
    switch (type) {
      case PasswordType.forget:
        return HTTPMethod.post;
      case PasswordType.retrieve:
        return HTTPMethod.post;
    }
  }

  @override
  Map<String, String>? get headers => {};

  @override
  Map<String, String>? get query => {};

  @override
  get body {
    switch (type) {
      case PasswordType.forget:
        return form;
      case PasswordType.retrieve:
        return form;
    }
  }

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }
}
