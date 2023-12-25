import 'package:qltv/data/providers/network/api_endpoint.dart';
import 'package:qltv/data/providers/network/api_provider.dart';
import 'package:qltv/data/providers/network/api_request_representable.dart';

enum LoginType { forget, change }

class PasswordAPI implements APIRequestRepresentable {
  // final store = Get.find<LocalStorageService>();
  final LoginType type;
  String? email;
  String? otp;
  String? newpass;

  PasswordAPI._({required this.type, this.email, this.newpass, this.otp});

  PasswordAPI.change(String email, String otp, String newpass)
      : this._(
            type: LoginType.change, email: email, otp: otp, newpass: newpass);

  PasswordAPI.forget(String email)
      : this._(
          type: LoginType.forget,
          email: email,
        );

  @override
  String get endpoint => APIEndpoint.endpointTest;

  @override
  String get path {
    switch (type) {
      case LoginType.forget:
        return '/forget_password';
      case LoginType.change:
        return '/change_password_by_otp';
    }
  }

  @override
  String get url => endpoint + path;

  @override
  HTTPMethod get method {
    switch (type) {
      case LoginType.change:
        return HTTPMethod.put;
      case LoginType.forget:
        return HTTPMethod.get;
    }
  }

  @override
  Map<String, String> get headers => {};
  // {"Authorization": "Bearer ${store.accessTokenFromStorage}"};

  @override
  Map<String, String>? get query {
    switch (type) {
      case LoginType.forget:
        return {
          "email": "$email",
        };
      default:
        return {};
    }
  }

  @override
  get body {
    switch (type) {
      case LoginType.change:
        return {"email": email, "otp": otp, "new_password": newpass};
      default:
        return null;
    }
  }

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }
}
