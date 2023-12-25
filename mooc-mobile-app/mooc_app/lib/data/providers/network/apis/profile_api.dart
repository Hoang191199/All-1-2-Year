import 'package:get/get.dart';
import 'package:mooc_app/data/providers/network/api_endpoint.dart';
import 'package:mooc_app/data/providers/network/api_provider.dart';
import 'package:mooc_app/data/providers/network/api_request_representable.dart';

import '../../../../app/services/local_storage.dart';

enum ProfileType { fetchProfile, updateProfile }

class ProfileAPI implements APIRequestRepresentable {
  final store = Get.find<LocalStorageService>();
  final ProfileType type;
  String? fullname;
  String? email;
  String? phone;
  String? dob;
  String? avatar;
  String? address;
  String? gender;
  String? city;
  ProfileAPI._(
      {required this.type,
      this.fullname,
      this.email,
      this.phone,
      this.dob,
      this.avatar,
      this.address,
      this.gender,
      this.city});
  ProfileAPI.fetchProfile() : this._(type: ProfileType.fetchProfile);
  ProfileAPI.updateProfile(String fullname, String email, String? phone,
      String? dob, String? avatar, String address, String gender, String city)
      : this._(
            type: ProfileType.updateProfile,
            fullname: fullname,
            email: email,
            phone: phone,
            dob: dob,
            avatar: avatar,
            address: address,
            gender: gender,
            city: city);

  @override
  String get endpoint => APIEndpoint.endpointTestMooc;

  @override
  String get path {
    switch (type) {
      case ProfileType.fetchProfile:
        return "/auth/restapi/user/profile";
      case ProfileType.updateProfile:
        return "/auth/restapi/user/editprofile";
    }
  }

  @override
  String get url => endpoint + path;

  @override
  HTTPMethod get method {
    switch (type) {
      case ProfileType.updateProfile:
        return HTTPMethod.patch;
      default:
        return HTTPMethod.get;
    }
  }

  @override
  Map<String, String> get headers =>
      {"Authorization": "Bearer ${store.tokenFromStorage}"};

  @override
  get query => null;

  @override
  get body {
    switch (type) {
      case ProfileType.updateProfile:
        return {
          "fullname": "$fullname",
          "email": "$email",
          "phone": "$phone",
          "dob": "$dob",
          "avatar": "$avatar",
          "address": "$address",
          "gender": "$gender",
          "city": "$city"
        };
      default:
        return null;
    }
  }

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }
}
