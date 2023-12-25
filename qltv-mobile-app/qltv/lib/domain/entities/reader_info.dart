import 'package:qltv/domain/entities/borrowing.dart';
import 'package:qltv/domain/entities/sites.dart';
import 'package:qltv/domain/entities/user_site.dart';

class ReaderInfo {
  ReaderInfo({
    this.id,
    this.phone,
    this.email,
    this.is_blocked,
    this.created_at,
    this.userSite,
    this.sites,
    this.borrowing,
  });

  String? id;
  String? email;
  String? phone;
  bool? is_blocked;
  String? created_at;
  UserSite? userSite;
  List<Sites>? sites;
  Borrowing? borrowing;

  factory ReaderInfo.fromJson(Map<String, dynamic>? json) {
    return ReaderInfo(
      id: json?["id"] == null ? null : json?["id"] as String,
      phone: json?["phone"] == null ? null : json?["phone"] as String,
      email: json?["email"] == null ? null : json?["email"] as String,
      is_blocked:
          json?["is_blocked"] == null ? null : json?["is_blocked"] as bool,
      created_at:
          json?["created_at"] == null ? null : json?["created_at"] as String,
      userSite: json?["UserSite"] == null
          ? null
          : UserSite.fromJson(json?['UserSite']),
      sites: json?["sites"] == null
          ? null
          : List<Sites>.from(json?["sites"].map((x) => Sites.fromJson(x))),
      borrowing: json?["borrowing"] == null
          ? null
          : Borrowing.fromJson(json?['borrowing']),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "phone": phone,
        "is_blocked": is_blocked,
        "created_at": created_at,
        "UserSite": userSite,
        "sites": sites,
        "borrowing": borrowing,
      };
}
