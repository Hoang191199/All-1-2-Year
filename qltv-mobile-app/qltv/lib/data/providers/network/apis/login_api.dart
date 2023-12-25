import 'package:qltv/data/providers/network/api_endpoint.dart';
import 'package:qltv/data/providers/network/api_provider.dart';
import 'package:qltv/data/providers/network/api_request_representable.dart';

enum LoginType { login }

class LoginAPI implements APIRequestRepresentable {
  final LoginType type;
  String? username;
  String? password;

  LoginAPI._({
    required this.type, 
    this.username,
    this.password, 
  });

  LoginAPI.login(String username, String password) 
    : this._(
      type: LoginType.login,
      username: username,
      password: password,
    );

  @override
  String get endpoint => APIEndpoint.endpointTest;

  @override
  String get path {
    switch (type) {
      case LoginType.login:
        return "/auth/signin";
    }
  }

  @override
  String get url => endpoint + path;

  @override
  HTTPMethod get method {
    switch (type) {
      case LoginType.login:
        return HTTPMethod.post;
      default:
        return HTTPMethod.get;
    }
  }

  @override
  Map<String, String>? get headers => {};

  @override
  Map<String, String>? get query => {};

  @override
  get body {
    switch (type) {
      case LoginType.login:
        return {"username": username, "password": password};
    }
  }

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }
  
}