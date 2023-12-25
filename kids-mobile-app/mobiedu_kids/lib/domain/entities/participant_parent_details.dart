class ParticipantParent {
  ParticipantParent(
      {this.user_id,
      this.user_name,
      this.user_fullname,
      this.user_gender,
      this.user_picture,
      this.event_id,
      this.is_paid,
      this.created_at,
      this.created_user_id,
      this.created_fullname});

  String? user_id;
  String? user_name;
  String? user_fullname;
  String? user_gender;
  String? user_picture;
  String? event_id;
  String? is_paid;
  String? created_at;
  String? created_user_id;
  String? created_fullname;

  factory ParticipantParent.fromJson(Map<String, dynamic>? json) {
    return ParticipantParent(
        user_id: json?["user_id"] == null ? null : json?['user_id'] as String,
        user_name:
            json?["user_name"] == null ? null : json?['user_name'] as String,
        user_fullname: json?["user_fullname"] == null
            ? null
            : json?['user_fullname'] as String,
        user_gender: json?["user_gender"] == null
            ? null
            : json?['user_gender'] as String,
        user_picture: json?["user_picture"] == null
            ? null
            : json?['user_picture'] as String,
        event_id:
            json?["event_id"] == null ? null : json?['event_id'] as String,
        is_paid: json?["is_paid"] == null ? null : json?['is_paid'] as String,
        created_at:
            json?["created_at"] == null ? null : json?['created_at'] as String,
        created_user_id: json?["created_user_id"] == null
            ? null
            : json?['created_user_id'] as String,
        created_fullname: json?["created_fullname"] == null
            ? null
            : json?['created_fullname'] as String);
  }

  Map<String, dynamic> toJson() => {
        "user_id": user_id,
        "user_name": user_name,
        "user_fullname": user_fullname,
        "user_gender": user_gender,
        "user_picture": user_picture,
        "event_id": event_id,
        "is_paid": is_paid,
        "created_at": created_at,
        "created_user_id": created_user_id,
        "created_fullname": created_fullname
      };
}
