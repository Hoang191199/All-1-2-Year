import 'package:mobiedu_kids/domain/entities/participant_old_pc.dart';

class ParticipantOld {
  ParticipantOld({
    this.olds,
  });

  ParticipantOldPC? olds;

  factory ParticipantOld.fromJson(Map<String, dynamic>? json) {
    return ParticipantOld(
      olds: json?["olds"] == null
          ? null
          : ParticipantOldPC.fromJson(json?['olds']),
    );
  }

  Map<String, dynamic> toJson() => {
        "olds": olds,
      };
}
