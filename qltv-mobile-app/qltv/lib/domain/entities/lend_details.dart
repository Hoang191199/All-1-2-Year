class LendDetails {
  LendDetails({
    this.identification_number,
    this.title,
    this.code,
    this.user_code,
    this.fullname,
    this.receipt_date,
    this.return_date,
    this.real_return_date,
    this.is_punishment,
    this.punishment_reason,
    this.forfeit,
  });

  String? identification_number;
  String? title;
  String? code;
  String? user_code;
  String? fullname;
  String? receipt_date;
  String? return_date;
  String? real_return_date;
  bool? is_punishment;
  String? punishment_reason;
  int? forfeit;

  factory LendDetails.fromJson(Map<String, dynamic>? json) {
    return LendDetails(
      identification_number: json?["identification_number"] == null ? null : json?["identification_number"] as String,
      title:json?["title"] == null ? null : json?["title"] as String,
      code: json?["code"] == null ? null : json?["code"] as String,
      user_code: json?["user_code"] == null ? null : json?["user_code"] as String,
      fullname :json?["fullname"] == null ? null : json?["fullname"] as String,
      receipt_date :json?["receipt_date"] == null ? null : json?["receipt_date"] as String,
      return_date :json?["return_date"] == null ? null : json?["return_date"] as String,
      real_return_date :json?["real_return_date"] == null ? null : json?["real_return_date"] as String,
      is_punishment :json?["is_punishment"] == null ? null : json?["is_punishment"] as bool,
      punishment_reason :json?["punishment_reason"] == null ? null : json?["punishment_reason"] as String,
      forfeit: json?["forfeit"] == null ? null : json?["forfeit"] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    "identification_number": identification_number,
    "title": title,
    "code": code,
    "user_code": user_code,
    "fullname": fullname,
    "receipt_date": receipt_date,
    "return_date": return_date,
    "real_return_date": real_return_date,
    "is_punishment": is_punishment,
    "punishment_reason": punishment_reason,
    "forfeit": forfeit
  };
}