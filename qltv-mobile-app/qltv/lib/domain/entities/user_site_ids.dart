import 'package:qltv/domain/entities/metadata_profile.dart';

class UserSiteIds {
  UserSiteIds({
    this.metadata,
  });

  MetaDataProfile? metadata;

  factory UserSiteIds.fromJson(Map<String, dynamic>? json) {
    return UserSiteIds(
      metadata: json?["metadata"] == null ? null : MetaDataProfile.fromJson(json?['metadata']),
    );
  }

  Map<String, dynamic> toJson() => {
    "metadata": metadata,
  };
}
