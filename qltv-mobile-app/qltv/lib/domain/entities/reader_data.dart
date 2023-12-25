class ReaderData {
  ReaderData({
    this.id,
    this.fullname,
    this.phone,
    this.email,
    this.role,
    this.gender,
    this.birthday,
    this.subject,
    this.start_years,
    this.end_years,
    this.avatar_url,
    this.code,
    this.expired_date,
    this.organizations,
  });

  int? id;
  String? fullname;
  String? phone;
  String? email;
  String? role;
  int? gender;
  String? birthday;
  String? subject;
  int? start_years;
  int? end_years;
  String? avatar_url;
  String? code;
  String? expired_date;
  String? organizations;

  factory ReaderData.fromJson(Map<String, dynamic>? json) {
    return ReaderData(
      id: json?["id"] == null ? null : json?['id'] as int,
      fullname: json?["fullname"] == null ? null : json?['fullname'] as String,
      phone: json?["phone"] == null ? null : json?['phone'] as String,
      email: json?["email"] == null ? null : json?['email'] as String,
      role: json?["role"] == null ? null : json?['role'] as String,
      gender: json?["gender"] == null ? null : json?['gender'] as int,
      birthday: json?["birthday"] == null ? null : json?['birthday'] as String,
      subject: json?["subject"] == null ? null : json?['subject'] as String,
      avatar_url:
          json?["avatar_url"] == null ? null : json?['avatar_url'] as String,
      start_years:
          json?["start_years"] == null ? null : json?['start_years'] as int,
      end_years: json?["end_years"] == null ? null : json?['end_years'] as int,
      code: json?["code"] == null ? null : json?['code'] as String,
      expired_date: json?["expired_date"] == null
          ? null
          : json?['expired_date'] as String,
      organizations: json?["organizations"] == null
          ? null
          : json?['organizations'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullname': fullname,
        'phone': phone,
        'email': email,
        'role': role,
        'gender': gender,
        'birthday': birthday,
        'subject': subject,
        'start_years': start_years,
        'end_years': end_years,
        'avatar_url': avatar_url,
        'code': code,
        'expired_date': expired_date,
        'organizations': organizations
      };
}
