class PermissionInfo {
  PermissionInfo({
    this.name,
    this.code,
    this.access_level,
  });

  String? name;
  String? code;
  int? access_level;

  factory PermissionInfo.fromJson(Map<String, dynamic>? json) {
    return PermissionInfo(
      name: json?["name"] == null ? null : json?["name"] as String,
      code: json?["code"] == null ? null : json?["code"] as String,
      access_level:
          json?["access_level"] == null ? null : json?["access_level"] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "access_level": access_level,
      };
}
