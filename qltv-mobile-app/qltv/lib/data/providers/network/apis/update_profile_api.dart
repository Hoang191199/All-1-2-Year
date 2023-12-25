import 'package:get/get.dart';
import 'package:qltv/presentation/controllers/login/login_controller.dart';
import '../../../../app/services/local_storage.dart';
import '../api_endpoint.dart';
import '../api_provider.dart';
import '../api_request_representable.dart';

class UpdateProfileAPI implements APIRequestRepresentable {
  final store = Get.find<LocalStorageService>();
  String fullname;
  String email;
  String phone;
  String birthday;
  int gender;
  String description;
  String avatar_url;
  UpdateProfileAPI._(
      {required this.fullname,
      required this.email,
      required this.phone,
      required this.birthday,
      required this.gender,
      required this.description,
      required this.avatar_url});
  UpdateProfileAPI.updateProfile(String fullname, String email, String phone,
      String birthday, int gender, String description, String avatar_url)
      : this._(
            fullname: fullname,
            email: email,
            phone: phone,
            birthday: birthday,
            gender: gender,
            description: description,
            avatar_url: avatar_url);

  @override
  String get endpoint => APIEndpoint.endpointTest;

  @override
  String get path {
    final login = Get.find<LoginController>();
    final siteId = login.userLogin?.default_site_id;
    return "/$siteId/me";
  }

  @override
  String get url => endpoint + path;

  @override
  HTTPMethod get method {
    return HTTPMethod.put;
  }

  @override
  Map<String, String> get headers =>
      {"Authorization": "Bearer ${store.accessTokenFromStorage}"};

  @override
  get query => null;

  @override
  get body {
    return {
      "fullname": fullname,
      "email": email,
      "phone": phone,
      "birthday": birthday,
      "gender": gender,
      "description": description,
      "avatar_url": avatar_url
    };
  }

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }
}
