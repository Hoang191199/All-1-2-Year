class LendData<T> {
  LendData({
    this.id,
    this.identification_number,
    this.title,
    this.code,
    this.user_code,
    this.fullname,
    this.receipt_date,
    this.return_date,
    this.status,
    this.lend_status,
    this.return_status,
    this.metadata,
  });

  String? id;
  String? identification_number;
  String? title;
  String? code;
  String? user_code;
  String? fullname;
  String? receipt_date;
  String? return_date;
  String? status;
  String? lend_status;
  String? return_status;
  T? metadata;

  factory LendData.fromJson(
      Map<String, dynamic>? json, Function(Map<String, dynamic>) create) {
    return LendData<T>(
      id: json?["id"] == null ? null : json?["id"] as String,
      identification_number: json?["identification_number"] == null
          ? null
          : json?["identification_number"] as String,
      title: json?["title"] == null ? null : json?["title"] as String,
      code: json?["code"] == null ? null : json?["code"] as String,
      user_code:
          json?["user_code"] == null ? null : json?["user_code"] as String,
      fullname: json?["fullname"] == null ? null : json?["fullname"] as String,
      receipt_date: json?["receipt_date"] == null
          ? null
          : json?["receipt_date"] as String,
      return_date:
          json?["return_date"] == null ? null : json?["return_date"] as String,
      status: json?["status"] == null ? null : json?["status"] as String,
      lend_status:
          json?["lend_status"] == null ? null : json?["lend_status"] as String,
      return_status: json?["return_status"] == null
          ? null
          : json?["return_status"] as String,
      metadata: json?["metadata"] == null ? null : create(json?['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "identification_number": identification_number,
        "title": title,
        "code": code,
        "user_code": user_code,
        "fullname": fullname,
        "receipt_date": receipt_date,
        "return_date": return_date,
        "status": status,
        "lend_status": lend_status,
        "return_status": return_status,
        "metadata": metadata,
      };
}
