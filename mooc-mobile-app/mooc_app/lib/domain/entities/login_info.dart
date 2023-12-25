class LogInfo {
  LogInfo({
    required this.fullname,
    this.code,
    required this.email,
    required this.phone,
    required this.action,
    required this.actionGroup,
    required this.content,
    required this.createdAt,
    required this.ip,
    required this.agent
  });

  String fullname;
  String? code;
  String email;
  String phone;
  String action;
  String actionGroup;
  String content;
  String createdAt;
  String ip;
  String agent;

  factory LogInfo.fromJson(Map<String, dynamic>? json) {
    return LogInfo(
      fullname: json?['fullname'] as String,
      code: json?["code"] == null ? null : json?['code'] as String,
      email: json?['email'] as String,
      phone: json?['phone'] as String,
      action: json?['action'] as String,
      actionGroup: json?['actionGroup'] as String,
      content: json?['content'] as String,
      createdAt: json?['createdAt'] as String,
      ip: json?['ip'] as String,
      agent: json?['agent'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    "fullname": fullname,
    "code": code,
    "email": email,
    "phone": phone,
    "action": action,
    "actionGroup": actionGroup,
    "content": content,
    "createdAt": createdAt,
    "ip": ip,
    "agent": agent
  };
}