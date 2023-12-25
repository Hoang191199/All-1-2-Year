class Details {
  Details({
    this.medicine_id,
    this.created_at,
    this.user_fullname,
  });

  String? medicine_id;
  String? created_at;
  String? user_fullname;


  factory Details.fromJson(Map<String, dynamic>? json) {
    return Details(
      medicine_id: json?["medicine_id"] == null ? null : json?['medicine_id'] as String,
      created_at: json?["created_at"] == null ? null : json?['created_at'] as String,
      user_fullname: json?["user_fullname"] == null ? null : json?['user_fullname'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'medicine_id': medicine_id,
    'created_at': created_at,
    'user_fullname': user_fullname,
  };
}
