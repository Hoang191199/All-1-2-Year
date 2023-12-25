class ParticipantPC {
  ParticipantPC({this.pp_id, this.is_registered});

  String? pp_id;
  bool? is_registered;

  factory ParticipantPC.fromJson(Map<String, dynamic>? json) {
    return ParticipantPC(
      pp_id: json?["pp_id"] == null ? null : json?["pp_id"] as String,
      is_registered: json?["is_registered"] == null
          ? null
          : json?["is_registered"] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
        "pp_id": pp_id,
        "is_registered": is_registered,
      };
}
