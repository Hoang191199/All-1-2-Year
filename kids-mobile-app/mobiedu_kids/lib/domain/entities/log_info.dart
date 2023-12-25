class LogInfo {
  LogInfo({
    this.username,
    this.password,
  });

  String? username;
  String? password;

  factory LogInfo.fromJson(Map<String, dynamic>? json) {
    return LogInfo(
      username: json?["username"] == null ? null : json?['username'] as String,
      password: json?["password"] == null ? null : json?['password'] as String,
    );
  }

  Map<String, dynamic> toJson() => {'username': username, 'password': password};
}
