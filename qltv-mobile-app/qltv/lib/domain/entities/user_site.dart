import 'package:qltv/domain/entities/metadata_profile.dart';

class UserSite {
  UserSite({
    this.role,
    this.code,
    this.metadata,
    this.user_id,
    this.site_id,
    this.created_by,
    this.fullname,
    this.created_at,
    this.updated_at,
    this.deleted_at,
    this.userId,
    this.siteId,
  });

  String? role;
  String? code;
  MetaDataProfile? metadata;
  int? user_id;
  int? site_id;
  int? created_by;
  String? fullname;
  String? created_at;
  String? updated_at;
  String? deleted_at;
  int? userId;
  int? siteId;

  factory UserSite.fromJson(Map<String, dynamic>? json) {
    return UserSite(
      role: json?["role"] == null ? null : json?['role'] as String,
      code: json?["code"] == null ? null : json?['code'] as String,
      metadata: json?["metadata"] == null
          ? null
          : MetaDataProfile.fromJson(json?['metadata']),
      user_id: json?["user_id"] == null ? null : json?['user_id'] as int,
      site_id: json?["site_id"] == null ? null : json?['site_id'] as int,
      created_by:
          json?["created_by"] == null ? null : json?['created_by'] as int,
      fullname: json?["fullname"] == null ? null : json?['fullname'] as String,
      created_at:
          json?["created_at"] == null ? null : json?['created_at'] as String,
      updated_at:
          json?["updated_at"] == null ? null : json?['updated_at'] as String,
      deleted_at:
          json?["deleted_at"] == null ? null : json?['deleted_at'] as String,
      userId: json?["userId"] == null ? null : json?['userId'] as int,
      siteId: json?["siteId"] == null ? null : json?['siteId'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        "role": role,
        "code": code,
        "metadata": metadata,
        "user_id": user_id,
        "site_id": site_id,
        "created_by": created_by,
        "fullname": fullname,
        "created_at": created_at,
        "updated_at": updated_at,
        "deleted_at": deleted_at,
        "UserId": userId,
        "SiteId": siteId
      };
}
