import 'package:qltv/domain/entities/user_site.dart';

class Sites {
  Sites({this.id, this.name, this.userSite});

  int? id;
  String? name;
  UserSite? userSite;

  factory Sites.fromJson(Map<String, dynamic>? json) {
    return Sites(
      id: json?["id"] == null ? null : json?["id"] as int,
      name: json?["name"] == null ? null : json?["name"] as String,
      userSite: json?["UserSite"] == null
          ? null
          : UserSite.fromJson(json?["UserSite"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "UserSite": userSite,
      };
}
