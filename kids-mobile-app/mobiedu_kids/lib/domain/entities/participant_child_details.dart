import 'package:mobiedu_kids/domain/entities/participant_parent_details.dart';

class ParticipantChild {
  ParticipantChild(
      {this.child_id,
      this.child_name,
      this.birthday,
      this.gender,
      this.parent_phone,
      this.event_id,
      this.pp_type,
      this.pp_id,
      this.is_paid,
      this.created_at,
      this.created_user_id,
      this.created_fullname,
      this.child_status,
      this.parent});

  String? child_id;
  String? child_name;
  String? birthday;
  String? gender;
  String? parent_phone;
  String? event_id;
  String? pp_type;
  String? pp_id;
  String? is_paid;
  String? created_at;
  String? created_user_id;
  String? created_fullname;
  String? child_status;
  List<ParticipantParent>? parent;

  factory ParticipantChild.fromJson(Map<String, dynamic>? json) {
    return ParticipantChild(
      child_id: json?["child_id"] == null ? null : json?['child_id'] as String,
      child_name:
          json?["child_name"] == null ? null : json?['child_name'] as String,
      birthday: json?["birthday"] == null ? null : json?['birthday'] as String,
      gender: json?["gender"] == null ? null : json?['gender'] as String,
      parent_phone: json?["parent_phone"] == null
          ? null
          : json?['parent_phone'] as String,
      event_id: json?["event_id"] == null ? null : json?['event_id'] as String,
      pp_type: json?["pp_type"] == null ? null : json?['pp_type'] as String,
      pp_id: json?["pp_id"] == null ? null : json?['pp_id'] as String,
      is_paid: json?["is_paid"] == null ? null : json?['is_paid'] as String,
      created_at:
          json?["created_at"] == null ? null : json?['created_at'] as String,
      created_user_id: json?["created_user_id"] == null
          ? null
          : json?['created_user_id'] as String,
      created_fullname: json?["created_fullname"] == null
          ? null
          : json?['created_fullname'] as String,
      child_status: json?["child_status"] == null
          ? null
          : json?['child_status'] as String,
      parent: json?["parent"] == null
          ? null
          : List<ParticipantParent>.from(
              json?["parent"].map((x) => ParticipantParent.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "child_id": child_id,
        "child_name": child_name,
        "birthday": birthday,
        "gender": gender,
        "parent_phone": parent_phone,
        "event_id": event_id,
        "pp_type": pp_type,
        "pp_id": pp_id,
        "is_paid": is_paid,
        "created_at": created_at,
        "created_user_id": created_user_id,
        "created_fullname": created_fullname,
        "child_status": child_status,
        "parent": parent
      };
}
