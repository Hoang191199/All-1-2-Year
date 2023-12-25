class Punishment {
  Punishment({
     this.forfeit,
     this.punishment_date,
     this.punishment_reason,
  });

  int? forfeit;
  String? punishment_date;
  String? punishment_reason;

  factory Punishment.fromJson(Map<String, dynamic>? json) {
    return Punishment(
        forfeit: json?["loss_date"] == null ? null : json?["loss_date"] as int,
        punishment_date: json?["loss_date"] == null ? null : json?["loss_date"] as String,
        punishment_reason: json?["loss_date"] == null ? null : json?["loss_date"] as String
    );
  }

  Map<String, dynamic> toJson() => {
    "forfeit": forfeit,
    "punishment_date": punishment_date,
    "punishment_reason": punishment_reason
  };
}