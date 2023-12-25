import 'package:mooc_app/data/providers/network/api_endpoint.dart';
import 'package:mooc_app/data/providers/network/api_provider.dart';
import 'package:mooc_app/data/providers/network/api_request_representable.dart';

enum AuthType { ssoSignin }

class AuthAPI implements APIRequestRepresentable {
  final AuthType type;
  String? username;
  String? password;
  String? codeSSO;
  String? idDevice;

  AuthAPI._({
    required this.type, 
    this.password, 
    this.username,
    this.codeSSO,
    this.idDevice,
  });

  AuthAPI.login(String codeSSO, String idDevice) 
    : this._(
      type: AuthType.ssoSignin,
      codeSSO: codeSSO,
      idDevice: idDevice,
    );

  @override
  String get endpoint => APIEndpoint.endpointTestMooc;

  @override
  String get path {
    switch (type) {
      case AuthType.ssoSignin:
        return "/auth/user/ssosignin";
    }
  }

  @override
  String get url => endpoint + path;

  @override
  HTTPMethod get method {
    return HTTPMethod.get;
  }

  @override
  Map<String, String> get headers => {};

  Map<String, String> get query {
    switch (type) {
      case AuthType.ssoSignin:
        return {"code": "$codeSSO", "idDevice": "$idDevice"};
    };
  }

  @override
  get body => null;

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }
}
